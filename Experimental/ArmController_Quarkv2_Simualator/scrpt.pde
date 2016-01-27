public void processButtonClick() {
  ScriptEnabled = 1;
 
  buttonBusy = true;
 
  ScriptEnabled = 1;
  
  move_to_xyz(13.64, 0, 2.818);
  movePosition();
  delay(4500);
  //move_to_xyz(14.64, 0, 3.2849);
  //movePosition();
  //delay(3500);
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
  delay(3500);   
  GripperFixedPitchAngle();

  delay(2500);  
  ScriptEnabled = 0;
 
  buttonBusy = false;

}