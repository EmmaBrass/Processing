// Class for the metaball object

class Shape {
  
  PVector pos;
  PVector vel;
  float r;
  float pnx;
  float pny;
  
  float rot = random(0,2*PI);
  PImage meatball;
  
  Shape(float x, float y) {
    pos = new PVector(x,y);
    
    if(random(0,1) > 0.5) {
      pnx = -1;
    } else {
      pnx = 1;
    }
    
    if(random(0,1) > 0.5) {
      pny = -1;
    } else {
      pny = 1;
    }
    
    
    vel = new PVector(random(1,2)*pnx,random(1,2)*pny);
    vel.mult(random(2,5));
    r = 100; 
    
    meatball = loadImage("meatball2.png");
    meatball.resize(130,130);
    
  }
  
  void display() {
    pushMatrix();
    imageMode(CENTER);
    noFill();
    noStroke();
    translate(pos.x,pos.y);
    rotate(rot);
    tint(350,20,80);
    image(meatball,0,0);
    ellipse(0,0,r*2,r*2);
    popMatrix();
  }
  
  void update() {
    pos.add(vel);
    if(pos.x > width || pos.x < 0) {
      vel.x *= -1;
    }
    if(pos.y > width || pos.y < 0) {
      vel.y *= -1;
    }

  }
  
}
