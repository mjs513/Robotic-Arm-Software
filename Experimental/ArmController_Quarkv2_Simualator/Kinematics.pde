
void fk_solver() {
  
  c1 = cos((float) q[0]);
  c2 = cos((float) q[1]);
  c3 = cos((float) q[2]);
  c4 = cos((float) q[3]);
  c5 = cos((float) q[4]);
  c6 = cos((float) q[5]);  
  
  s1 = sin((float) q[0]);
  s2 = sin((float) q[1]);
  s3 = sin((float) q[2]);
  s4 = sin((float) q[3]);
  s5 = sin((float) q[4]);
  s6 = sin((float) q[5]);
  
  //Links 1 to 3
  nx0 = c1*c2*c3 - s3*c1*s2;
  ny0 = s1*(c2*c3-s2*s3);
  nz0 = s2*c3 + c2*s3;
  
  sx0 = -c1*c2*s3 - c3*c1*s2;
  sy0 = -s3*s1*c2 - s1*s2*c3;
  sz0 = c2*c3 - s2*s3;
  
  ax0 = s1;
  ay0 = -c1;
  az0 = 0;
   
  px0 = a3*(c1*c2*c3 + s3*(0-c1*s2)) + a2*c1*c2;
  py0 = s1*(a3*(c2*c3 - s2*s3) + a2*c2);
  pz0 = a3*(s2*c3 + c2*s3) + a2*s2 + d1;
  
  //print(px); print(" -- "); print(py); print(" --- "); println(pz);
  
  //Links 4 thru 6
  nx1 = c4*c5*c6 - c4*s5*s6;
  ny1 = s4*c5*c6 - s4*s5*s6;
  nz1 = s5*c6 + c5*s6;
  
  sx1 = -(c4*c5*s6 + c4*s5*c6);
  sy1 = -s4*s5*c5 - s4*s5*c6;
  sz1 = -s5*s6 + c5*c6;
  
  ax1 = s4;
  ay1 = -c4;
  az1 = 0;
  
  px1 = a6*c6*c4*c5 - c4*c5*a6*s6 + s4*d6 + a4*c4;
  py1 = s4*c5*a6*c6 - s4*s5*a6*s6 + a4*s4 -c4*d6;
  pz1 = s5*a6*c6 + c5*a6*s6 + d4;
  
  //A123 * A456
  nx = nx0*nx1 + sx0*ny1 + ax0*nz1;
  ny = ny0*nx1 + sy0*ny1 + ay0*nz1;
  nz = nz0*nx1 + sz0*ny1 + az0*nz1;
  
  sx = nx0*sx1 + sx0*sy1 + ax0*sz1;
  sy = ny0*sx1 + sy0*sy1 + ay0*sz1;
  sz = nz0*sx1 + sz0*sy1 + az0*sz1;
  
  ax = nx0*ax1 + sx0*ay1 + ax0*az1;
  ay = ny0*ax1 + sy0*ay1 + ay0*az1;
  az = nz0*ax1 + sz0*ay1 + az0*az1;
  
  if(FixedAxis == 0) {
    px = nx0*px1 + sx0*py1 + ax0*pz1 + px0;
    py = ny0*px1 + sy0*py1 + ay0*pz1 + py0;
    pz = nz0*px1 + sz0*py1 + az0*pz1 + pz0;
  } else {
    px = px0;
    py = py0;
    pz = pz0;
    
    if(Parallel == 1) {
      float a0 = atan2(py0,px0);
      px = px0 + cos(a0)*d6;
      py = py0 + sin(a0)*d6;
      pz = pz0 + 0.5; //was 1.0

    } else if(Normal == 1) {
          pz0 = pz - d6;
      } else if(Angled == 1) {
          float a0 = atan2(py0,px0);
          //float a11 = (3.14159/2)-((float) q[1] +(float) q[2]);
          float a11 = (3.14159/2)-((float) q[1] +(float) q[2]);
          float xyProjectionLength = d6*sin(a11);
          
          px = px0 + cos(a0)*xyProjectionLength;
          py = py0 + sin(a0)*xyProjectionLength; 
          pz = pz0 + cos(a11)*d6 + 0.5;
       
        }
    
  }
  
  //print(px0); print(" -- "); print(py0); print(" --- "); println(pz0);
  //print(px1); print(" -- "); print(py1); print(" --- "); println(pz1);
  //print(px); print(" -- "); print(py); print(" --- "); println(pz);
  
  //print(nx); print(" -- "); print(ny); print(" --- "); println(nz);  
  //print(sx); print(" -- "); print(sy); print(" --- "); println(sz);  
  //print(ax); print(" -- "); print(ay); print(" --- "); println(az); 
 
 }


/*******************************************************************
 *
 * Inverse kinematics based on technique outlined by Travis Wolf
 * "Operational space control of 6DOF robot arm with spiking cameras 
 *  part 2: Deriving the Jacobian",
 * https://studywolf.wordpress.com/2015/06/27/
 *         operational-space-control-of-6dof-robot-arm-with-spiking-cameras-part-2-deriving-the-jacobian/
 *
 ********************************************************************/

void calc_jacobian(){ 
    Zeros(J, 2 , 7);
  
    c1 = cos((float) q[0]);
    c2 = cos((float) q[1]);
    c3 = cos((float) q[2]);
    c4 = cos((float) q[3]);
    c5 = cos((float) q[4]);
    c6 = cos((float) q[5]);  
  
    s1 = sin((float) q[0]);
    s2 = sin((float) q[1]);
    s3 = sin((float) q[2]);
    s4 = sin((float) q[3]);
    s5 = sin((float) q[4]);
    s6 = sin((float) q[5]);
 

    float s23  = sin((float) (q[1] + q[2]));
    float c23  = cos((float) (q[1] + q[2]));
    float c234 = cos((float) (q[1] + q[2] + q[3]));
    float s234 = sin((float) (q[1] + q[2] + q[3]));
    float c56  = cos((float) (q[4] + q[5]));
    float s56  = sin((float) (q[4] + q[5]));
 
    J[0][0] = -a2*s1*c2 + a3*s1*s2*s3 - a3*s1*c2*c3 + a4*s1*s4*s23 - a4*s1*c4*c23 + a6*(s1*s5*c234
              + c1*c5)*s6 + a6*(-s1*c5*c234 + s5*c1)*c6 + d4*c1 - d6*s1*s234;
    J[1][0] = a2*c1*c2 - a3*s2*s3*c1 + a3*c1*c2*c3 - a4*s4*s23*c1 + a4*c1*c4*c23 
              - a6*(s1*s5 - c1*c5*c234)*c6 - a6*(s1*c5 + s5*c1*c234)*s6 - d4*s1 + d6*s234*c1;
    J[2][0] = 0;
 
    J[0][1] = (-a2*s2 - a3*s23 - a4*s234 - a6*s234*c56 + d6*c234)*c1;
    J[1][1] = (-a2*s2 - a3*s23 - a4*s234 - a6*s234*c56 + d6*c234)*s1;
    J[2][1] = a2*c2 - a3*s2*s3 + a3*c2*c3 - a4*s4*s23 + a4*c4*c23 - a6*s5*s6*c234 
              + a6*c5*c6*c234 + d6*s234;

    J[0][2] = (-a3*s23 - a4*s234 - a6*s234*c56 + d6*c234)*c1;
    J[1][2] = (-a3*s23 - a4*s234 - a6*s234*c56 + d6*c234)*s1;
    J[2][2] = -a3*s2*s3 + a3*c2*c3 - a4*s4*s23 + a4*c4*c23 - a6*s5*s6*c234 
              + a6*c5*c6*c234 + d6*s234;

    J[0][3] = (-a4*s234 - a6*s234*c56 + d6*c234)*c1;
    J[1][3] = (-a4*s234 - a6*s234*c56 + d6*c234)*s1;
    J[2][3] = -a4*s4*s23 + a4*c4*c23 - a6*s5*s6*c234 + a6*c5*c6*c234 + d6*s234;

    J[0][4] = a6*(s1*c56 - s56*c1*c234);
    J[1][4] = a6*(-s1*s56*c234 + c1*c56);
    J[2][4] = -a6*s56*s234;
  
    J[0][5] = a6*(s1*c56 - s56*c1*c234);
    J[1][5] = a6*(-s1*s56*c234 + c1*c56);
    J[2][5] = -a6*s56*s234;


}


// This code is based on the method shown by Travis Wolf at:
// wordpress.studywolf.com
//
void move_to_xyz(float x, float y, float z){
    double [] xyz = new double[3];    
    double [] xyz_d = new double[3];
    double [] delta_xyz = new double[3];
    double [] ux = new double[3];
    double [] u = new double [7];
  
    xyz_d[0] = x;
    xyz_d[1] = y;
    xyz_d[2] = z;  
    
    int count = 0;
    while (true) { 
        count += 1;
        // get control signal in 3D space
        fk_solver();

        xyz[0] = px;
        xyz[1] = py;        
        xyz[2] = pz;

        delta_xyz = ma.subtract1d( xyz_d, xyz);
        
        double kp = 0.9;
        //ux = kp * delta_xyz;
        ux = ma.scalarMultiplication(kp, delta_xyz);
       
        // transform to joint space
        calc_jacobian();

        u = ma.multiply(ma.transpose(J), ux);
 
        // target joint angles are current + uq (scaled)
        //self.q[...] += u * .001;
  
        q = ma.add1d(q, ma.scalarMultiplication(0.001, u));
        

        //for( int ii = 0; ii < 6; ii++) {
        //   print(q[ii]*180/3.1451); print("    "); }
        //println(); println();
        

        //self.robot.move(np.asarirpay(self.q.copy(), 'float32'))
        float sqr_dis = sqrt((float) (delta_xyz[0]*delta_xyz[0])
                        + (float) (delta_xyz[1]*delta_xyz[1]) 
                        + (float) (delta_xyz[2]*delta_xyz[2]));
     //return;
        if ((sqr_dis < .0001) || (count > 1e4)) {
            return; }
    }
}

import java.util.Arrays;
private static void Zeros(double[][] a, int rows, int cols) {
    if (rows >= 0) {
        double[] row = new double[cols];
    Arrays.fill(row, 0.0);
    a[rows] = row;
    Zeros(a, rows - 1, cols);
  }
}

/* arm positioning routine utilizing inverse kinematics */
/* z is base angle, y vertical distance from base, x is horizontal distance.*/
int Arm(float x, float y, float z, int g, float wa, int wr)
{
  float t0, t1, t2, t3;
  int flag0, flag1, flag2, flag3;
  
  flag0 = flag1 = flag2 = flag3 = 0;
  t0 = t1 = t2 = t3 = 0.0;
  
  //print(x); print(" ---  ");  
  //print(z); print(" ---  "); 
  //println(y);  
  
  if(EnableArm == 1) move_to_xyz(x, z, y);  //Inverse Kinematice Solver
  
  //for( int ii = 0; ii < 6; ii++) {
  //  print(q[ii]*180/3.1451); print("    "); }
  //  println(); println();

  t0 = (float) q[0]*rad2deg;
  t1 = (float) q[1]*rad2deg;
  t2 = (float) q[2]*rad2deg;
  t3 = (float) q[3]*rad2deg;
  
  //Failsafe to avoid going beyond angle limits,i.e., set stops
  if(t0 < -80 || t0 > 80) flag0 = 1;
  if(t1 < 10 || t1 > 160) flag1 = 1;
  if(t2 < -150 || t2 > 45) flag2 = 1;
  if(t3 < 0 || t3 > 180) flag3 = 1;

  if((flag0+flag1+flag2+flag3) == 0 ) {
    slider1.setValue(t0);
    slider3.setValue(t2);
    slider2.setValue(t1);
    //print(t1); print(",  "); print(t2); print(", "); println(90 + (t1+t2));
    //t3 = -(90 + (t1+t2)); // to keep gripper normal to surface
    //if(t3 < 0) t3 = 0;
    slider4.setValue(t3);
  } else {
    return 1; 
  }
    
    
  return 0;
}

void updateFK(){
  q[0] = slider1.getValueI() * deg2rad;  // base angle
  q[1] = slider2.getValueI() * deg2rad;  // shoulder angle
  q[2] = slider3.getValueI() * deg2rad;  // elbow angle
  q[3] = slider4.getValueI() * deg2rad;  // wrist pitch
  q[4] = slider5.getValueI() * deg2rad;  // not used
  q[5] = slider6.getValueI() * deg2rad;  // wrist rotation
    
  fk_solver();  //call to FK, returns px, py and pz
                //remember py and pz are reversed to stay consistent
                //with existing nomenclature
  //print(px); print(", ");print(py); print(", ");println(pz);

  slider2d2.setValueXY(px, pz);
    
  label14.setText(""+px);
  label15.setText(""+pz);
}

void GripperFixedPitch() {
    if(FixedAxis == 1) {
      int alpha = -(slider2.getValueI()+slider3.getValueI());
      int alpha1 = -(slider2.getValueI()-slider3.getValueI());
      
      if( Normal == 1) {
        if(slider3.getValueI() < 0){
          slider4.setValue(alpha + 5);
        } else {
          slider4.setValue(alpha1 - 5);
        }
      }
      
      if( Parallel == 1) {
        if(slider3.getValueI() < 0){
          slider4.setValue(90+(alpha - 1));
        } else {
          slider4.setValue(90-(alpha1 + 1));
        }
      }
      
      if( Angled == 1) {
          slider4.setValue(90);
      }
    }
}

void GripperFixedPitchAngle() {
    if(FixedAxis == 1) {
      double alpha = -(q[1]+q[2])*rad2deg;
      double alpha1 = -(q[1]-q[2]*rad2deg);
      
      if( Normal == 1) {
        if(q[2] < 0){
          q[3] = (alpha + 5) * deg2rad;
        } else {
          q[3] = (alpha1 - 5) * deg2rad;
        }
      }
      
      if( Parallel == 1) {
        if(q[2] < 0){
          q[3] = (90+(alpha - 1)) * deg2rad;
        } else {
          q[3] = (90-(alpha1 + 1)) * deg2rad;
        }
      }
      
      if( Angled == 1) {
          q[3] = 90.0 * deg2rad;
      }      
    }
}

void moveJoints(int joint, float angle) {
    //moveJoints(1, (float) q[1]*rad2deg);
    //print("" + joint + "," + Float.toString(angle * rad2deg) +"\n");
    myPort.clear();
    myPort.write("" + joint + "," + Float.toString(angle * rad2deg) +"\n");
    acknowledge();
}

void movePosition() {
  float t0, t1, t2, t3, t4, t5;
  int flag0, flag1, flag2, flag3;
  //String s;
  
  flag0 = flag1 = flag2 = flag3 = 0;
  t0 = t1 = t2 = t3 = 0.0;
  
  GripperFixedPitchAngle();
  //updateFK();
  

  
  for( int ii = 0; ii < 6; ii++) {
    print(q[ii]*180/3.1451); print("    "); }
  println(); println();

  t0 = (float) q[0]*rad2deg;
  t1 = (float) q[1]*rad2deg;
  t2 = (float) q[2]*rad2deg;
  t3 = (float) q[3]*rad2deg;
  t4 = (float) q[4]*rad2deg;
  t5 = (float) q[5]*rad2deg; 
  
  //Failsafe to avoid going beyond angle limits,i.e., set stops
  if(t0 < -80 || t0 > 80) flag0 = 1;
  if(t1 < 10 || t1 > 160) flag1 = 1;
  if(t2 < -150 || t2 > 45) flag2 = 1;
  if(t3 < 0 || t3 > 180) flag3 = 1;

  if((flag0+flag1+flag2+flag3) == 0 ) {
    slider1.setValue(t0);
    slider3.setValue(t2);
    slider2.setValue(t1);
    slider4.setValue(t3);

    s = String.format("%.2f, %.2f, %.2f, %.2f, %.2f, %.2f", t0, t1, t2, t3, t4, t5);
    txaAngles.setText(txaAngles.getText() + s + '\n');
    
    //moveJoints(0, (float) q[0]);
    //moveJoints(2, (float) q[2]);
    //moveJoints(1, (float) q[1]);
    //moveJoints(3, (float) q[3]);
  } 
}