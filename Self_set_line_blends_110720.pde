// Program for pixel blending.  User interaction.
// User clicks fours point, to create two lines.  The pixels between the two lines are blended over the distance between the lines.  
// In the future: get this to work for video
// Author: Emma Brass

int num = 0;

int x1;
int y1;
int x2;
int y2;
int x3;
int y3;
int x4;
int y4;

float start_mag;
float end_mag;

float line_start_x;
float line_start_y;
float line_end_x;
float line_end_y;

float line_mag;

PVector start;
PVector end;

color from;
color to;

ArrayList<PVector> lines = new ArrayList<PVector>();
ArrayList<PVector> starts = new ArrayList<PVector>();
ArrayList<PVector> ends = new ArrayList<PVector>();

PImage image;

void setup() {
  size(800,800);
  start = new PVector(0,0);
  end = new PVector(0,0);

  strokeWeight(3);
  
  image = loadImage("image.jpg");
  image.resize(800,800);
  
  image(image,0,0);
}


void draw() {
  
  if(num == 4) { ///x1!=0 & y1!=0 & x2!=0 & y2!=0 & x3!=0 & y3!=0 & x4!=0 & y4!=0) {
    start.x = x2-x1;
    start.y = y2-y1;
    end.x = x4-x3;
    end.y = y4-y3;
    
    start_mag = start.mag();
    end_mag = end.mag();
    
    for (int n=0; n<start_mag; n++) {
      line_start_x = x1+((start.x/start_mag)*n);
      line_start_y = y1+((start.y/start_mag)*n);
      
      line_end_x = x3+((end.x/start_mag)*n);
      line_end_y = y3+((end.y/start_mag)*n);
      starts.add(new PVector(line_start_x,line_start_y) );
      ends.add(new PVector(line_end_x,line_end_y) );
      lines.add(new PVector( (line_end_x-line_start_x), (line_end_y-line_start_y) ) );
    }
    
    image.loadPixels();
    for (int n=0; n<start_mag; n++) {
      PVector line = lines.get(n);
      line_mag = line.mag();
      PVector line_start = starts.get(n);
      PVector line_end = ends.get(n);
      int x_one = int(line_start.x);
      int y_one = int(line_start.y);
      int x_two = int(line_end.x);
      int y_two = int(line_end.y);
      from = color(image.pixels[x_one+(y_one*800)]); //<>//
      to = color(image.pixels[x_two+(y_two*800)]);
      for (int m=0; m<line_mag; m++) {
        color col = lerpColor(from,to,map(m,0,line_mag,0,1));
        stroke(col);
        point(line_start.x + (m * line.x/line_mag), line_start.y + (m * line.y/line_mag) );
      }  
    }     
  }
}

void mousePressed() {
  num++;
  if(num == 1) {
    if(mouseX<20) {
      x1 = 0;
    }
    if(mouseX>780) {
      x1 = 799;
    }
    if(mouseX>=20 & mouseX<=780) {
      x1 = mouseX;
    }
    if(mouseY<20) {
      y1 = 0;
    }
    if(mouseY>780) {
      y1 = 799;
    }
    if(mouseY>=20 & mouseY<=780) {
      y1 = mouseY;
    }
    
  }
  if(num == 2) {
    if(mouseX<20) {
      x2 = 0;
    }
    if(mouseX>780) {
      x2 = 799;
    }
    if(mouseX>=20 & mouseX<=780) {
      x2 = mouseX;
    }
    if(mouseY<20) {
      y2 = 0;
    }
    if(mouseY>780) {
      y2 = 799;
    }
    if(mouseY>=20 & mouseY<=780) {
      y2 = mouseY;
    }
  }
  if(num == 3) {
    if(mouseX<20) {
      x3 = 0;
    }
    if(mouseX>780) {
      x3 = 799;
    }
    if(mouseX>=20 & mouseX<=780) {
      x3 = mouseX;
    }
    if(mouseY<20) {
      y3 = 0;
    }
    if(mouseY>780) {
      y3 = 799;
    }
    if(mouseY>=20 & mouseY<=780) {
      y3 = mouseY;
    }
  }
  if(num == 4) {
    if(mouseX<20) {
      x4 = 0;
    }
    if(mouseX>780) {
      x4 = 799;
    }
    if(mouseX>=20 & mouseX<=780) {
      x4 = mouseX;
    }
    if(mouseY<20) {
      y4 = 0;
    }
    if(mouseY>780) {
      y4 = 799;
    }
    if(mouseY>=20 & mouseY<=780) {
      y4 = mouseY;
    }
  } 
  if(num == 5) {
    if(mouseX<20) {
      x1 = 0;
    }
    if(mouseX>780) {
      x1 = 799;
    }
    if(mouseX>=20 & mouseX<=780) {
      x1 = mouseX;
    }
    if(mouseY<20) {
      y1 = 0;
    }
    if(mouseY>780) {
      y1 = 799;
    }
    if(mouseY>=20 & mouseY<=780) {
      y1 = mouseY;
    }
    x2 = 0;
    y2 = 0;
    x3 = 0;
    y3 = 0;
    x4 = 0;
    y4 = 0;
    num=1;
    starts.clear();
    ends.clear();
    lines.clear();
  } 
  
}
