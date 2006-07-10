function jsUpdateAddress(x) {
	var f = document.getElementById('debugText');
	f.value=x;
    //window.location.hash = x;
}

function checkURLParameters() {
	var query = window.location.hash.substring(1);
	//var f = document.getElementById('debugText');
	//f.value=query;
	return query;
}

