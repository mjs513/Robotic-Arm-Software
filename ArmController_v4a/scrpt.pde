public void processButtonClick() {
  ScriptEnabled = 1;
 
  buttonBusy = true;
 
  ScriptEnabled = 1;
//Letter P  
/*  move_to_xyz(13.64, 0, 2.818);
  movePosition();
  delay(4500);
  move_to_xyz(15.64, 0, 2.818);
  movePosition();  
  delay(4500);
  move_to_xyz(15.64, -1.0, 2.818);
  movePosition();
  delay(4500);
  move_to_xyz(14.64, -1.0, 2.818);
  movePosition();
  delay(3500);  
  move_to_xyz(14.64, 0, 2.818);
  movePosition();
  delay(3500);  */  
  
/*LetterB
DOWN
G0 Y2
G0 X1
G0 Y-2
G0 X-1
G0 Y1
G0 X1
UP
G0 Y-1 */

  move_to_xyz(13.64, 0, 2.818);
  movePosition();
  delay(4500);  
  move_to_xyz(15.64, 0.0, 2.818); //Y2
  movePosition();  
  delay(4500);
  move_to_xyz(15.64, -1.0, 2.818); //X1
  movePosition();  
  delay(4500);
  move_to_xyz(13.64, -1.0, 2.818); //Y-2
  movePosition();  
  delay(4500);
    move_to_xyz(13.64, 0.0, 2.818); //X-1
  movePosition();  
  delay(4500);
  move_to_xyz(14.64, 0.0, 2.818);  //Y1
  movePosition();  
  delay(4500);
  move_to_xyz(14.64, -1.0, 2.818);  //Y1
  movePosition();  
  delay(4500);  
  
  
  GripperFixedPitchAngle();
  
  ScriptEnabled = 0;
 
  buttonBusy = false;

}