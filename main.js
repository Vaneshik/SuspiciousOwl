// document.addEventListener('visibilitychange', function (event) {
//     if (!document.hidden) {
//         document.getElementById("1").innerHTML = "1"
//         console.log("onTab: 1");
//     } else {
//         document.getElementById("1").innerHTML = "0";
//         console.log("onTab: 0");
//     }
// });

// window.addEventListener('focus', function (event) {
//     document.getElementById("2").innerHTML = "1";
//     console.log("isActive: 1");
// });

// window.addEventListener('blur', function (event) {
//     document.getElementById("2").innerHTML = "0";
//     console.log("isActive: 0");
// });


const video = document.getElementById("webcam");
const constraints = {
    video: true,
};

navigator.mediaDevices.getUserMedia(constraints).then((stream) => {
    video.srcObject = stream;
});

async function loadModels() {   
    const MODEL_URL = './face-api.js/weights'
    await faceapi.loadFaceLandmarkModel(MODEL_URL)
    await faceapi.loadFaceRecognitionModel(MODEL_URL)
    await faceapi.loadFaceExpressionModel(MODEL_URL)
    console.log("Models are loaded")
}

async function run() {
    
    setTimeout(async () => await this.run(), 1000)
}


window.addEventListener('load', function (event){
    loadModels()
    run()
});
// var loadFile = function (event, obj) {
//     var output = document.getElementById(obj);
//     output.src = URL.createObjectURL(event.target.files[0]);
// };

// let descriptors = { desc1: null, desc2: null }

// async function onSelectionChanged(which, uri) {
//     const input = await faceapi.fetchImage(uri)
//     const imgEl = $(`#output${which}`).get(0)
//     imgEl.src = input.src
//     let a = await faceapi.detectSingleFace(input)
//     console.log(a)
//     descriptors[`desc${which}`] = await faceapi.detectSingleFace(imgEl, new faceapi.TinyFaceDetectorOptions()).withFaceLandmarks().withFaceDescriptor()
//     // descriptors[`desc${which}`] = await faceapi.computeFaceDescriptor(input)
// }

// async function updateResults() {
//     const distance = faceapi.utils.round(
//         faceapi.euclideanDistance(descriptors.desc1, descriptors.desc2)
//     )
//     console.log(distance)
// }

// async function run() {
//     await faceapi.loadFaceRecognitionModel("/face-api.js/weights")
//     await faceapi.nets.ssdMobilenetv1.loadFromUri('/face-api.js/weights')
//     await faceapi.nets.faceLandmark68Net.loadFromUri('/face-api.js/weights')
//     const uri1 = document.getElementById("output1").src;
//     const uri2 = document.getElementById("output2").src;
//     await onSelectionChanged(1, uri1)
//     await onSelectionChanged(2, uri2)
// }

// let calcDist = function (event) {
//     updateResults()
// }

// const imgEle = document.createElement('img');
// imgEle.src = '/reference.jpg'
// const  reference =
// const result = await faceapi.detectSingleFace(videoEl, options).withFaceLandmarks().withFaceDescriptor()
// if (result) {
//     const faceMatcher = new faceapi.FaceMatcher(result)
//     drawLandmarks(videoEl, $('#overlay').get(0), [result], withBoxes)

//     if (reference) {
//        const bestMatch = faceMatcher.findBestMatch(reference.descriptor)
//        console.log(bestMatch)
//      }
// }