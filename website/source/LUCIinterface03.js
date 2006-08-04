//This function is used by ActionScript to see if it's launched from a browser
function jsAvailable() {
	return true;
}

function jsSetLocation(x) {
    window.location.hash = x;
}

function jsUpdateLocation(x,level) {
	var new = "";
	var y = window.location.hash.substring(1);
	while(level > 1){
		end = y.indexOf("&");
		if(end != -1){
			new = new + y.substring(0,end) + "&"; 
			y = y.substring(end+1);
			level = level -1;
		}
		else{
			new = new + y + "&";
			level = 1;
		}
	}
    window.location.hash = new + x;
}

function checkURLParameters() {
	var query = window.location.hash.substring(1);
	return query;
}

window.onload = function(){
	//callMovie().animateOpen(checkURLParameters());
	setTimeout("callMovie().animateOpen(checkURLParameters());",500);
}

