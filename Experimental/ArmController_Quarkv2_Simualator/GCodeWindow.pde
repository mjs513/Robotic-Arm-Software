/**
 Creates the code generator window
 */

public void createWindows() {
  //int[] col = {color(200,0,0), color(0,200,0), color(0,0,200) };
  int col;
  col = (128 << (0 * 8)) | 0xff000000;

  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);

  window = GWindow.getWindow(this, "G Code Generator", 0, 0, 600, 440, JAVA2D);
  window.addData(new MyWinData());
  ((MyWinData)window.data).col = col;
  window.noLoop();
  window.addDrawHandler(this, "windowDraw");
  window.addMouseHandler(this, "windowMouse");
  
  messageArea = new GTextArea(window, 40, 20, 340, 190, G4P.SCROLLBARS_BOTH);
  messageArea.setFont(new Font("Dialog", Font.PLAIN, 24));
  messageArea.setOpaque(true);
  messageArea.addEventHandler(this, "messageArea_change1");
  
  button111 = new GButton(window, 44, 226, 80, 30);
  button111.setText("Generate Code");
  button111.setTextBold();
  button111.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  button111.addEventHandler(this, "button111_click1");
  
  button222 = new GButton(window, 391, 290, 80, 30);
  button222.setText("Close Generator");
  button222.setTextBold();
  button222.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  
  button222.addEventHandler(this, "button222_click1");
  window.loop();
  window.setActionOnClose(GWindow.CLOSE_WINDOW);
 
}

//synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:window1:471012:
//  appc.background(230);
//} //_CODE_:window1:471012:

public void messageArea_change1(GTextArea source, GEvent event) { //_CODE_:textarea1:630546:
  println("textarea1 - GTextArea >> GEvent." + event + " @ " + millis());
} //_CODE_:textarea1:630546:

public void button111_click1(GButton source, GEvent event) { //_CODE_:button1:325055:
  //println("button1 - GButton >> GEvent." + event + " @ " + millis());
  
  Generator();
  
} //_CODE_:button1:325055:

public void button222_click1(GButton source, GEvent event) { //_CODE_:button2:218214:
  //println("button2 - GButton >> GEvent." + event + " @ " + millis());
  window.close();
  window = null;
} //_CODE_:button2:218214:


/**
 * Handles mouse events for ALL GWindow objects
 *  
 * @param appc the PApplet object embeded into the frame
 * @param data the data for the GWindow being used
 * @param event the mouse event
 */
public void windowMouse(PApplet appc, GWinData data, MouseEvent event) {
  MyWinData data2 = (MyWinData)data;
  switch(event.getAction()) {
  case MouseEvent.PRESS:
    data2.sx = data2.ex = appc.mouseX;
    data2.sy = data2.ey = appc.mouseY;
    data2.done = false;
    break;
  case MouseEvent.RELEASE:
    data2.ex = appc.mouseX;
    data2.ey = appc.mouseY;
    data2.done = true;
    break;
  case MouseEvent.DRAG:
    data2.ex = appc.mouseX;
    data2.ey = appc.mouseY;
    break;
  }
}

/**
 * Handles drawing to the windows PApplet area
 * 
 * @param appc the PApplet object embeded into the frame
 * @param data the data for the GWindow being used
 */
public void windowDraw(PApplet appc, GWinData data) {
  MyWinData data2 = (MyWinData)data;
  appc.background(data2.col);
  if (!(data2.sx == data2.ex && data2.ey == data2.ey)) {
    appc.stroke(255);
    appc.strokeWeight(2);
    appc.noFill();
    if (data2.done) {
      appc.fill(128);
    }
    appc.rectMode(CORNERS);
    appc.rect(data2.sx, data2.sy, data2.ex, data2.ey);
  }
}  

/**
 * Simple class that extends GWinData and holds the data 
 * that is specific to a particular window.
 * 
 * @author Peter Lager
 */
class MyWinData extends GWinData {
  int sx, sy, ex, ey;
  boolean done;
  int col;
}