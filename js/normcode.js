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


    var dst = new cv.Mat()
    var points_left = webcamFace.landmarks.getLeftEye()
    var points_right = webcamFace.landmarks.getRightEye()

    var mask = cv.Mat.zeros(height, width, cv.CV_8UC1)
    eye_on_mask(mask, points_left)
    eye_on_mask(mask, points_right)
    cv.dilate(mask, mask, cv.Mat.ones(9, 9, cv.CV_8UC1), new cv.Point(5, 5))
    // cv.bitwise_and(img, img, mask)
    img.copyTo(dst, mask)
    cv.cvtColor(dst, dst, cv.COLOR_BGR2GRAY)
    var dest = new cv.Mat()
    var f = 77
    cv.threshold(dst, dest, f , 255, cv.THRESH_BINARY)
    // console.log(dest)
    // cv.erode(dest, dest, cv.Mat.ones(3, 3, cv.CV_8UC1), new cv.Point(-1, -1), 2)
    // cv.dilate(dest, dest, cv.Mat.ones(3, 3, cv.CV_8UC1), new cv.Point(-1, -1), 4)
    // cv.erode(dest, dest, new cv.Mat.ones(3, 3, cv.CV_8UC1), new cv.Point(-1, -1), 2)
    // cv.dilate(dest, dest, new cv.Mat.ones(3, 3, cv.CV_8UC1), new cv.Point(-1, -1), 4)
    // cv.medianBlur(dest, dest, 3)
    // cv.bitwise_not(dest, dest)
    cv.imshow("canvasOutput", dest)

    // var dst = new cv.Mat()
    // img.copyTo(dst, mask)
    // cv.cvtColor(dst, dst, cv.COLOR_BGR2GRAY)
    // cv.imshow("canvasOutput", dst) // canvasOutput is the id of another <canvas>;
    // kernel = cv.Mat.ones(9, 9, cv.CV_8UC1)
    // var maskDst = new cv.Mat();
    // cv.dilate(mask, maskDst, kernel, new cv.Point(-1, -1), 5)
    // var eyes = new cv.Mat();
    // cv.bitwise_and(img, img, eyes, maskDst) 
    // mask = (eyes == [0, 0, 0]).all(axis = 2)
    // eyes[mask] = [255, 255, 255]
    // let dst = new cv.Mat(height, width, cv.CV_8UC1)
    // eyes_gray = cv.cvtColor(eyes, dst, cv.COLOR_BGR2GRAY)
    // cv.imshow("canvasOutput", eyes) // canvasOutput is the id of another <canvas>;
}
// function processVideo() {
//     canvas.width = width
//     canvas.height = height
//     let context = canvas.getContext("2d")
//     let src = new cv.Mat(height, width, cv.CV_8UC4)
//     let dst = new cv.Mat(height, width, cv.CV_8UC1)
//     context.drawImage(webcam, 0, 0, canvas.width, canvas.height)
//     src.data.set(context.getImageData(0, 0, canvas.width, canvas.height).data);
//     cv.cvtColor(src, dst, cv.COLOR_BGR2GRAY);
//     cv.imshow("canvasOutput", dst); // canvasOutput is the id of another <canvas>;
// }

window.addEventListener('load', async function (event) {
    await loadModels()
    runVideo()
    setInterval(main, 500)
})

