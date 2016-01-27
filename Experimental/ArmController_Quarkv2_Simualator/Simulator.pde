class ProjectorSketch extends PApplet {
  
  PShape base, shoulder, elbow, foreArm, wristPitch, wristRoll;
  float rotX, rotY;
  float posX=1, posY=50, posZ=50;
  int gridSize = 50;  
  
  void settings() {
    size(1000, 600, P3D);
    smooth();
  }
 
  void setup() {
    
    base = loadShape("base.obj");
    shoulder = loadShape("shoulder.obj");
    elbow = loadShape("Elbow.obj");
    foreArm = loadShape("forearm.obj");
    wristPitch = loadShape("wristPitch.obj");
    wristRoll = loadShape("wristRoll.obj");
    
    shoulder.disableStyle();
    elbow.disableStyle();
    //foreArm.disableStyle(); 
    wristPitch.disableStyle();
    wristRoll.disableStyle();
    
    println(q[1]);
    
  }
 
  void draw() {
   background(32);
   smooth();
   lights(); 
   directionalLight(51, 102, 126, -1, 0, 0);
/*    
    for (int i=0; i< Xsphere.length - 1; i++) {
    Xsphere[i] = Xsphere[i + 1];
    Ysphere[i] = Ysphere[i + 1];
    Zsphere[i] = Zsphere[i + 1];
    }
    
    Xsphere[Xsphere.length - 1] = posX;
    Ysphere[Ysphere.length - 1] = posY;
    Zsphere[Zsphere.length - 1] = posZ;
*/

   translate(width/1.5,height/1.5);
   rotateX(rotX);
   rotateY(-rotY);
   scale(-0.8);


/*   
   for (int i=0; i < Xsphere.length; i++) {
     pushMatrix();
     translate(-Ysphere[i], -Zsphere[i]-11, -Xsphere[i]);
     fill (#D003FF, 25);
     sphere (float(i) / 20);
     popMatrix();
    }
*/

   fill(#FFE308);  
   translate(0,0,0);
   rotateX(-PI/2);
   //rotateZ(PI/4);
     shape(base);

   rotateX(PI/2);
   strokeWeight(5);   
   //coordinate system
   stroke(255,0,0); //red, x-axis
   line(0,0,0,500,0,0);
   stroke(0,255,0); //green, y-axis
   line(0,0,0,0,500,0);
   stroke(0,0,255); //blue, z-axis
   line(0,0,0,0,0,500);
   
   strokeWeight(2);
   stroke(0,197,205); 
   pushMatrix();
   for(int i = -width/2; i <width/2; i+=gridSize) {
    for(int j = -height/2; j < height/2; j+=gridSize) {
      int y = 0; int x = 300;
      line(i+x,          y, j,           i+x+gridSize, y, j          );
      line(i+x+gridSize, y, j,           i+x+gridSize, y, j+gridSize );
      line(i+x+gridSize, y, j+gridSize,  i+x,          y, j+gridSize );
      line(i+x,          y, j,           i+x,          y, j+gridSize );
    }
   }
  popMatrix();
  noStroke();
  rotateX(-PI/2);
   
   translate(0, 0, 65);
   //rotateY(gamma);
   rotateZ((float) q[0]);
     shape(shoulder);
     
   //translate(67, -54, 50);
   translate(0,-16,50);
   rotateX(PI);
   rotateY((float) q[1]);
     shape(elbow);
      
   //translate(190, -50, 0);
   translate(175, 19, 0);
   rotateX(PI);
   rotateY((float) -q[2]);
     shape(foreArm);
      
   //translate(88, 8, 20);
   translate(157, 25, 20);
   rotateY((float) -q[3] + PI/2);
     shape(wristPitch);
     
   translate(0, 19, 1);
   rotateX((float) q[4]);
     shape(wristRoll);
  
  }


void mouseDragged(){
    rotY -= (mouseX - pmouseX) * 0.01;
    rotX -= (mouseY - pmouseY) * 0.01;
}
 
}