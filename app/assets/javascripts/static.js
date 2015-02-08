// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
// Check if the browser supports the File APIs
if (window.File && window.FileReader && window.FileList && window.Blob) {
} else {
  alert('The File APIs are not fully supported in this browser.');
}

function onChange(file) {
    document.getElementById("uploadFile").value = file;
}
function click() {
	$('#job_file').click();
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

