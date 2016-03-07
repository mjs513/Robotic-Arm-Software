#include <PololuMaestro.h>
#include <Wire.h>
#include <avr/pgmspace.h>

/*in the Maestro Control Center and apply these settings:
  * Serial mode: UART, fixed baud rate
  * Baud rate: 9600
  * CRC disabled

Be sure to click "Apply Settings" after making any changes
*/

/* On boards with a hardware serial port available for use, use
that port to communicate with the Maestro. For other boards,
create a SoftwareSerial object using pin 10 to receive (RX) and
pin 11 to transmit (TX). */
//#ifdef SERIAL_PORT_HARDWARE_OPEN
//  #define maestroSerial SERIAL_PORT_HARDWARE_OPEN
//#else
  #include <SoftwareSerial.h>
  SoftwareSerial maestroSerial(10, 11);
//#endif

/* Next, create a Maestro object using the serial port. 
Uncomment one of MicroMaestro or MiniMaestro below depending 
on which one you have. */ 
//MicroMaestro maestro(maestroSerial); 
MiniMaestro maestro(maestroSerial); 


struct maestro_parameters 
{
     // servo_channel, name, min, max, home, speed, accel, and neutral come directly from the
     // min-maestro channel settings tab so it is a good idea to take a screen shot 
     //and print it out.
     int servo_channel;
     char servo_name[20];
     int servo_min;
     int servo_max;
     int servo_home;
     int servo_speed;
     int servo_accel;
     int servo_neutral;
     // The next two variables are required for Arduino mapping function. We will be mapping degrees to
     // microseconds. fromLow corresponds to the servo_min and and fromHigh corresponds to
     // servo_max.
     // If we use the shoulder as an example if your servo_min value is 672 microseconds, which would
     // corresponds to +180 degrees and your servo_max value is 2248 microseconds which corresponds
     // to -180 degrees the fromLow and fromHigh values would be +180 and -180 degrees respectively
     int servo_fromLow;
     int servo_fromHigh;
     // The next two variables are used to set the servo constraints. In, other words the max allowable travel
     // for each of servos
     int servo_constLow;
     int servo_constHigh;
} servo[6]; 

String inputString = "";
String servoString = "";
String commandString = "";
boolean stringComplete = false;
int servoNum, servoPosMs;
float servoPosDeg;

void setup() {
  Serial.begin(9600);
  // Set the serial baud rate.
  maestroSerial.begin(9600);
  
  Serial.println("Ready");

  inputString.reserve(10);
  servoString.reserve(10);
  commandString.reserve(10);
  
  //Serial.println(map(0,180,-180,4244,7680));

  //maestro_parameters servo[6];
  servo[0] = (maestro_parameters) {0, "Base", 752, 1920, 1344, 0, 0, 1504, -90, 90, -80, 80};
  servo[1] = (maestro_parameters) {1, "Shoulder", 672, 2288, 2040, 0, 0, 2040, -180, 180, -10, 180};
  servo[2] = (maestro_parameters) {2, "Elbow", 992, 1872, 1738, 10, 0, 1505, 180, -180, -160, 45};
  servo[3] = (maestro_parameters) {3, "Wrist_Pitch", 912, 2080, 912, 0, 0, 1500, 0, 180, 0, 180};
  servo[4] = (maestro_parameters) {6, "Wrist_Rotate", 608, 2448, 1500, 40, 0, 1500, 90, -90, -90, 90};
  servo[5] = (maestro_parameters) {7, "Gripper", 1216, 1792, 1244, 7, 0, 1500, 0, 10, 0, 10};

}

void loop(){
  parseCommand();
}

void finish(){
  while(true){
    ;
    ;
  }
}

/*
  SerialEvent occurs whenever a new data comes in the
 hardware serial RX.  This routine is run between each
 time loop() runs, so using delay inside loop can delay
 response.  Multiple bytes of data may be available.
 */
void serialEvent() {
  while (Serial.available()) {
    // get the new byte:
    char inChar = (char)Serial.read(); 
    // add it to the inputString:
    inputString += inChar;
    // if the incoming character is a newline, set a flag
    // so the main loop can do something about it:
    if (inChar == '\n') {
      stringComplete = true;
    } 
  }
}

void parseCommand(){
  // print the string when a newline arrives:
  if (stringComplete) {
    inputString.trim();
    //Serial.println(inputString);
    int separatorIndex = inputString.indexOf(',');
    servoString=inputString.substring(0,1);
    commandString=inputString.substring(separatorIndex+1);
    servoNum = servoString.toInt();
    servoPosDeg = commandString.toInt();

    moveServo();
    
    // clear the string:
    inputString = "";
    servoString = "";
    commandString = "";
    stringComplete = false;
  }
}

void moveServo() {
  // The Constrain function limits the servo movement so you do not overdrive the arm into positions you
  // do not want
  servoPosDeg = constrain(servoPosDeg, servo[servoNum].servo_constLow, servo[servoNum].servo_constHigh);
  
  //Mini Maestro values given in 1/4 ms so you have to multiply by 4.
  if(servoNum == 1) {
    servoPosMs = 4*(4.4014*servoPosDeg+1476.0);
  } else if(servoNum == 2) {
    servoPosMs = 4*(-2.4222*servoPosDeg+1436.1);
  } else {
    servoPosMs = 4*map(servoPosDeg, servo[servoNum].servo_fromLow, servo[servoNum].servo_fromHigh,
               servo[servoNum].servo_min, servo[servoNum].servo_max);
  }
  
  //Serial.println(servoPosDeg);
  
  // setSpeed tells the servo how fast you want the servo to move,
  // set Target tells the servo where to move
  maestro.setSpeed((uint8_t) servo[servoNum].servo_channel, (uint16_t) servo[servoNum].servo_speed);
  maestro.setTarget((uint8_t) servo[servoNum].servo_channel, (uint16_t) servoPosMs);

  // The while loop is here to tell the sketch to wait till the servo has finished moving before
  // sending a done message
  while(maestro.getMovingState() == 1) {
    //Serial.println("Moving Servo");
    };
  
  //Serial.print ("Position is: "); 
  //Serial.println (maestro.getPosition(servo[servoNum].servo_channel));
  
  Serial.println ("Done");

}


