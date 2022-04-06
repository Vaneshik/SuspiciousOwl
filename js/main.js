let flag = 0;
const maxDist = 0.6;
var canvasFace;
var webcamFace;
var dist = 1;

const canvas = document.getElementById("output1");
const webcam = document.getElementById("webcam");
const photoBtn = document.getElementById("photoBtn");
const distResult = document.getElementById("distResult");
const onTabStatus = document.getElementById("1");
const isActiveStatus = document.getElementById("2");
const model_url = './models';

const curStatus = document.getElementById("curStatus");

async function loadModels() {
    await faceapi.loadSsdMobilenetv1Model(model_url);
    await faceapi.loadFaceRecognitionModel(model_url);
    await faceapi.loadFaceExpressionModel(model_url);
    await faceapi.nets.faceLandmark68Net.loadFromUri(model_url);
    console.log("Models are loaded");
};

async function updateCanvasResolution(settings) {
    canvas.width = settings.width;
    canvas.height = settings.height;
};

async function runVideo() {
    const constraints = { video: true };
    let stream = await navigator.mediaDevices.getUserMedia(constraints);
    let stream_settings = stream.getVideoTracks()[0].getSettings();
    webcam.srcObject = stream;
    updateCanvasResolution(stream_settings);
};

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
    }
};

async function getDistance() {
    if (!flag) {
        return 0;
    }
    try {
        webcamFace = await faceapi.detectSingleFace(webcam).withFaceLandmarks().withFaceExpressions().withFaceDescriptor();
        canvasFace = await faceapi.detectSingleFace(canvas).withFaceLandmarks().withFaceExpressions().withFaceDescriptor();
        dist = faceapi.euclideanDistance(webcamFace.descriptor, canvasFace.descriptor);
        distResult.innerHTML = dist.toFixed(3);
        if (dist < maxDist) {
            setStatus(0);
        } else {
            setStatus(1);
        }
    } catch (err) {
        console.log("Face not Found (" + err + ")");
        setStatus(-1);
    }
};

async function run() {
    getDistance();
    setTimeout(async () => await this.run(), 500);
};

window.addEventListener('load', function (event) {
    loadModels();
    runVideo();
    run();
});

photoBtn.addEventListener('click', function () {
    canvas.getContext('2d').drawImage(webcam, 0, 0, canvas.width, canvas.height);
    flag = 1;
});

document.addEventListener('visibilitychange', function (event) {
    if (!document.hidden) {
        onTabStatus.innerHTML = "1";
    } else {
        onTabStatus.innerHTML = "0";
    }
});

window.addEventListener('focus', function (event) {
    isActiveStatus.innerHTML = "1";
});

window.addEventListener('blur', function (event) {
    isActiveStatus.innerHTML = "0";
});