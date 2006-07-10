function callMovie() { 
	if (navigator.appName.indexOf('Microsoft') != -1) { 
		if(window['LUCIinterfaceSafari'].animateOpen == null){
			jsUpdateAddress('null windows thing');
		}
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
