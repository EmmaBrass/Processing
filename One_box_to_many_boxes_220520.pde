 // Rotating box that turns into many smaller boxes
 // Author: Emma Brass
 
 
//For camera rotation:
float camx = 0;
float camz = 0;
float camy = 0;
float theta = 0;
float cam_r = 800;

float x;
float y;
float z;

float h;
float w;
float d;

float xsmaller = 0;
float xbigger = 0;


Box[] boxes = new Box[400];

FillBoxes fillers;
BigBox bigbox;

int num = 0;
int rot_num = 0;


void setup() {
  size(800,800,P3D);
  colorMode(HSB,360);
  noStroke();
  
  for (int n=0; n<400; n++) {
    x = random(200,550);
    y = random(200,550);
    z = random(-100,200);
    h = random(5,100);
    w = random(5,100);
    d = random(5,100);
    boxes[n] = new Box(x,y,z,w,h,d);
  }
  fillers = new FillBoxes();
  bigbox = new BigBox(400,400,-95,400,400,400);
}

void draw() {

  //Camera rotation:

  if (num%2 == 0) {
    
    background(80);
    perspective();
    camera(width/2.0 + camx, height/2.0 + camy, 0 + camz, width/2.0, height/2.0, 0, 0, 1, 0);
  
    camx = sin(radians(theta))*cam_r;
    camz = cos(radians(theta))*cam_r;
    camy = sin(radians(theta))*cam_r;
     
    pushMatrix();
    //translate(400,400,-95);
    //fill(20,260,260);
    //box(400,400,400);
    bigbox.display();
    popMatrix();
    if (rot_num <=360){  
      rot_num++;
      theta+=1;
    } else {
      num++;
      rot_num=0;
    }
    
  }
  
  if (num%2 != 0) {
    
    background(80);
    ortho();
    
    camera(width/2.0 + camx, height/2.0 + camy, 0 + camz, width/2.0, height/2.0, 0, 0, 1, 0);
  
    camx = sin(radians(theta))*cam_r;
    camz = cos(radians(theta))*cam_r;
    camy = sin(radians(theta))*cam_r;
      
    for (int n=0; n<400; n++) {
      boxes[n].display();
    }
      
    fillers.display(200+xbigger,200,-50);
    fillers.display(300,200,180);
    fillers.display(400,200,30);
    fillers.display(500+xsmaller,200,130);
    fillers.display(200+xbigger,300,50);
    fillers.display(500+xsmaller,300,20);
    fillers.display(200+xbigger,400,150);
    fillers.display(500+xsmaller,400,-90);
    fillers.display(200+xbigger,500,90);
    fillers.display(300,500,00);
    fillers.display(400,500,160);
    fillers.display(500+xsmaller,500,-40);
    fillers.display(300,300,90);
    fillers.display(300,400,00);
    fillers.display(400,400,160);
    fillers.display(400,300,-40);
     
    
    if(rot_num<=720) {
      if(rot_num<360) {
        xsmaller-=0.5;
        xbigger+=0.5;
      } else {
        xsmaller+=0.5;
        xbigger-=0.5;
      }
      if(rot_num==720) {
        xsmaller=0;
        xbigger=0;
      }
      rot_num++;
      if(rot_num > 40 | rot_num < 400) {
        for (int n=0; n<400; n++) {
          boxes[n].update();
        }
      }
      theta+=0.5;
    } else {
      num++;
      rot_num=0;
      theta = 0;
    }
  }
  
  //saveFrame("output1/####.png");
  
  
}
