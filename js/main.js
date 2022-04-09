let flag = 0
const maxDist = 0.6
var canvasFace
var webcamFace
var dist = 1

const canvas = document.getElementById("output1")
const webcam = document.getElementById("webcam")
const photoBtn = document.getElementById("photoBtn")
const distResult = document.getElementById("distResult")
const onTabStatus = document.getElementById("1")
const isActiveStatus = document.getElementById("2")
const curStatus = document.getElementById("curStatus")
const model_url = './models'

async function loadModels() {
    await faceapi.loadTinyFaceDetectorModel(model_url)
    await faceapi.loadFaceRecognitionModel(model_url)
    await faceapi.loadFaceExpressionModel(model_url)
    await faceapi.loadFaceLandmarkTinyModel(model_url)
    console.log("Models are loaded")
}

async function updateCanvasResolution(settings) {
    canvas.width = settings.width
    canvas.height = settings.height
}

async function runVideo() {
    const constraints = { video: true }
    let stream = await navigator.mediaDevices.getUserMedia(constraints)
    let stream_settings = stream.getVideoTracks()[0].getSettings()
    webcam.srcObject = stream
    updateCanvasResolution(stream_settings)
}

async function setStatus(id) {
    switch (id) {
        case -1:
            curStatus.style.backgroundColor = "red"
            curStatus.innerHTML = "Face not Found"
            break
        case 0:
            curStatus.style.backgroundColor = "green"
            curStatus.innerHTML = "OK"
            break
        case 1:
            curStatus.style.backgroundColor = "red"
            curStatus.innerHTML = "Another person"
            break
        case 2:
            curStatus.style.backgroundColor = "red"
            curStatus.innerHTML = "several people in the video"
            break
        case 3:
            curStatus.style.backgroundColor = "red"
            curStatus.innerHTML = "Several people in the photo"
            break
    }
}

async function getDistance() {
    if (!flag) return

    webcamFace = await faceapi.
        detectAllFaces(webcam, new faceapi.TinyFaceDetectorOptions())
        .withFaceLandmarks(true)
        .withFaceDescriptors()

    if (canvasFace.length > 1) {
        setStatus(3)
    } else if (webcamFace.length > 1) {
        setStatus(2)
    } else if (webcamFace[0] && canvasFace[0]) {
        console.log(webcamFace[0])
        dist = await faceapi.euclideanDistance(webcamFace[0].descriptor, canvasFace[0].descriptor)
        distResult.innerHTML = dist.toFixed(3)
        if (dist < maxDist) { setStatus(0) } else { setStatus(1) }
    } else {
        setStatus(-1)
    }

}

window.addEventListener('load', function (event) {
    loadModels()
    runVideo()
    setInterval(getDistance, 500)
})

photoBtn.addEventListener('click', async function () {
    canvas.getContext('2d').drawImage(webcam, 0, 0, canvas.width, canvas.height)
    flag = 1
    canvasFace = await faceapi
        .detectAllFaces(canvas, new faceapi.TinyFaceDetectorOptions())
        .withFaceLandmarks(true)
        .withFaceDescriptors()
})

document.addEventListener('visibilitychange', function (event) {
    if (!document.hidden) {
        onTabStatus.innerHTML = "1"
    } else {
        onTabStatus.innerHTML = "0"
    }
})

window.addEventListener('focus', function (event) {
    isActiveStatus.innerHTML = "1"
})

window.addEventListener('blur', function (event) {
    isActiveStatus.innerHTML = "0"
})