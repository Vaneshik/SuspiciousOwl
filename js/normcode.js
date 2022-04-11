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
    cv.dilate(mask, mask, cv.Mat.ones(9, 9, cv.CV_8UC1), new cv.Point(5, 5))
    var eyes = new cv.Mat()
    cv.bitwise_and(img, img, eyes, mask)

    console.log(eyes.rows + " " + eyes.cols)
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

    cv.cvtColor(eyes, eyes, cv.COLOR_BGR2GRAY)
    cv.threshold(eyes, eyes, 75, 255, cv.THRESH_BINARY)
    cv.imshow("canvasOutput", eyes)
}
function process_thresh(thresh) {
    cv2.erode(thresh, thresh, new cv.Mat.zeros(3, 3), cv.CV_8UC1, new cv.Point(-1, -1), 2)
    cv2.dilate(thresh, thresh, new cv.Mat.zeros(3, 3), cv.CV_8UC1, new cv.Point(-1, -1), 4)
    cv2.medianBlur(thresh, thresh, 3)
    cv2.bitwise_not(thresh, thresh)
}
window.addEventListener('load', async function (event) {
    await loadModels()
    runVideo()
    setInterval(main, 500)
})

