/*
 * PhotoForm.java
 *
 * Created on June 28, 2007, 2:56 PM
 */

package photopresence;

import java.io.IOException;
import javax.microedition.lcdui.*;

/**
 *
 * @author  Nathan Esquenazi
 * @version
 */
public class PhotoForm extends Form implements CommandListener, ItemStateListener {
    Ticker tickTitle = new Ticker("");
    Command cmdExit = new Command("Exit", Command.EXIT, 1);
    Command cmdOK = new Command("Exit", Command.OK, 1);
    private void initializeForm() {
        this.setCommandListener(this);
        this.addCommand(cmdExit);
        this.addCommand(cmdOK);
        this.setItemStateListener(this);
        this.setTitle("PresencePhoto");
        this.setTicker(tickTitle);
        tickTitle.setString("PresencePhoto");
        Image patterson = null;
        try {
            patterson = Image.createImage("/patterson.jpg");
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        ImageItem patterson_img = new ImageItem("Patterson", patterson, Item.LAYOUT_CENTER | Item.LAYOUT_CENTER, "Patterson");
        append(patterson_img);
    }
    public void itemStateChanged(Item item) {
         System.out.println(item.getLabel());
    }
    
    public void commandAction(Command command, Displayable displayable) {
        System.out.println(command.getLabel());
    }
    
    /**
     * constructors
     */
    
    public PhotoForm() {
        this("");
        try {
            initializeForm();
        } catch (Exception e) {
        }
    }
    
    public PhotoForm(String p1, Item[] p2) {
        super(p1, p2);
    }
    
    
    public PhotoForm(String p1) {
        super(p1);
    }
    
    
    
}
