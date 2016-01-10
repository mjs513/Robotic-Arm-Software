int ArmAnglePlayBack(int theta0, int theta1, int theta2, int theta3,
                     int theta4, int theta5, int g) {
                       
  //                 Base, Shoulder, Elbow, Pitch,  0,  Roll,  Gripper 
  slider1.setValue(theta0);  // on playback z is the base rotation
  slider6.setValue(g);
  slider4.setValue(theta3);
  slider5.setValue(theta5);  
  slider3.setValue(theta2);  
  slider2.setValue(theta1);
  
  updateFK();
  
  return 0;
  
}

void updatePlayBack() {
  long currentMillis = millis();
  if (PLAYBACK&&(currentMillis - previousMillis > interval)) {
    previousMillis = currentMillis;
    table = loadTable(selected_file, "header");
    //println(table.getRowCount() + " total rows in table"); 
      TableRow row = table.getRow(playback_count);
           
      int theta0 = row.getInt("theta0");
      int theta1 = row.getInt("theta1");
      int theta2 = row.getInt("theta2");
      int theta3 = row.getInt("theta3");
      int theta4 = row.getInt("theta4");
      int theta5 = row.getInt("theta5");
      int g = row.getInt("g");
      
      ArmAnglePlayBack(theta0, theta1, theta2, theta3, theta4, theta5, g);
      
      playback_count++;
      if (playback_count>=table.getRowCount()){
        playback_count = 0;
        PLAYBACK=false;
        println("Playback finished...");
      }
  }
}

void saveCoordinates() {
    println("Coordinates saved to file");

    int theta0 = slider1.getValueI(); //base
    int theta1 = slider2.getValueI(); //shoulder
    int theta2 = slider3.getValueI(); //elbow
    int theta3 = slider4.getValueI(); //wrist pitch
    int theta4 = 0;                   //wrist yaw
    int theta5 = slider5.getValueI(); //wrist roll
    int g = slider6.getValueI();      //gripper
      
    output.println(theta0 + "," + theta1 + "," + theta2 + "," + theta3
                          + "," + theta4 + "," + theta5 + "," + g);
}


void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {
    println("User selected " + selection.getAbsolutePath());
    selected_file = selection.getAbsolutePath();
  }
}