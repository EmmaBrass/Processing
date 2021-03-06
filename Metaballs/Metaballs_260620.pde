//Main file for creating the animation
//Author: Emma Brass

Shape[] blobs = new Shape[7];

int loc;
color to; 
color from; 
color value;

PImage spag;

void setup() {
  size(800,800);
  colorMode(HSB,360,100,100);
  for(int i=0; i<blobs.length; i++) {
    blobs[i] = new Shape (random(width),random(height));
  }
  
  from = color(150, 10, 30);
  to = color(0, 73, 100);
  
  spag = loadImage("spag.jpg");
  spag.resize(800,800);
   
}

void draw() {
  background(0);
  
  loadPixels();
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      int loc = x+y*width;
      float sum = 0;
      for (Shape b : blobs) {
      float d = dist(x,y, b.pos.x, b.pos.y);
      sum += 200*b.r/d;
      }
      
      float use = sum/700;
      if(use <= 0.2) {
        value = lerpColor(from,to,map(use,0,0.2,1,0));
      } 
      if(use > 0.2 & use <= 0.4 ) {
        value = lerpColor(from,to,map(use,0.2,0.4,0,1));
      }   
      if(use > 0.4 & use <= 0.6 ) {
        value = lerpColor(from,to,map(use,0.4,0.6,1,0));
      }   
      if(use > 0.6 & use < 0.8 ) {
        value = lerpColor(from,to,map(use,0.6,0.8,0,1));
      }  
      if(use >= 0.8) {
        value = lerpColor(from,to,map(use,0.8,1,1,0));
      } 
      pixels[loc] = color(value);
    }
  }
  
  updatePixels();
  
  tint(360, 80);
  image(spag,400,400);
  
  for(Shape b : blobs) {
  b.display();
  b.update();
  }
  
  saveFrame("output3/####.png");
    
}
