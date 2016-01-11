/*********************************************************************
 *
 * Based on "Robotic Arm with Arduino driver controlled by Leap Motion"
 * by bborncr at http://letsmakerobots.com/node/38673
 * Severely modified for this project by Michael Smorto, MJS.
 *
 * Inverse kinematics based on technique outlined by Travis Wolf
 * "Operational space control of 6DOF robot arm with spiking cameras 
 *  part 2: Deriving the Jacobian",
 * https://studywolf.wordpress.com/2015/06/27/
 *         operational-space-control-of-6dof-robot-arm-with-spiking-cameras-part-2-deriving-the-jacobian/
 *
 *  "A bare-bones collection of static methods for manipulating
 *  matrices." Downloaded from: www.physics.unlv.edu/~pang/cp2/html
 *  Modified and added to by MJS for this project
 *
 **********************************************************************/


// Need G4P library
import g4p_controls.*;
import processing.serial.*;

Serial myPort;
String s="";
// Serial port state.
Serial       port;
String       buffer = "";
final String serialConfigFile = "serialconfig.txt";
PImage crciberneticalogo;

float deg2rad = 3.14159/180.;
float rad2deg = 180./3.14159;

//float q[0], q[1], q[2], q[3], q[4], q[5];
float c1, c2, c3, c4, c5, c6, s1, s2, s3, s4, s5, s6;
float nx, ny, nz, sx, sy, sz, ax, ay, az, px, py, pz;
float nx0, ny0, nz0, sx0, sy0, sz0, ax0, ay0, az0, px0, py0, pz0;
float nx1, ny1, nz1, sx1, sy1, sz1, ax1, ay1, az1, px1, py1, pz1;
float a1, a2, a3, a4, a5, a6, d1, d2, d3, d4, d5, d6;
float qi0, qi1, qi2, qi3, qi4, qi5; 

double[][] J = new double[3][7];
double[] q = new double[6];

Matrix ma = new Matrix();
Inverse in = new Inverse();

boolean sval=false;

GImageToggleButton btnToggle0;
GImageToggleButton btnToggle1;
GImageToggleButton btnToggle2;
GImageToggleButton btnToggle3;
GImageToggleButton btnToggle4;
GImageToggleButton btnToggle5;

GPanel    configPanel;
GDropList serialList;
GLabel    serialLabel;

GTextArea txaAngles;
int bgcol = 32;

int EnableArm = 0;
int FKenable = 0;
int FixedAxis = 0;
int Normal = 0;
int Parallel = 0;
int Angled = 0;
int ScriptEnabled = 0;
boolean buttonClicked, buttonBusy;

String val;
boolean Contact = false;

PrintWriter output;

String fileName;
Table table;
String selected_file;
int selectedfilecount=0;

boolean nextStep = false;
boolean SliderChanged = true;
boolean PLAYBACK = false;
boolean RECORD = false;
int playback_count = 0;
long previousMillis = 0;
long previousBlinkMillis = 0;
long interval = 100;
boolean LAMP = false;

public void setup() {
  size(1050, 700, JAVA2D);
  createGUI();
  btnToggle0 = new GImageToggleButton(this, 133, 469);
  btnToggle0.tag = "0"; 
  btnToggle1 = new GImageToggleButton(this, 183, 469);
  btnToggle1.tag = "1";
  
  btnToggle2 = new GImageToggleButton(this, 760, 500);
  btnToggle2.tag = "1";
  btnToggle3 = new GImageToggleButton(this, 825, 500);
  btnToggle3.tag = "0";
  btnToggle4 = new GImageToggleButton(this, 890, 500);
  btnToggle4.tag = "0";  
  btnToggle5 = new GImageToggleButton(this, 955, 500);
  btnToggle5.tag = "0";  
  
  // Create a text area with both horizontal and 
  // vertical scrollbars that automatically hide 
  // when not needed.
  txaAngles = new GTextArea(this, 40, 40, 290, 100, G4P.SCROLLBARS_BOTH | G4P.SCROLLBARS_AUTOHIDE);
  // Set some default text
  txaAngles.setPromptText("Angel Output");  
  txaAngles.setVisible(false);
  
  table = new Table();
  
  // DH Parameters for arm
  a1 = 0;
  a2 = 6.75;
  a3 = 6.625;
  a4 = 1.25;
  a5 = 0;
  a6 = 0.0;
  
  d1 = 5; // had to add 0.25in for the base plate
  d2 = 0;
  d3 = 0;
  d4 = -0.25; //was 
  d5 = 0;
  d6 = 5.75;  //was 4.5
  
  // Set initial values to home positions - these also have to set in the GUI for the sliders
  qi0 = qi3 = qi4 = qi5 = 0.0;
  qi1 = 127.0;
  qi2 = -135.0;
  
  q[0] = qi0 * deg2rad;
  q[1] = qi1 * deg2rad;
  q[2] = qi2 * deg2rad;
  q[3] = qi3 * deg2rad;
  q[4] = qi4 * deg2rad;
  q[5] = qi5 * deg2rad;
  
  crciberneticalogo = loadImage("CRCibernetica509x81.png");
  
  //String portName = "COM19";
  //myPort = new Serial(this, portName, 9600);
  //myPort.bufferUntil('\n');
  int selectedPort = 0;
  String[] availablePorts = Serial.list();
  if (availablePorts == null) {
    println("ERROR: No serial ports available!");
    exit();
  }
  String[] serialConfig = loadStrings(serialConfigFile);
  if (serialConfig != null && serialConfig.length > 0) {
    String savedPort = serialConfig[0];
    // Check if saved port is in available ports.
    for (int i = 0; i < availablePorts.length; ++i) {
      if (availablePorts[i].equals(savedPort)) {
        selectedPort = i;
      } 
    }
  }
  // Build serial config UI.
  configPanel = new GPanel(this, 10, 10, width-720, 50, "Configuration (click to hide/show)");
  serialLabel = new GLabel(this,  0, 20, 80, 25, "Serial port:");
  configPanel.addControl(serialLabel);
  serialList = new GDropList(this, 90, 20, 200, 200, 6);
  serialList.setItems(availablePorts, selectedPort);
  configPanel.addControl(serialList);
  // Set serial port.
  setSerialPort(serialList.getSelectedText());
  
  
/*
  while (Contact == false) {
    val = myPort.readStringUntil('\n');
    //make sure our data isn't empty before continuing
    if (val != null) {
      //trim whitespace and formatting characters (like carriage return)
      val = trim(val);
      println(val);
	
      //look for our string to start the handshake
      //if it's there, clear the buffer, and send a request for data
        println("Waiting for Arm Ready");
        if (val.equals("Ready")) {
          myPort.clear();
          Contact = true;
          println("Contact Made");
        }
    }
   }
*/
  Contact = false;
  
  //dropList1.setItems(Serial.list(), 0);
  fileName = getDateTime();
  output = createWriter("data/" + "positions" + fileName + ".csv");
  //output.println("x,y,z,wa,wr,g");
  //             Base, Shoulder, Elbow, Pitch,  0,  Roll,  Gripper
  output.println("theta0,theta1,theta2,theta3,theta4,theta5,g");
  
}

public void draw() {
  background(255);
  textSize(14);
  fill(50);
  text("Generated by CyberMerln:", 774, 610); 
  text("Based on GUI Developed by:", 774, 630); 

  image(crciberneticalogo, 774, 636, 150, 34.5);

  updatePlayBack();
  updateAnimation();
  
  if(buttonClicked){
    thread("processButtonClick");
    //processButtonClick();
    buttonClicked = false;
  }

  
}

//Arduino Handshake
void acknowledge() {
  //val = null;
  while (Contact == false) {
    val = myPort.readStringUntil('\n');
    //make sure our data isn't empty before continuing
    if (val != null) {
      //trim whitespace and formatting characters (like carriage return)
      val = trim(val);
      //println(val);
	
      //look for our string to start the handshake
      //if it's there, clear the buffer, and send a request for data
      //println("Waiting for Joint to Complete");
        if (val.equals("Done")) {
          myPort.clear();
          Contact = true;
          //println("Completed");
        }
    }
  }
  
  Contact = false;
  val = null;
  
}

String getDateTime() {
  int d = day();  
  int m = month(); 
  int y = year();  
  int h = hour();
  int min = minute();
  String s = String.valueOf(y);
  s = s + String.valueOf(m);
  s = s + String.valueOf(d);
  s = s + String.valueOf(h);
  s = s + String.valueOf(min);
  return s;
}

// UI event handlers

// Set serial port to desired value.
void setSerialPort(String portName) {
  // Close the port if it's currently open.
  if (myPort != null) {
    myPort.stop();
  }
  try {
    // Open port.
    myPort = new Serial(this, portName, 9600);
    myPort.bufferUntil('\n');
    // Persist port in configuration.
    saveStrings(serialConfigFile, new String[] { portName });
  }
  catch (RuntimeException ex) {
    // Swallow error if port can't be opened, keep port closed.
    myPort = null; 
  }
}
void handlePanelEvents(GPanel panel, GEvent event) {
  // Panel events, do nothing.
}

void handleDropListEvents(GDropList list, GEvent event) { 
  // Drop list events, check if new serial port is selected.
  if (list == serialList) {
    setSerialPort(serialList.getSelectedText()); 
  }
}