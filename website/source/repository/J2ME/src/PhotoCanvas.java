import java.io.IOException;
import javax.microedition.lcdui.*;
/*
 * PhotoCanvas.java
 *
 * Created on June 28, 2007, 12:49 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/**
 *
 * @author Nathan Esquenazi
 */
public class PhotoCanvas extends Canvas implements CommandListener {
    
    /** Creates a new instance of PhotoCanvas */
    public PhotoCanvas() {
        this.setTitle("Canvas Photo");
        this.setCommandListener(this);
    }

    protected void paint(Graphics g) {
        try {
            g.drawImage(Image.createImage("/patterson.jpg"), 0, 0, Graphics.TOP | Graphics.LEFT);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
    
    protected void keyPressed(int keycode)
    {
        System.out.println(keycode);
    }

    public void commandAction(Command command, Displayable displayable) {
    }
    
}
