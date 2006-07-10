
var hasRightVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);
	// if we've detected an acceptable version
	if(hasRightVersion) { 
    var oeTags = 
	'<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"'
    + 'width="970px" height="580px"'
	+ 'id ="LUCIinterfaceSafari"'
    + 'allowScriptAccess="sameDomain"'
    + 'codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">'
    + '<param name="movie" value="LUCIinterface.swf" />'
	+ '<param name="loop" value="false" />'
	+ '<param name="quality" value="high" />'
	+ '<param name="bgcolor" value="#ffffff" />'
    + '<embed src="LUCIinterface.swf" loop="false" quality="high" bgcolor="#ffffff" '
    + 'width="970px" height="580px"'
	+ 'id ="LUCIinterfaceFirefox"'
	+ 'align="bottom"'
    + 'play="true"'
    + 'loop="false"'
    + 'quality="high"'
    + 'allowScriptAccess="sameDomain"'
    + 'type="application/x-shockwave-flash"'
    + 'pluginspage="http://www.macromedia.com/go/getflashplayer">'
    + '<\/embed>'
    + '<\/object>';
    document.write(oeTags);   // embed the flash movie
  } else {  
	// flash is too old or we can't detect the plugin
    var alternateContent = 'This site was designed for viewing with the Macromedia Flash Player.<br/>  <a href="http://www.macromedia.com/go/getflash/">Get Flash here</a>.<br/>  Alternatively we are working on a lightweight HTML version of the site <a href="http://luci.ics.uci.edu/lightweight">here</a>.';
    document.write(alternateContent);  // insert non-flash content
  }
