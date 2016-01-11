/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void slider1_change1(GSlider source, GEvent event) { //_CODE_:slider1:790724:
  //println("slider1 - GSlider event occured " + System.currentTimeMillis()%10000000 );
  //if(EnableArm == 1) {
  //  myPort.clear();
  //  myPort.write("0,"+slider1.getValueI()+"\n");
  //  acknowledge();
    
   if(EnableArm == 1) {
    myPort.clear();
    myPort.write("0,"+slider1.getValueI()+"\n");   
    acknowledge(); 
    
    GripperFixedPitch();    
    
    if(FKenable == 1)  updateFK();

  }

} //_CODE_:slider1:790724:


public void dropList1_click1(GDropList source, GEvent event) { //_CODE_:dropList1:697391:
  //println("dropList1 - GDropList event occured " + System.currentTimeMillis()%10000000 );
  int i = dropList1.getSelectedIndex();
  myPort.clear();
  myPort.stop();
  myPort = new Serial(this, Serial.list()[i], 9600); 
  //myPort.bufferUntil('\n');
} //_CODE_:dropList1:697391:


//Shouler Slider
public void slider2_change1(GSlider source, GEvent event) { //_CODE_:slider2:752459:
  // Shoulder
  //println("slider2 - GSlider event occured " + System.currentTimeMillis()%10000000 );
  //if(EnableArm == 1) {
    //println(slider2.getValueI());
    //myPort.clear();
    //myPort.write("1,"+slider2.getValueI()+"\n"); 
    //acknowledge();
   if(EnableArm == 1) {
      myPort.clear();
      myPort.write("1,"+slider2.getValueI()+"\n");   
      acknowledge();
    
    GripperFixedPitch();
    
    if(FKenable == 1)  updateFK();
      
   }
} //_CODE_:slider2:752459:


//Elbow Slider
public void slider3_change1(GSlider source, GEvent event) { //_CODE_:slider3:489757:
  //println("slider3 - GSlider event occured " + System.currentTimeMillis()%10000000 );
  //if(EnableArm == 1) {
  //  myPort.clear();
  // myPort.write("2,"+slider3.getValueI()+"\n"); 
  //  acknowledge();
  if(EnableArm == 1) {
    myPort.clear();
    myPort.write("2,"+slider3.getValueI()+"\n");  
    acknowledge();

    GripperFixedPitch();
    
    if(FKenable == 1)  updateFK();	
  } 
    
} //_CODE_:slider3:489757:

public void slider4_change1(GSlider source, GEvent event) { //_CODE_:slider4:801509:
  //println("slider4 - GSlider event occured " + System.currentTimeMillis()%10000000 );
  if(EnableArm == 1) {
    myPort.clear();
    myPort.write("3,"+ slider4.getValueI() + "\n"); 
    acknowledge();

    GripperFixedPitch();
  
    if(FKenable == 1)  updateFK();
  }
  
} //_CODE_:slider4:801509:

public void slider5_change1(GSlider source, GEvent event) { //_CODE_:slider5:834674:
  //println("slider5 - GSlider event occured " + System.currentTimeMillis()%10000000 );
  if(EnableArm == 1) {
    myPort.clear();
    myPort.write("4,"+slider5.getValueI()+"\n"); 
    acknowledge();

    GripperFixedPitch();    
    
    if(FKenable == 1)  updateFK();	

  }
} //_CODE_:slider5:834674:

public void slider2d1_change1(GSlider2D source, GEvent event) { //_CODE_:slider2d1:750043:
  //println("slider2d1 - GSlider2D event occured " + System.currentTimeMillis()%10000000 );
  float x = slider2d1.getValueXF();
  float y = slider2d1.getValueYF();
  float z = -d4;
  
  label5.setText(""+x);
  label6.setText(""+y);
  //float z = slider7.getValueI();
  int g = slider5.getValueI();
  float w = slider6.getValueI();
  Arm(x, y, z, g, w, 0);
} //_CODE_:slider2d1:750043:

public void slider6_change1(GSlider source, GEvent event) { //_CODE_:slider6:431756:
  //println("slider6 - GSlider event occured " + System.currentTimeMillis()%10000000 );
  if(EnableArm == 1) {
    myPort.clear();
    myPort.write("5,"+slider6.getValueI()+"\n"); 
    acknowledge();

    GripperFixedPitch();
     
    if(FKenable == 1)  updateFK();
    	
  }
} //_CODE_:slider6:431756:


public void button1_click1(GButton source, GEvent event) { //_CODE_:button1:289466:
  //selected_file="normalstance.csv";
  //PLAYBACK=true;
    if (!buttonBusy)  buttonClicked = true;
  else System.err.println("Button Busy! Still processing servo...");

  //buttonClick = true; // new boolean variable

} //_CODE_:button1:289466:


public void button2_click1(GButton source, GEvent event) { //_CODE_:button2:319793:
  //selected_file="sad.csv";
  //PLAYBACK=true;
  println("Coordinates saved to file");

  saveCoordinates();
  
} //_CODE_:button2:319793:

public void button3_click1(GButton source, GEvent event) { //_CODE_:button3:218967:
  //selected_file="recording.csv";
  //PLAYBACK=true;
  println("Close file"); //x to save and close file
  RECORD=false;
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  //exit(); // Stops the program
} //_CODE_:button3:218967:

public void button4_click1(GButton source, GEvent event) { //_CODE_:button4:923212:
  //println("button4 - GButton event occured " + System.currentTimeMillis()%10000000 );
  //myPort.clear();
  //myPort.write("8,0,100,0\n");
  //myPort.write("9,0,100,0\n");
  println("Open File for Playback"); //o for open file for playback
  selectInput("Select a file to playback:", "fileSelected");
  
} //_CODE_:button4:923212:

public void button5_click1(GButton source, GEvent event) { //_CODE_:button5:467161:
  //println("button5 - GButton event occured " + System.currentTimeMillis()%10000000 );
  //myPort.clear();
  //myPort.write("8,0,0,0\n");
  //myPort.write("9,0,0,0\n");
  println("Playback"); //p for playback
  PLAYBACK = true;
    
} //_CODE_:button5:467161:

public void button6_click1(GButton source, GEvent event) { //_CODE_:button6:927708:
  //println("button6 - GButton event occured " + System.currentTimeMillis()%10000000 );
  println("Record"); //r for record
  RECORD = true;
} //_CODE_:button6:927708:

public void button8_click1(GButton source, GEvent event) { //_CODE_:button7:386892:
  //println("button7 - GButton event occured " + System.currentTimeMillis()%10000000 );
  
  ScriptEnabled = 0;
  
  btnToggle2.setState(0);
  btnToggle3.setState(0);
  btnToggle4.setState(0);
  btnToggle5.setState(0);
  
  FixedAxis = Normal = Angled = Parallel = 0;
  
  //Reset arm to original position in set up
  q[0] = qi0 * deg2rad;
  q[1] = qi1 * deg2rad;
  q[2] = qi2 * deg2rad;
  q[3] = qi3 * deg2rad;
  q[4] = qi4 * deg2rad;
  q[5] = qi5 * deg2rad;
  
  slider6.setValue(qi5);  
  slider4.setValue(qi3);
  slider2.setValue(qi1);
  slider3.setValue(qi2);
  slider5.setValue(qi4);
  slider1.setValue(qi0);

  slider2d1.setValueXY(3.25292, 4.05959);  
  
} //_CODE_:button7:386892:

public void button7_click1(GButton source, GEvent event) { //_CODE_:button8:478806:
  println("button8 - GButton event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:button8:478806:

public void button9_click1(GButton source, GEvent event) { //_CODE_:button9:853082:
  println("button9 - GButton event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:button9:853082:

public void slider7_change1(GSlider source, GEvent event) { //_CODE_:slider7:768409:
  println("slider7 - GSlider event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:slider7:768409:

public void slider2d2_change1(GSlider2D source, GEvent event) { //_CODE_:slider2d2:606937:
  //println("slider2d2 - GSlider2D event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:slider2d2:606937:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  if(frame != null)
    frame.setTitle("Robot Arm Controller");

  //Base
  slider1 = new GSlider(this, 366, 15, 350, 75, 30.0);
  slider1.setShowValue(true);
  slider1.setShowLimits(true);
  slider1.setLimits(0.0, -80.0, 80.0);
  slider1.setEasing(10.0);
  slider1.setNumberFormat(G4P.INTEGER, 0);
  slider1.setOpaque(false);
  slider1.addEventHandler(this, "slider1_change1");

  labelBase = new GLabel(this, 520, 20, 75, 130);
  labelBase.setText("Base");
  labelBase.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  labelBase.setOpaque(false);

  dropList1 = new GDropList(this, 134, 9, 195, 243, 9);
  //dropList1.setItems(loadStrings("list_697391"), 0);
  dropList1.addEventHandler(this, "dropList1_click1");

  // Shoulder
  slider2 = new GSlider(this, 366, 92, 350, 75, 30.0);
  slider2.setShowValue(true);
  slider2.setShowLimits(true);
  slider2.setLimits(135.0, 10.0, 180.0);
  slider2.setEasing(10.0);
  slider2.setNumberFormat(G4P.INTEGER, 0);
  slider2.setOpaque(false);
  slider2.addEventHandler(this, "slider2_change1");

  labelShoulder = new GLabel(this, 520, 20, 75, 280);
  labelShoulder.setText("Shoulder");
  labelShoulder.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  labelShoulder.setOpaque(false);
  
  //Elbow
  slider3 = new GSlider(this, 366, 168, 350, 75, 30.0);
  slider3.setShowValue(true);
  slider3.setShowLimits(true);
  slider3.setLimits(-135.0, -160.0, 45.0);
  slider3.setEasing(10.0);
  slider3.setNumberFormat(G4P.INTEGER, 0);
  slider3.setOpaque(false);
  slider3.addEventHandler(this, "slider3_change1");

  labelElbow = new GLabel(this, 520, 20, 75, 430);
  labelElbow.setText("Elbow");
  labelElbow.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  labelElbow.setOpaque(false);
  
  //Wrist
  slider4 = new GSlider(this, 365, 244, 350, 75, 30.0);
  slider4.setShowValue(true);
  slider4.setShowLimits(true);
  slider4.setLimits(0, 0, 180);
  slider4.setEasing(10.0);
  slider4.setNumberFormat(G4P.INTEGER, 0);
  slider4.setOpaque(false);
  slider4.addEventHandler(this, "slider4_change1");

  labelWP = new GLabel(this, 520, 20, 75, 580);
  labelWP.setText("Wrist-Pitch");
  labelWP.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  labelWP.setOpaque(false);
  
  //Wrist Roll
  slider5 = new GSlider(this, 366, 321, 350, 75, 30.0);
  slider5.setShowValue(true);
  slider5.setShowLimits(true);
  slider5.setLimits(0.0, -90.0, 90.0);
  slider5.setEasing(10.0);
  slider5.setNumberFormat(G4P.INTEGER, 0);
  slider5.setOpaque(false);
  slider5.addEventHandler(this, "slider5_change1");

  labelWR = new GLabel(this, 520, 20, 75, 740);
  labelWR.setText("Wrist-Roll");
  labelWR.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  labelWR.setOpaque(false);

  slider2d1 = new GSlider2D(this, 26, 148, 305, 153);
  slider2d1.setLimitsX(3.2529, 0.0, 25.0);
  slider2d1.setLimitsY(4.0596, 0.0, 25.0);
  slider2d1.setNumberFormat(G4P.DECIMAL, 0);
  slider2d1.setOpaque(true);
  slider2d1.addEventHandler(this, "slider2d1_change1");

  label1 = new GLabel(this, 22, 9, 103, 27);
  label1.setText("Serial Port");
  label1.setTextBold();
  label1.setOpaque(true);
  
  label2 = new GLabel(this, 26, 313, 133, 20);
  label2.setText("Distance from origin:");
  label2.setTextBold();
  label2.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  label2.setOpaque(false);
  
  label3 = new GLabel(this, 96, 340, 56, 17);
  label3.setText("X(in):");
  label3.setTextBold();
  label3.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  label3.setOpaque(false);
  
  label4 = new GLabel(this, 72, 363, 80, 20);
  label4.setText("Z(in):");
  label4.setTextBold();
  label4.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  label4.setOpaque(false);
  
  label5 = new GLabel(this, 159, 340, 80, 20);
  label5.setText("0");
  label5.setOpaque(false);
  
  label6 = new GLabel(this, 158, 365, 80, 20);
  label6.setText("0");
  label6.setOpaque(false);
  
  //Gripper  
  slider6 = new GSlider(this, 366, 441, 350, 75, 30.0);
  slider6.setShowValue(true);
  slider6.setShowLimits(true);
  slider6.setLimits(0.0, 0, 10.0);
  slider6.setEasing(10.0);
  slider6.setNumberFormat(G4P.INTEGER, 0);
  slider6.setOpaque(false);
  slider6.addEventHandler(this, "slider6_change1");

  labelG = new GLabel(this, 520, 20, 75, 980);
  labelG.setText("Gripper");
  labelG.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  labelG.setOpaque(false);  
    
  //button1 = new GButton(this, 31, 540, 80, 30);
  button1 = new GButton(this, 745, 434, 80, 30);
  button1.setText("Script");
  button1.setTextBold();
  button1.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  button1.addEventHandler(this, "button1_click1");
  
  button2 = new GButton(this, 123, 541, 80, 30);
  button2.setText("Save Points");
  button2.setTextBold();
  button2.addEventHandler(this, "button2_click1");
  
  button3 = new GButton(this, 217, 542, 80, 30);
  button3.setText("Close FIle");
  button3.setTextBold();
  button3.addEventHandler(this, "button3_click1");
  
  button4 = new GButton(this, 431, 585, 80, 30);
  button4.setText("Open File");
  button4.setTextBold();
  button4.addEventHandler(this, "button4_click1");
  
  button5 = new GButton(this, 568, 585, 80, 30);
  button5.setText("Play Back");
  button5.setTextBold();
  button5.addEventHandler(this, "button5_click1");
  
  //button6 = new GButton(this, 745, 434, 80, 30);
  button6 = new GButton(this, 31, 540, 80, 30);
  button6.setText("Record");
  button6.setTextBold();
  //button6.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  button6.addEventHandler(this, "button6_click1");
  
  label9 = new GLabel(this, 173, 443, 115, 20);
  label9.setText("Enable FK");
  label9.setTextBold();
  label9.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  label9.setOpaque(false);
  
  button7 = new GButton(this, 839, 434, 80, 30);
  button7.setText("Face Text");
  button7.setTextBold();
  button7.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  button7.addEventHandler(this, "button7_click1");
  
  button8 = new GButton(this, 504, 538, 80, 30);
  button8.setText("Reset Arm");
  button8.setTextBold();
  button8.addEventHandler(this, "button8_click1");
  
  button9 = new GButton(this, 932, 435, 80, 30);
  button9.setText("Face text");
  button9.setTextBold();
  button9.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  button9.addEventHandler(this, "button9_click1");
  
  label8 = new GLabel(this, 99, 442, 80, 20);
  label8.setText("Enable Arm");
  label8.setTextBold();
  label8.setOpaque(false);
  

  slider7 = new GSlider(this, 822, 28, 100, 40, 10.0);
  slider7.setVisible(false);
  slider7.setLimits(0.5, 0.0, 1.0);
  slider7.setNumberFormat(G4P.DECIMAL, 2);
  slider7.setOpaque(false);
  slider7.addEventHandler(this, "slider7_change1");
  
  slider2d2 = new GSlider2D(this, 735, 144, 300, 150);
  slider2d2.setLimitsX(3.2529, 0.0, 25.0);
  slider2d2.setLimitsY(4.0596, 0.0, 25.0);
  slider2d2.setNumberFormat(G4P.DECIMAL, 5);
  slider2d2.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  slider2d2.setOpaque(true);
  slider2d2.addEventHandler(this, "slider2d2_change1");
  
  label7 = new GLabel(this, 113, 108, 84, 30);
  label7.setText("Inverse Kinematics");
  label7.setTextBold();
  label7.setOpaque(true);
  
  label10 = new GLabel(this, 794, 105, 143, 32);
  label10.setText("Forwad Kinematics");
  label10.setTextBold();
  label10.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label10.setOpaque(true);
  
  label11 = new GLabel(this, 740, 309, 124, 33);
  label11.setText("Distance from Origin:");
  label11.setTextBold();
  label11.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  label11.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label11.setOpaque(true);
  
  label12 = new GLabel(this, 786, 349, 80, 20);
  label12.setText("X (in):");
  label12.setTextBold();
  label12.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  label12.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label12.setOpaque(true);
  
  label13 = new GLabel(this, 786, 375, 80, 20);
  label13.setText("Z (in):");
  label13.setTextBold();
  label13.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  label13.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label13.setOpaque(true);
  
  label14 = new GLabel(this, 872, 351, 80, 20);
  label14.setText("0");
  label14.setTextBold();
  label14.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label14.setOpaque(true);
  
  label15 = new GLabel(this, 873, 376, 80, 21);
  label15.setText("0");
  label15.setTextBold();
  label15.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label15.setOpaque(true);
  
  labelFixedWP = new GLabel(this, 740, 560, 75, 35);;
  labelFixedWP.setText("Enable Fixed Axis");
  labelFixedWP.setTextBold();
  labelFixedWP.setOpaque(true);
  
  labelNorm = new GLabel(this, 810, 560, 70, 35);;
  labelNorm.setText("Normal");
  labelNorm.setTextBold();
  labelNorm.setOpaque(true);
  
  labelPara = new GLabel(this, 875, 560, 70, 35);;
  labelPara.setText("Parallel");
  labelPara.setTextBold();
  labelPara.setOpaque(true);

  label45 = new GLabel(this, 940, 560, 70, 35);;
  label45.setText("45 deg");
  label45.setTextBold();
  label45.setOpaque(true);

}

// Variable declarations 
// autogenerated do not edit
GSlider slider1; 
GDropList dropList1; 
GSlider slider2; 
GSlider slider3; 
GSlider slider4; 
GSlider slider5; 
GSlider2D slider2d1; 
GLabel label1; 
GLabel label2; 
GLabel label3; 
GLabel label4; 
GLabel label5; 
GLabel label6; 
GSlider slider6; 
GButton button1; 
GButton button2; 
GButton button3; 
GButton button4; 
GButton button5; 
GButton button6; 
GLabel label9; 
GButton button7; 
GButton button8; 
GButton button9; 
GLabel label8; 
GSlider slider7; 
GSlider2D slider2d2; 
GLabel label7; 
GLabel label10; 
GLabel label11; 
GLabel label12; 
GLabel label13; 
GLabel label14; 
GLabel label15; 
GLabel labelBase;
GLabel labelShoulder;
GLabel labelElbow;
GLabel labelWP;
GLabel labelWR;
GLabel labelG;
GLabel labelFixedWP;
GLabel labelNorm;
GLabel labelPara;
GLabel label45;