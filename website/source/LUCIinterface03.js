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

