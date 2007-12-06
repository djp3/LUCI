function callMovie() { 
	if (navigator.appName.indexOf('Microsoft') != -1) { 
		return window['LUCIInterface'];
	}
	else { 
		if(document['LUCIInterface'].animateOpen == null){
			return(document['LUCIInterface']);
		}
		else{
			return(document['LUCIInterface']);
		}
	} 
}; 
