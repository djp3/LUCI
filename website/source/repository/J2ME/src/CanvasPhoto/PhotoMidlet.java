/*
 * PhotoMidlet.java
 *
 * Created on June 28, 2007, 12:48 PM
 */

import javax.microedition.midlet.*;
import javax.microedition.lcdui.*;

/**
 *
 * @author  Nathan Esquenazi
 * @version
 */
public class PhotoMidlet extends MIDlet {
    PhotoCanvas pc = new PhotoCanvas();
    public void startApp() {
        Display.getDisplay(this).setCurrent(pc);
    }
    
    public void pauseApp() {
    }
    
    public void destroyApp(boolean unconditional) {
    }
}
