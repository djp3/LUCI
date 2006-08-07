//This function is used by ActionScript to see if it's launched from a browser
function jsAvailable() {
	return true;
}

function jsSetLocation(x) {
    window.location.hash = x;
}

function jsDebug(x) {
	var f = document.getElementById('textField');
	f.value = "Debug called with: "+x;
}

function jsUpdateLocation(x,level) {
	var new = "";
	var y = window.location.hash.substring(1);

	var f = document.getElementById('textField')
	f.value = "Called with: "+x + " " + level;
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
	jsDebug("Onload called");
	setTimeout("callMovie().animateOpen(checkURLParameters());",500);
}

