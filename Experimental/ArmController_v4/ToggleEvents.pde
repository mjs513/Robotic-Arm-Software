// Event handler for image toggle buttons
public void handleToggleButtonEvents(GImageToggleButton button, GEvent event) { 
  //println(button + "   State: " + btnToggle0.stateValue());
  
  EnableArm = btnToggle0.stateValue();
  FKenable = btnToggle1.stateValue();  //Enable FK 2d slider and buttons
  FixedAxis = btnToggle2.stateValue();
  
  
  if (FKenable == 1) {
    updateFK();
  }
  
  if(EnableArm == 0) {
    slider1.setValue(slider1.getValueI());
    slider3.setValue(slider3.getValueI());
    slider2.setValue(slider2.getValueI());    
    slider4.setValue(slider4.getValueI());
    slider5.setValue(slider5.getValueI());
    slider6.setValue(slider6.getValueI());
  }

  if( FixedAxis == 1){
    Normal = btnToggle3.stateValue();
    Parallel = btnToggle4.stateValue();
    Angled = btnToggle5.stateValue();
    
    if(Normal == 1 && (Parallel == 1 || Angled == 1) ){
      btnToggle4.setState(0);
      btnToggle5.setState(0);
    }

    if(Parallel == 1){
      btnToggle3.setState(0);
      btnToggle5.setState(0);
    }

    if(Angled == 1){
      btnToggle3.setState(0);
      btnToggle4.setState(0);
    }
    
  } else if(FixedAxis == 0) {
      btnToggle3.setState(0);
      btnToggle4.setState(0);
      btnToggle5.setState(0);
  }
  
  GripperFixedPitch(); 
  
}

void keyPressed() {
  if (keyCode==16){//right shift
    PLAYBACK = false;
    playback_count = 0;
    selected_file="normalstance.csv";
    PLAYBACK=true;
    //controlEyes(0);
    //controlLamp(1);
    
  }
  
   if (keyCode==47){// forward slash
    PLAYBACK = false;
    playback_count = 0;
    selectedfilecount=selectedfilecount+1;
    if(selectedfilecount>4){
      selectedfilecount=1;
    }
    selected_file=selectedfilecount+".csv";
    PLAYBACK=true;
    //controlEyes(1);
    //controlLamp(0);
  }
  
  if (keyCode==32) {
    sval=!sval;
    int stateVal=int(sval);
    btnToggle0.stateValue(stateVal);
    controlLamp(stateVal);
  }
  
  if (keyCode==83) { // s to save coordinates to file
    println("Coordinates saved to file");
    if(FKenable == 0) {
      float x = slider2d1.getValueXF();
      float y = slider2d1.getValueYF();
      float z = slider1.getValueI();
      int wa = slider4.getValueI();
      int wr = slider5.getValueI();
      int g = slider6.getValueI();
      output.println(x + "," + y + "," + z + "," + wa + "," + wr + "," + g);
    } else {
      float x = slider2d2.getValueXF();
      float y = slider2d2.getValueYF();
      float z = slider1.getValueI();
      int wa = slider4.getValueI();
      int wr = slider5.getValueI();
      int g = slider6.getValueI();
      output.println(x + "," + y + "," + z + "," + wa + "," + wr + "," + g);
    }
  }
  
  if (keyCode==88) {
    println("Close file"); //x to save and close file
    RECORD=false;
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    //exit(); // Stops the program
  }
  
  if (keyCode==80) {
    println("Playback"); //p for playback
    PLAYBACK = true;
  }
  
  if (keyCode==78) { 
    fileName = getDateTime();
    output = createWriter("data/" + "positions" + fileName + ".csv");
    output.println("x,y,z,wa,wr,g");
    println("New position file"); //n for new file
  }
  
  if (keyCode==79) {
    println("Open File for Playback"); //o for open file for playback
    selectInput("Select a file to playback:", "fileSelected");
  }
  
  if (keyCode==82) {
    println("Record"); //r for record
    RECORD = true;
  }
  
}