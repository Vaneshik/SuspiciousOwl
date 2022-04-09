function eye_on_mask(mask, side, shape) {
    points = [];
    for (let point in shape) {
        points.push(side[point]);
    }
    let points = nj.array(points, dtype = nj.int32());
    mask = cv.fillConvexPoly(mask, points, 255);
    let l = points[0][0];
    let t = (points[1][1] + points[2][1]) / 2;
    let r = points[3][0];
    let b = (points[4][1] + points[5][1]) / 2;
    return [mask, l, t, r, b];
}

function find_eyeball_position(end_points, cx, cy) {
    let x_ratio = (end_points[0] - cx) / (cx - end_points[2]);
    let y_ratio = (cy - end_points[1]) / (end_points[3] - cy);
    if (x_ratio > 3) {
        return 1;
    } else {
        if (x_ratio < 0.33) {
            return 2;
        } else {
            if (y_ratio < 0.33) {
                return 3;
            } else {
                return 0
            }
        }
    }
}

function contouring(thresh, mid, img, end_points, right = false) {
    let cnts = cv.findContours(thresh, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_NONE);
    try {
        let cnt = max(cnts, key = cv.contourArea);
        let M = cv.moments(cnt);
        let cx = Number(M['m10'] / M['m00']);
        let cy = Number(M['m01'] / M['m00']);
        if (right) {
            cx += mid
        }
        cv.circle(img, cx, cy, 4, 0, 0, 255, 2);
        let pos = find_eyeball_position(end_points, cx, cy);
        return pos;
    }
    catch {
        {}
    }
}

function process_thresh(thresh) {
    thresh = cv.erode(thresh, null, iterations = 2)
    thresh.substring(1)
    thresh = cv.dilate(thresh, null, iterations = 4)
    thresh.substring(1)
    thresh = cv.medianBlur(thresh, 3)
    thresh = cv.bitwise_not(thresh)
    return thresh
}

function print_eye_pos(img, left, right) {
    if ((left === right) && (left !== 0)) {
        let text = '';
        if (left === 1) {
            console.log('Looking left')
            let text = 'Looking left';
        }
        else {
            if (left === 2) {
                console.log('Looking right');
                let text = 'Looking right';
            }

            else {
                if (left === 3) {
                    console.log('Looking up');
                    let text = 'Looking up';
                }
            }

            let font = cv.FONT_HERSHEY_SIMPLEX;
            cv.putText(img, text, 30, 30, font,
                1, 0, 255, 255, 2, cv.LINE_AA);
                }
            }
    }

function get_face_detector(modelFile = null, configFile = null, quantized = false) {
    if (quantized) {
        if (modelFile === null) {
            modelFile = "models/opencv_face_detector_uint8.pb";
            modelFile.substring(1);
        }
        if (configFile === null) {
            configFile = "models/opencv_face_detector.pbtxt";
            configFile.substring(1);
        }
        let model = cv.dnn.readNetFromTensorflow(modelFile, configFile);
    }
    else {
        if (modelFile === null) {
            modelFile = "./models/res10_300x300_ssd_iter_140000.caffemodel";
        }
        if (configFile === null) {
            configFile = "./models/deploy.prototxt";
        }
        let model = cv.dnn.readNetFromCaffe(configFile, modelFile);
    }
    return model;
}

function get_landmark_model(saved_model = 'models/pose_model') {
    let model = tf.saved_model.load(saved_model);
    return model;
}

function find_faces(img, model) {
    let h, w = img.shape.slice(0, 2);
    let blob = cv.dnn.blobFromImage(cv.resize(img, 300, 300), 300, 300, 104, 177, 123);
    model.set(input(blob));
    let res = model.forward();
    let faces = [];
    for (let i = 0; i < res.shape[2]; i++) {
        let confidence = res[0, 0, i, 2];
        if (confidence > 0.5) {
            let box = res[0, 0, i, box.slice(3, 7)] * nj.array([w, h, w, h]);
            let box_int = box.astype("int");
            let x = box_int[0];
            let y = box_int[1];
            let x1 = box_int[2];
            let y1 = box_int[3];

            faces.append([x, y, x1, y1]);
        }
        return faces;
    }
}

let face_model = get_face_detector();
let landmark_model = get_landmark_model();
let left = [36, 37, 38, 39, 40, 41];
let right = [42, 43, 44, 45, 46, 47];

let cap = cv.VideoCapture(0);
let ret = cap[0];
let img = cap[1];
let thresh = img.copy();

cv.namedWindow('image')
let kernel = nj.ones(9, 9, nj.uint8);

function nothing(x) {
    {}
}
cv.createTrackbar('threshold', 'image', 75, 255);

function move_box(box, offset){
    let left_x = box[0] + offset[0];
    let top_y = box[1] + offset[1];
    let right_x = box[2] + offset[0];
    let bottom_y = box[3] + offset[1];
    return [left_x, top_y, right_x, bottom_y];
}

function get_squire_box(box){
    let left_x = box[0];
    let top_y = box[0];
    let right_x = box[2];
    let bottom_y = box[3];

    let box_width = right_x - left_x;
    let box_height = bottom_y - top_y;

    let diff = box_height - box_width;
    let delta = Number(Math.abs(diff) / 2);

    if (diff === 0){
        return box;
    }
    else{
        if (diff > 0){
            left_x -= delta;
            right_x += delta;
            if (diff % 2 === 1){
                right_x += 1;
            }
        }
    else {
    top_y -= delta;
    bottom_y += delta;
    if (diff % 2 === 1){
        bottom_y += 1;
    }}
    }
    console.assert(((right_x - left_x) === (bottom_y - top_y)), 'Box is not square');
    return [left_x, top_y, right_x, bottom_y];
}

function detect_marks(img, model, face) {
    let offset_y = Number(Math.abs((face[3] - face[1]) * 0.1));
    let box_moved = move_box(face, [0, offset_y]);
    let facebox = get_squire_box(box_moved);

    let h, w = img.shape.slice(0, 2);
    if (facebox[0] < 0) {
        facebox[0] = 0;
    }
    if (facebox[1] < 0) {
        facebox[1] = 0;
    }
    if (facebox[2] > w) {
        facebox[2] = w;
    }
    if (facebox[3] > h) {
        facebox[3] = h;
    }

    let face_img = img.slice(facebox[1], facebox[3]);
    face_img = cv.resize(face_img, 128, 128);
    face_img = cv.cvtColor(face_img, cv.COLOR_BGR2RGB);

    let predictions = model.signature["predict"](tf.constant([face_img], dtype = tf.uint8()));
    let marks = nj.array(predictions['output']).flatten().slice(0, 136);
    marks = nj.reshape(marks, -1, 2);

    marks *= (facebox[2] - facebox[0]);
    for (let i = 0; i < marks[0].length; i++) {
        marks[i][0] += facebox[0][i];
        marks[i][1] += facebox[1][i];
    }

    marks = marks.astype(nj.uint());
    return marks;
}

while (true) {
    let ret, img = cap.read();
    var rects = find_faces(img, face_model);
    for (let rect = 0; rect < rects; rect++) {
        let shape = detect_marks(img, landmark_model, rect);
        mask = nj.zeros(img.shape.slice(0, 2), dtype = nj.uint8);
        mask, end_points_left = eye_on_mask(mask, left, shape);
        mask, end_points_right = eye_on_mask(mask, right, shape);
        mask = cv.dilate(mask, kernel, 5);

        var eyes = cv.bitwise_and(img, img, mask = mask);
        var mask = (eyes = [0, 0, 0]).all(axis = 2);
        eyes[mask] = [255, 255, 255];
        var mid = Number(Math.floor(shape[42][0] + shape[39][0]) / 2);
        var eyes_gray = cv.cvtColor(eyes, cv.COLOR_BGR2GRAY);
        var threshold = cv.getTrackbarPos('threshold', 'image');
        thresh = cv.threshold(eyes_gray, threshold, 255, cv.THRESH_BINARY);
        thresh = process_thresh(thresh);

        var eyeball_pos_left = contouring(thresh.slice(0, mid), mid, img, end_points_left);
        var eyeball_pos_right = contouring(thresh.slice(mid,), mid, img, end_points_right, true);
        print_eye_pos(img, eyeball_pos_left, eyeball_pos_right);
    }
    cv.imshow('eyes', img);
    cv.imshow("image", thresh);
    if (cv.waitKey(1) && 0xFF === 113){
        break;
    }
}
cap.release()
cv.destroyAllWindows()