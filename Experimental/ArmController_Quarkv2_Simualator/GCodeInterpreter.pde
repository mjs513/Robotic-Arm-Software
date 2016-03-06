import java.io.File;

String inputFile; 
char letter;
String words = "G0 X-1 Y0.5";
//String words = "UP";

float ox = 13.64f;
float oy = 0.0f;
//float oz = 3.818f;
float oz = 1.318f;
float new_x = 0.0f;
float new_y = 0.0f;
float new_z = 0.0f;


void gcInterpreter() { 
  //move_to_xyz(13.64, 0, 2.818);
  
  buttonBusy = true;
 
  ScriptEnabled = 1;
  
  new_z = oz; new_x = ox; new_y = oy;
  inputFile = sketchPath() + "/" + "TEMP.NGC"; 
  
      //if((inputFile).isFile()) {
      File f = null;
      boolean bool = false;
 
 try {
      // create new files
      f = new File(inputFile);
      
      // create new file in the system
      f.createNewFile();
      
      // tests if file exists
      bool = f.isFile();
         
      if(bool == true) {
            // delete() invoked
            f.delete();
            
            String lines[] = loadStrings("TEMP.NGC");
            for(int j = 0; j < lines.length; j++) {
              if(lines[j].trim().length()==0) continue;

              String[] inputStringArr = split(lines[j], ' ');
              String cmd = inputStringArr[0].replace(";","");
              println(cmd);
               switch(cmd) {
               case "G0":
                for(int i = 1; i < inputStringArr.length; i++) {
                  if(inputStringArr[i].substring(0,1).equals("X") == true) {
                    if(inputStringArr[i].indexOf(";") < 0){
                      new_y = new_y - Float.parseFloat(inputStringArr[i].substring(1));
                    } else {
                      new_y = new_y - Float.parseFloat(inputStringArr[i].substring(1,inputStringArr[i].indexOf(";")));
                    }
                  }
                  if(inputStringArr[i].substring(0,1).equals("Y") == true) {
                    if(inputStringArr[i].indexOf(";") < 0){
                      new_x = new_x + Float.parseFloat(inputStringArr[i].substring(1));
                    } else {
                      new_x = new_x + Float.parseFloat(inputStringArr[i].substring(1,inputStringArr[i].indexOf(";")));
                    }
                  }
                 }
                 break;
              case "G03":  // arc tbd
              case "G04":
                //pause(parsenumber('P',0)*1000);  break;  // dwell
                delay(50);
                println("Delay Over");
                break;
              case "UP":
                new_z = new_z + 0.5f;
                break;
              case "DOWN":
                new_z = new_z - 0.5f;
                break;
              case "G90":
              case "G91":
              case "G92":
              default:  break;
            }              
  
            print(new_x); print(", "); print(new_y); print(", "); println(new_z);
              move_to_xyz(new_x, new_y, new_z);
              movePosition();  
              delay(2500);
         }
       } else {
          // if anew_y error occurs
          print(inputFile);
          println(" NOK");
       }
      } catch(Exception e){
         // if anew_y error occurs
         e.printStackTrace();
      }
  ScriptEnabled = 0;
 
  buttonBusy = false;
 }