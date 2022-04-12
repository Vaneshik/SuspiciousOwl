// const handler = tfn.io.fileSystem("./best_web_model/model.json");
const img = document.getElementById('img');
const webcam = document.getElementById('webcam');
const path = "./best_web_model/model.json"
async function load_model() {
    
    const model = await tf.loadGraphModel(path);
    return model;
}

async function runVideo() {
    const constraints = { video: true }
    let stream = await navigator.mediaDevices.getUserMedia(constraints)
    webcam.srcObject = stream
}

async function run() {
    const model = await tf.loadGraphModel(path);
    let camera = await tf.data.webcam(webcam);
    let image = await camera.capture();
    const prediction = await model.executeAsync(image);
    prediction.print();
    // image.print();
    // camera.stop();   
}
window.addEventListener('load', async function (event) {
    // runVideo()
    // const modelPromise = load_model()
    run()
    // setInterval(getDistance, 500)
})
