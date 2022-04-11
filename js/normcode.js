const model_url = './models'
const webcam = document.getElementById("webcam")
const canvas = document.getElementById("output1")
var width
var height

async function loadModels() {
    await faceapi.loadTinyFaceDetectorModel(model_url)
    await faceapi.loadFaceRecognitionModel(model_url)
    await faceapi.loadFaceExpressionModel(model_url)
    await faceapi.loadFaceLandmarkTinyModel(model_url)
    console.log("Models are loaded")
}

async function runVideo() {
    let stream = await navigator.mediaDevices.getUserMedia({ video: true })
    var stream_settings = stream.getVideoTracks()[0].getSettings()
    webcam.srcObject = stream
    width = stream_settings.width
    height = stream_settings.height
}

function eye_on_mask(mask, points) {
    var q = []
    for (var i = 0; i < points.length; i++) {
        q.push(Math.floor(points[i].x))
        q.push(Math.floor(points[i].y))
    }
    var trash = cv.matFromArray(6, 2, cv.CV_32SC1, q)
    cv.fillConvexPoly(mask, trash, new cv.Scalar(255))
}

async function main() {
    webcamFace = await faceapi
        .detectSingleFace(webcam, new faceapi.TinyFaceDetectorOptions())
        .withFaceLandmarks(1)

    canvas.width = width
    canvas.height = height
    var context = canvas.getContext("2d")
    var img = new cv.Mat(height, width, cv.CV_8UC4)
    context.drawImage(webcam, 0, 0, canvas.width, canvas.height)
    img.data.set(context.getImageData(0, 0, canvas.width, canvas.height).data);

    var points_left = webcamFace.landmarks.getLeftEye()
    var points_right = webcamFace.landmarks.getRightEye()

    var mask = cv.Mat.zeros(height, width, cv.CV_8UC1)
    eye_on_mask(mask, points_left)
    eye_on_mask(mask, points_right)
    // cv.dilate(mask, mask, cv.Mat.ones(9, 9, cv.CV_8UC1), new cv.Point(7, 7))

    var eyes = new cv.Mat()
    var mid = Math.floor((points_left[3][0] + points_left[0][0]) / 2)
    cv.bitwise_and(img, img, eyes, mask)
    black2white(eyes)
    cv.cvtColor(eyes, eyes, cv.COLOR_BGR2GRAY)
    var thresh = new cv.Mat()
    let val = document.getElementById('trackbar').value
    cv.threshold(eyes, thresh, parseInt(val), 255, cv.THRESH_BINARY)
    process_thresh(thresh)
    cv.imshow("canvasOutput", thresh)

    // var qqq = thresh.clone().data
    // contouring(thresh, mid, img)
    // var eyeball_pos_left = contouring(thresh[:, 0:mid], mid, img, end_points_left)
    // var eyeball_pos_right = contouring(thresh[:, mid:], mid, img, end_points_right, true)    
}

function contouring(thresh, mid, img) {
    let contours = new cv.MatVector();
    let hierarchy = new cv.Mat();
    cv.findContours(thresh, contours, hierarchy, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_NONE)
    // contours.sort((a, b) => cv.contourArea(a) < cv.contourArea(b) ? 1 : -1)
    // var cnt = contours.get(0);
    // console.log(cnt)
    // M = cv.moments(cnt)
    // cx = Math.floor(M.m10 / M.m00)
    // cy = Math.floor(M.m01 / M.m00)
    // if (right) {
    //     cx += mid
    // }
    cv.imshow("canvasOutput", hierarchy)
    // pos = find_eyeball_position(end_points, cx, cy)
    // return pos
}

function find_eyeball_position(end_points, cx, cy) {
    x_ratio = (end_points[0] - cx) / (cx - end_points[2])
    y_ratio = (cy - end_points[1]) / (end_points[3] - cy)
    if (x_ratio > 3) {
        return 1
    } else if (x_ratio < 0.33) {
        return 2
    } else if (y_ratio < 0.33) {
        return 3
    } else {
        return 0
    }
}

function black2white(eyes) {
    for (var row = 0; row < eyes.rows; row++) {
        for (var col = 0; col < eyes.cols; col++) {
            let pixel = eyes.ucharPtr(row, col);
            if (pixel[0] == 0 && pixel[1] == 0 && pixel[2] == 0) {
                pixel[0] = 255
                pixel[1] = 255
                pixel[2] = 255
            }
        }
    }
}

function process_thresh(thresh) {
    cv.erode(thresh, thresh, new cv.Mat.ones(3, 3, cv.CV_8UC1), new cv.Point(-1, -1), 2)
    cv.dilate(thresh, thresh, new cv.Mat.ones(3, 3, cv.CV_8UC1), new cv.Point(-1, -1), 4)
    cv.medianBlur(thresh, thresh, 3)
    cv.bitwise_not(thresh, thresh)
}

window.addEventListener('load', async function (event) {
    await loadModels()
    runVideo()
    setInterval(main, 200)
})

