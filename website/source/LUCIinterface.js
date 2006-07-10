// Globals
// Major version of Flash required
var requiredMajorVersion = 8;
// Minor version of Flash required
var requiredMinorVersion = 0;
// Revision of Flash required
var requiredRevision = 0;
// the version of javascript supported
var jsVersion = 1.0;
// 

// Detect Client Browser type
var isIE  = (navigator.appVersion.indexOf("MSIE") != -1) ? true : false;
var isWin = (navigator.appVersion.toLowerCase().indexOf("win") != -1) ? true : false;
var isOpera = (navigator.userAgent.indexOf("Opera") != -1) ? true : false;
jsVersion = 1.1;
// JavaScript helper required to detect Flash Player PlugIn version information
function JSGetSwfVer(i){
	// NS/Opera version >= 3 check for Flash plugin in plugin array
	if (navigator.plugins != null && navigator.plugins.length > 0) {
		if (navigator.plugins["Shockwave Flash 2.0"] || navigator.plugins["Shockwave Flash"]) {
			var swVer2 = navigator.plugins["Shockwave Flash 2.0"] ? " 2.0" : "";
      		var flashDescription = navigator.plugins["Shockwave Flash" + swVer2].description;
			descArray = flashDescription.split(" ");
			tempArrayMajor = descArray[2].split(".");
			versionMajor = tempArrayMajor[0];
			versionMinor = tempArrayMajor[1];
			if ( descArray[3] != "" ) {
				tempArrayMinor = descArray[3].split("r");
			} else {
				tempArrayMinor = descArray[4].split("r");
			}
      		versionRevision = tempArrayMinor[1] > 0 ? tempArrayMinor[1] : 0;
            flashVer = versionMajor + "." + versionMinor + "." + versionRevision;
      	} else {
			flashVer = -1;
		}
	}
	// MSN/WebTV 2.6 supports Flash 4
	else if (navigator.userAgent.toLowerCase().indexOf("webtv/2.6") != -1) flashVer = 4;
	// WebTV 2.5 supports Flash 3
	else if (navigator.userAgent.toLowerCase().indexOf("webtv/2.5") != -1) flashVer = 3;
	// older WebTV supports Flash 2
	else if (navigator.userAgent.toLowerCase().indexOf("webtv") != -1) flashVer = 2;
	// Cant detect in all other cases
	else {
		
		flashVer = -1;
	}
	return flashVer;
} 
// If called with no parameters this function returns a floating point value 
// which should be the version of the Flash Player or 0.0 
// ex: Flash Player 7r14 returns 7.14
// If called with reqMajorVer, reqMinorVer, reqRevision returns true if that version or greater is available
function DetectFlashVer(reqMajorVer, reqMinorVer, reqRevision) 
{
 	reqVer = parseFloat(reqMajorVer + "." + reqRevision);
   	// loop backwards through the versions until we find the newest version	
	for (i=25;i>0;i=i-1) {	
		if (isIE && isWin && !isOpera) {
			versionStr = VBGetSwfVer(i);
		} else {
			versionStr = JSGetSwfVer(i);		
		}
		if (versionStr == -1 ) { 
			return false;
		} else if (versionStr != 0) {
			if(isIE && isWin && !isOpera) {
				tempArray         = versionStr.split(" ");
				tempString        = tempArray[1];
				versionArray      = tempString .split(",");				
			} else {
				versionArray      = versionStr.split(".");
			}
			versionMajor      = versionArray[0];
			versionMinor      = versionArray[1];
			versionRevision   = versionArray[2];
			
			versionString     = versionMajor + "." + versionRevision;   // 7.0r24 == 7.24
			versionNum        = parseFloat(versionString);
        	// is the major.revision >= requested major.revision AND the minor version >= requested minor
			if ( (versionMajor > reqMajorVer) && (versionNum >= reqVer) ) {
				return true;
			} else {
				return ((versionNum >= reqVer && versionMinor >= reqMinorVer) ? true : false );	
			}
		}
	}	
	return (reqVer ? false : 0.0);
}

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


function callMovie(movieName) { 
� �if (navigator.appName.indexOf("Microsoft") != -1) { 
� �� �return window[movieName] 
� �} else { 
� �� �return document[movieName] 
� �} 
}; 



var hasRightVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);
if(hasRightVersion) {  // if we've detected an acceptable version
    var oeTags = '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"'
    + 'width="100%" height="100%"'
    + 'codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">'
    + '<param name="movie" value="LUCIinterface.swf" /><param name="loop" value="false" /><param name="quality" value="high" /><param name="bgcolor" value="#ffffff" />'
    + '<embed src="LUCIinterface.swf" loop="false" quality="high" bgcolor="#ffffff" '
    + 'width="970px" height="600px" name="LUCIinterface" align="bottom"'
    + 'play="true"'
    + 'loop="false"'
    + 'quality="high"'
    + 'allowScriptAccess="sameDomain"'
    + 'type="application/x-shockwave-flash"'
    + 'pluginspage="http://www.macromedia.com/go/getflashplayer">'
    + '<\/embed>'
    + '<\/object>';
    document.write(oeTags);   // embed the flash movie
  } else {  // flash is too old or we can't detect the plugin
    var alternateContent = 'This site was designed for viewing with the Macromedia Flash Player.<br/>  <a href="http://www.macromedia.com/go/getflash/">Get Flash here</a>.<br/>  Alternatively we are working on a lightweight HTML version of the site <a href="http://luci.ics.uci.edu/lightweight">here</a>.';
    document.write(alternateContent);  // insert non-flash content
  }
