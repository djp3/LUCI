function callMovie() { 
	if (navigator.appName.indexOf('Microsoft') != -1) { 
		return window['LUCIinterfaceSafari'];
	}
	else { 
		if(document['LUCIinterfaceFirefox'].animateOpen == null){
			return(document['LUCIinterfaceSafari']);
		}
		else{
			return(document['LUCIinterfaceFirefox']);
		}
   } 
}; 
