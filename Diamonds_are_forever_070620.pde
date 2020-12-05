
Diamond dia;

int no_rc = 5;
int space = 200;

int[] ipos_x = new int[no_rc];
int[] ipos_y = new int[no_rc];
int[] ipos_z = new int[no_rc];

int[] fpos_x = new int[no_rc];
int[] fpos_y = new int[no_rc];
int[] fpos_z = new int[no_rc];

float roti = 180;
float[][] rot = new float[no_rc][no_rc];

float radius;
float angle;

PVector[][] direction = new PVector[no_rc][no_rc];
PVector[][] location = new PVector[no_rc][no_rc];

int n;
int m;
int nturn = 0;
int mturn = 0;

int num = 0;

int xdiv = 30;
int ydiv = 30;
int zdiv = 30;

void setup() {
  size(800,800,P3D);
  hint(DISABLE_DEPTH_MASK);
  frameRate(30);
  colorMode(HSB,360,100,100,100);
  noStroke();
  dia = new Diamond();
  
  for(int n=0;n<no_rc;n++) {
    angle = radians(14*n);
    radius = 300;
    ipos_x[n] = 202+int(cos(angle)*radius);
    ipos_y[n] = 202+int(sin(angle)*radius);
    ipos_z[n] = 1000;
    
  }
  
  for(int n=0;n<no_rc;n++) {
    fpos_x[n] = n*space;
    fpos_y[n] = n*space;
    fpos_z[n] = -250;
  }
  
  for(int n=0;n<no_rc;n++) {
    for(int m=0;m<no_rc;m++) {
      direction[n][m] = new PVector (fpos_x[n]-ipos_x[n], fpos_y[m]-ipos_y[m], fpos_z[n]-ipos_z[n]);
    }
  }
  
  for(int n=0;n<no_rc;n++) {
    for(int m=0;m<no_rc;m++) {
      location[n][m] = new PVector(ipos_x[n],ipos_y[m],ipos_z[n]);
    }
  }
  
  for(int n=0;n<no_rc;n++) {
    for(int m=0;m<no_rc;m++) {
      rot[n][m] = roti;
      roti+=15;
    }
  }
  
}


void draw() {
  background(130);
  directionalLight(0, 0, 100, -1, -1, -1);
  ambientLight(0, 0, 100);
  
  translate(-2,-2,-2);
  for(int n=0;n<no_rc;n++) {
    for(int m=0;m<no_rc;m++) {
      pushMatrix();
      translate(location[n][m].x,location[n][m].y,location[n][m].z);
      rotateX(PI/2);
      //rotateX(radians(-rot[n][m]));
      rotateY(radians(rot[n][m]));
      rotateZ(radians(rot[n][m]));
      dia.display();
      popMatrix();
      rot[n][m]+=1.5;
    }
  }
  
  

  
  if(n<no_rc & m<no_rc) {
    if(location[n][m].z > fpos_z[n]) {
      location[n][m].x += (direction[n][m].x)/15;
      location[n][m].y += (direction[n][m].y)/15;
      location[n][m].z += (direction[n][m].z)/15; 
    } else{
      if(n<no_rc-1) {
        n++;
      } else{
        n=0;
        m++;
      }
    }     
  } else {
    if(num<300) {
    for(int n=0;n<no_rc;n++) {
      for(int m=0;m<no_rc;m++) {
        location[n][m].x -= (direction[n][m].x)/480;             //higher number = smaller step = longer to middle
        location[n][m].y -= ((direction[n][m].y)/300) - 0.3;        //smaller number = bigger step = faster to middle
        location[n][m].z -= ( direction[n][m].z)/420; 
      }
    }
    num ++;
    }
  }
  
  if (num>= 300) {
    for(int n=0;n<no_rc;n++) {
      for(int m=0;m<no_rc;m++) {
        location[n][m].x += ((direction[n][m].x)/70) +0.5;     //higher number = goes slower in that direction
        location[n][m].y += ((direction[n][m].y)/45) - 1.75;   //more negative = higher up
        location[n][m].z += ( direction[n][m].z)/60; 
        
      } 
    }

  }
  
  saveFrame("output3/####.png");

}
