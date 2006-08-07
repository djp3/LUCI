//This function is used by ActionScript to see if it's launched from a browser
function jsAvailable() {
	return true;
}

function jsSetLocation(x) {
    window.location.hash = x;
}

function jsDebug(x) {
	var f = document.getElementById('textField');
	f.value = "Debug: "+x;
}

function jsUpdateLocation(x,level) {
	var newThing = "";
	var y = window.location.hash.substring(1);

	jsDebug("jsUpdateLocation called with: "+x + " " + level);
	while(level > 1){
		end = y.indexOf("&");
		if(end != -1){
			newThing = newThing + y.substring(0,end) + "&"; 
			y = y.substring(end+1);
			level = level -1;
		}
		else{
			newThing = newThing + y + "&";
			level = 1;
		}
	}
    window.location.hash = newThing + x;
}

function checkURLParameters() {
	var query = window.location.hash.substring(1);
	return query;
}

window.onload = function(){
	//callMovie().animateOpen(checkURLParameters());
	setTimeout("callMovie().animateOpen(checkURLParameters());",500);
}

