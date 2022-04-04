async function loadModels() {   
    const MODEL_URL = './Libs/face-api.js/weights'
    await faceapi.loadSsdMobilenetv1Model(MODEL_URL)
    await faceapi.loadFaceRecognitionModel(MODEL_URL)
    await faceapi.loadFaceExpressionModel(MODEL_URL)
    await faceapi.nets.faceLandmark68Net.loadFromUri(MODEL_URL)
    console.log("Models are loaded")
}

const video = document.getElementById("webcam");
const constraints = {
    video: true,
};
navigator.mediaDevices.getUserMedia(constraints).then((stream) => {
    video.srcObject = stream;
});

async function run(img, vid) {
    // console.log(webcam);
    getDistance(img, vid)
    setTimeout(async () => await this.run(), 1000)
}

window.addEventListener('load', function (event){
    loadModels()
    const image = document.getElementById("output1")
    const webcam = document.getElementById("webcam")
    run(image, webcam)
});

async function getDistance(img, vid) {
    const detections = await faceapi.detectSingleFace(webcam).withFaceLandmarks().withFaceExpressions().withFaceDescriptor()
    const image = document.getElementById("output1")
    const aboba = await faceapi.detectSingleFace(image).withFaceLandmarks().withFaceExpressions().withFaceDescriptor()
    // console.log(detections.descriptor)
    const dist = faceapi.euclideanDistance(detections.descriptor, aboba.descriptor)
    console.log(dist) // 10
}

var loadFile = async function (event, obj) {
    var output = document.getElementById(obj);
    output.src = URL.createObjectURL(event.target.files[0]);
};