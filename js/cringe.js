// const handler = tfn.io.fileSystem("./best_web_model/model.json");
const img = document.getElementById('img');
const webcam = document.getElementById('webcam');
const path = "./best_web_model/model.json"
var canvas = document.getElementById("canV");
var ctx = canvas.getContext('2d')
var x1 = 0, y1 = 0, width = 0, height = 0
var image, camera, model, input

// async function load_model() {
//     const model = await tf.loadGraphModel(path);
//     return model;
// }

async function runVideo() {
    const constraints = { video: 1 }
    let stream = await navigator.mediaDevices.getUserMedia(constraints)
    // let stream_settings = stream.getVideoTracks()[0].getSettings()
    // console.log([stream_settings.width, stream_settings.height])
    webcam.srcObject = stream
}

async function run() {
    // image = await camera.capture()
    image = tf.browser.fromPixels(canvas)
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
        tf.dispose(res)


        if (!valid_detections_data) {
            smartphoneNotFound()
        }

        for (var i = 0; i < valid_detections_data; ++i) {
            ctx.strokeStyle = "#00FFFF";
            ctx.lineWidth = 4;
            [x1, y1, x2, y2] = boxes_data.slice(i * 4, (i + 1) * 4);
            x1 *= 640
            x2 *= 640
            y1 *= 480
            y2 *= 480
            width = x2 - x1;
            height = y2 - y1;
            const score = scores_data[i].toFixed(2);
            if (score >= 0.57) {
                ctx.strokeRect(x1, y1, width, height);
            } else {
                smartphoneNotFound()
            }
        }
    });
}

function smartphoneNotFound() {
    x1 = 0
    y1 = 0
    width = 0
    height = 0
    console.log("Smartphone not found")
}

function drawImge() {
    ctx.drawImage(webcam, 0, 0, 640, 480)
    ctx.strokeRect(x1, y1, width, height);
    setTimeout(drawImge, 100);
}

window.addEventListener('load', async function (event) {
    model = await tf.loadGraphModel(path)
    // camera = await tf.data.webcam(webcam, { resizeWidth: 640, resizeHeight: 640 })
    runVideo()
    setTimeout(drawImge, 300);
    setInterval(run, 1000)
})
