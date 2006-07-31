//This function is used by ActionScript to see if it's launched from a browser
function jsAvailable() {
	return true;
}

function jsUpdateAddress(x) {
    window.location.hash = x;
}

function checkURLParameters() {
	var query = window.location.hash.substring(1);
	return query;
}

window.onload = function(){
	//callMovie().animateOpen(checkURLParameters());
	setTimeout("callMovie().animateOpen(checkURLParameters());",500);
}

