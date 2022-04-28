let flag = 0;
var canvasFace;
var webcamFace;
var dist = 1;

const canvas = document.getElementById("output1");
const webcam = document.getElementById("webcam");
const photoBtn = document.getElementById("photoBtn");
const distResult = document.getElementById("distResult");
const onTabStatus = document.getElementById("1");
const isActiveStatus = document.getElementById("2");
const isFullwindow = document.getElementById("3");
const curStatus = document.getElementById("curStatus");
const phoneStatus = document.getElementById("phoneStatus");
const headStatus = document.getElementById("headStatus");

const model_url = "models";
const tfPath = "models/best_web_model/model.json";

const maxDist = 0.6;

var canVideo = document.getElementById("canV");
var ctx = canVideo.getContext('2d');

var x1 = 0, y1 = 0, width = 0, height = 0;
var image, camera, model, input;


function getAngle(pos) {
    let x_nose = pos[33].x, y_nose = pos[33].y;
    let x_left = pos[2].x, y_left = pos[2].y;
    let x_right = pos[14].x, y_right = pos[14].y;
    let x_reye = pos[45].x, y_reye = pos[45].y;
    let x_leye = pos[36].x, y_leye = pos[36].y;
    let x_rmouse = pos[54].x, y_rmouse = pos[54].y;
    let x_lmouse = pos[48].x, y_lmouse = pos[48].y;

    let x_mid_eye = (x_reye + x_leye) / 2, y_mid_eye = (y_reye + y_leye) / 2;
    let x_mid_mouse = (x_rmouse + x_lmouse) / 2, y_mid_mouse = (y_rmouse + y_lmouse) / 2;
    let x_eye_mouse_mid = (x_mid_eye + x_mid_mouse) / 2, y_eye_mouse_mid = (y_mid_eye + y_mid_mouse) / 2;

    let mid_eye_mouse_dist = Math.hypot(x_mid_mouse - x_eye_mouse_mid, y_mid_mouse - y_eye_mouse_mid);
    let eye_mouse_dist = Math.hypot(x_mid_eye - x_mid_mouse, y_mid_eye - y_mid_mouse);
    let eye_nose_dist = Math.hypot(x_mid_eye - x_nose, y_mid_eye - y_nose);
    let mouse_nose_dist = Math.hypot(x_mid_mouse - x_nose, y_mid_mouse - y_nose);
    let nose_mouse_dist = Math.hypot(x_eye_mouse_mid - x_nose, y_eye_mouse_mid - y_nose);

    if (eye_nose_dist > mouse_nose_dist) nose_mouse_dist *= -1;

    let angle_yaxis = (nose_mouse_dist / mid_eye_mouse_dist) * 90;

    let lenght1 = Math.hypot(x_left - x_nose, y_left - y_nose);
    let length2 = Math.hypot(x_left - x_right, y_left - y_right);
    let lenght3 = Math.hypot(x_right - x_nose, y_right - y_nose);

    let x_left_right_mid = (x_right + x_left) / 2, y_left_right_mid = (y_right + y_left) / 2;

    let mid_nose_dist = Math.hypot(x_left_right_mid - x_nose, y_left_right_mid - y_nose);
    let right_nose_dist = Math.hypot(x_right - x_nose, y_right - y_nose);
    let left_nose_dist = Math.hypot(x_left - x_nose, y_left - y_nose);

    if (left_nose_dist < right_nose_dist) mid_nose_dist *= -1;

    let angle_xaxis = mid_nose_dist / length2 * 90 / 2;

    return [angle_yaxis, angle_xaxis];
}

async function loadModels() {
    await faceapi.loadTinyFaceDetectorModel(model_url);
    await faceapi.loadFaceRecognitionModel(model_url);
    await faceapi.loadFaceExpressionModel(model_url);
    await faceapi.loadFaceLandmarkTinyModel(model_url);
    console.log("Models are loaded");
}

async function updateCanvasResolution(settings) {
    canvas.width = settings.width;
    canvas.height = settings.height;
}

async function runVideo() {
    const constraints = {
        video: 1,
    }
    let stream = await navigator.mediaDevices.getUserMedia(constraints);
    let stream_settings = stream.getVideoTracks()[0].getSettings();
    webcam.srcObject = stream;
    updateCanvasResolution(stream_settings);
}

async function setStatus(id) {
    switch (id) {
        case -1:
            curStatus.style.backgroundColor = "red";
            curStatus.innerHTML = "Face not Found";
            break;
        case 0:
            curStatus.style.backgroundColor = "green";
            curStatus.innerHTML = "OK";
            break;
        case 1:
            curStatus.style.backgroundColor = "red";
            curStatus.innerHTML = "Another person";
            break;
        case 2:
            curStatus.style.backgroundColor = "red";
            curStatus.innerHTML = "several people in the video";
            break;
        case 3:
            curStatus.style.backgroundColor = "red";
            curStatus.innerHTML = "Several people in the photo";
            break;
    }
}


async function getDistance() {
    if (!flag) return;
    webcamFace = await faceapi.
        detectAllFaces(webcam, new faceapi.TinyFaceDetectorOptions())
        .withFaceLandmarks(true)
        .withFaceDescriptors();
    if (canvasFace.length > 1) {
        setStatus(3);
    } else if (webcamFace.length > 1) {
        setStatus(2);
    } else if (webcamFace[0] && canvasFace[0]) {
        var angle = getAngle(webcamFace[0].landmarks.positions);
        headStatus.innerHTML = angle.map(a => a.toFixed(3));
        dist = await faceapi.euclideanDistance(webcamFace[0].descriptor, canvasFace[0].descriptor);
        distResult.innerHTML = (1 - dist).toFixed(3);
        if (dist < maxDist) {
            setStatus(0);
        } else {
            setStatus(1);
        }
    } else {
        setStatus(-1);
    }

}

async function findSmarphone() {
    image = tf.browser.fromPixels(canVideo);
    input = tf.tidy(() => {
        return tf.image
            .resizeBilinear(image, [640, 640])
            .div(255.0).
            expandDims(0);
    })
    await model.executeAsync(input).then(res => {
        const [boxes, scores, classes, valid_detections] = res;
        const boxes_data = boxes.dataSync();
        const scores_data = scores.dataSync();
        const classes_data = classes.dataSync();
        const valid_detections_data = valid_detections.dataSync()[0];
        tf.dispose(res);

        if (!valid_detections_data) {
            smartphoneNotFound();
        }

        for (var i = 0; i < valid_detections_data; ++i) {
            [x1, y1, x2, y2] = boxes_data.slice(i * 4, (i + 1) * 4);
            x1 *= 640;
            x2 *= 640;
            y1 *= 480;
            y2 *= 480;
            width = x2 - x1;
            height = y2 - y1;
            const score = scores_data[i].toFixed(3);
            if (score >= 0.7) {
                phoneStatus.innerHTML = "Found ( " + score + " )";
            } else {
                smartphoneNotFound();
                phoneStatus.innerHTML = "Not Found";
            }
        }
    })
}

async function getStats() {
    await getDistance();
    await findSmarphone();
}

function smartphoneNotFound() {
    x1 = 0;
    y1 = 0;
    width = 0;
    height = 0;
}

function drawImge() {
    ctx.strokeStyle = "#00FFFF";
    ctx.lineWidth = 4;
    ctx.drawImage(webcam, 0, 0, 640, 480);
    ctx.strokeRect(x1, y1, width, height);
    setTimeout(drawImge, 100);
}

// Event Handlers
window.addEventListener('load', async function () {
    model = await tf.loadGraphModel(tfPath);
    checkFullwindow();
    await loadModels();
    await runVideo();
    webcam.hidden = true;
    setTimeout(drawImge, 300);
    setInterval(getStats, 1000);
})


window.addEventListener('focus', function () {
    isActiveStatus.innerHTML = "1";
})

window.addEventListener('blur', function () {
    isActiveStatus.innerHTML = "0";
})

function checkOnTab() {
    if (!document.hidden) {
        onTabStatus.innerHTML = "1";
    } else {
        onTabStatus.innerHTML = "0";
    }
}

function checkFullwindow() {
    if ((screen.width == window.innerWidth) && (window.screenX == 0) && (window.screenY == 0)) {
        isFullwindow.innerHTML = "1";
    } else {
        isFullwindow.innerHTML = "0";
    }
}

document.addEventListener('visibilitychange', checkOnTab);
window.addEventListener('resize', checkFullwindow);

photoBtn.addEventListener('click', async function () {
    canvas.getContext('2d').drawImage(webcam, 0, 0, canvas.width, canvas.height);
    flag = 1;
    canvasFace = await faceapi
        .detectAllFaces(canvas, new faceapi.TinyFaceDetectorOptions())
        .withFaceLandmarks(true)
        .withFaceDescriptors();
})