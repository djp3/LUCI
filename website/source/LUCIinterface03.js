//This function is used by ActionScript to see if it's launched from a browser
function jsAvailable() {
	return true;
}

//function jsSetLocation(x) {
//    window.location.hash = x;
//}

function jsDebug(x) {
   	var foo = document.getElementById("form");
    var child = document.createElement("div");
	child.innerHTML = "Debug: "+x;
	foo.appendChild(child);
}

function jsUpdateLocation(x,level) {
	var newThing = "";
	var y = window.location.hash.substring(1);
	jsDebug("jsUpdateLocation called with: "+x + " " + level +" current: "+y);

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
	jsDebug("jsUpdateLocation TimeOut set");
}

function checkURLParameters() {
	var query = window.location.hash.substring(1);
	return query;
}

function jsStartFromActionScript(){
	jsDebug("jsStartFromActionScript called");
	callMovie().animateOpen(checkURLParameters());
	//setTimeout("callMovie().animateOpen(checkURLParameters());",500);
}

window.onload = function(){
	jsDebug("Onload called");
	//callMovie().animateOpen(checkURLParameters());
}

