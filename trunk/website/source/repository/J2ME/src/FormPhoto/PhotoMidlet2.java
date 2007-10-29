/*
 * PhotoMidlet2.java
 *
 * Created on June 28, 2007, 2:56 PM
 */

package photopresence;

import javax.microedition.midlet.*;
import javax.microedition.lcdui.*;

/**
 *
 * @author  Nathan Esquenazi
 * @version
 */
public class PhotoMidlet2 extends MIDlet {
    PhotoForm pf = new PhotoForm();
    public void startApp() {
        Display.getDisplay(this).setCurrent(pf);
    }
    
    public void pauseApp() {
    }
    
    public void destroyApp(boolean unconditional) {
    }
}
