/**
 Creates the code generator window
 */

public void createSimWindow() {
  //int[] col = {color(200,0,0), color(0,200,0), color(0,0,200) };
  int col;
  col = (128 << (0 * 8)) | 0xff000000;

  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);

  sim = GWindow.getWindow(this, "Arm Simulator", 10, 70, 1200, 600, JAVA2D);
  sim.addData(new MySimData());
  ((MySimData)sim.data).col = col;
  //sim.noLoop();
  sim.addDrawHandler(this, "simDraw");
  sim.addMouseHandler(this, "simMouse");

  btnCloseSim = new GButton(sim, 391, 290, 80, 30);
  btnCloseSim.setText("Close Sim");
  btnCloseSim.setTextBold();
  btnCloseSim.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  
  btnCloseSim.addEventHandler(this, "btnCloseSim_click1");

  sim.loop();
  sim.setActionOnClose(GWindow.CLOSE_WINDOW);
  
}

/**
 * Handles mouse events for ALL GWindow objects
 *  
 * @param appc the PApplet object embeded into the frame
 * @param data the data for the GWindow being used
 * @param event the mouse event
 */
public void simMouse(PApplet appc, GWinData data, MouseEvent event) {

}

/**
 * Handles drawing to the windows PApplet area
 * 
 * @param appc the PApplet object embeded into the frame
 * @param data the data for the GWindow being used
 */
public void simDraw(PApplet appc, GWinData data) {
  MySimData data2 = (MySimData)data;
   appc.background(32);
   appc.smooth();
   appc.lights(); 
   appc.directionalLight(51, 102, 126, -1, 0, 0);
   
   appc.translate(1200/1.5,600/1.5);
   appc.scale(-0.8);
   
   appc.fill(#FFE308);  
   appc.translate(0,0,0);
   appc.rotateX(-PI/2);
   //rotateZ(PI/4);
     //appc.shape(data2.base);
     appc.rect(30, 20, 55, 55, 7);

}  

/**
 * Simple class that extends GWinData and holds the data 
 * that is specific to a particular window.
 * 
 * @author Peter Lager
 */
class MySimData extends GWinData {
  PShape base, shoulder, elbow, foreArm, wristPitch, wristRoll;
  
  int sx, sy, ex, ey;
  boolean done;
  int col;
  
  //MySimData(){
     //base = loadShape("base.obj");
  //}

   
}

public void btnCloseSim_click1(GButton source, GEvent event) { //_CODE_:button2:218214:
  //println("button2 - GButton >> GEvent." + event + " @ " + millis());
  sim.close();
  sim = null;
} //_CODE_:button2:218214: