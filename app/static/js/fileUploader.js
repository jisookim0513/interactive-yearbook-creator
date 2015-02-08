// Check if the browser supports the File APIs
if (window.File && window.FileReader && window.FileList && window.Blob) {
} else {
  alert('The File APIs are not fully supported in this browser.');
}

function onLoad() {
    document.getElementById('fileInput').click();
}

function handleFiles(files) {
    var file = files[0];
    document.getElementById('fileStatus').innerHTML = file.name;
    var reader = new FileReader();
    reader.onload = onFileReadComplete;
}
  
function onFileReadComplete(event) { 
  alert("upload completed!")
}