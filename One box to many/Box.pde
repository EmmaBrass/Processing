
class Box {
  
  float high;
  float wide;
  float deep;
  
  float x;
  float y;
  float z;
  
  float xchange = map(random(0,10),0,10,-0.5,0.5);
  float ychange = map(random(0,10),0,10,-0.5,0.5);
  
  PShape cust_box_front;
  PShape cust_box_back;
  PShape cust_box_bottom;
  PShape cust_box_top;
  PShape cust_box_right;
  PShape cust_box_left;
  
  
  Box(float x_temp, float y_temp, float z_temp, float high_temp, float wide_temp, float deep_temp) {
    
    x = x_temp;
    y = y_temp;
    z = z_temp;
    
    high = high_temp;
    wide = wide_temp;
    deep = deep_temp;
    
    //Front
    cust_box_front = createShape();
    cust_box_front.beginShape(QUADS);
    cust_box_front.fill(30,250,330);
    cust_box_front.vertex(0, 0,  0);
    cust_box_front.vertex( 0, high,  0);
    cust_box_front.vertex(wide,  high,  0);
    cust_box_front.vertex(wide,  0,  0);
    cust_box_front.endShape();
    // Back
    cust_box_back = createShape();
    cust_box_back.beginShape(QUADS);
    cust_box_back.fill(30,250,330);
    cust_box_back.vertex( 0, 0, -deep);
    cust_box_back.vertex(0, high, -deep);
    cust_box_back.vertex(wide, high, -deep);
    cust_box_back.vertex(wide, 0, -deep);
    cust_box_back.endShape();
    
    // Bottom
    cust_box_bottom = createShape();
    cust_box_bottom.beginShape(QUADS);
    cust_box_bottom.fill(150,220,300);
    cust_box_bottom.vertex(0,  high,  0);
    cust_box_bottom.vertex(0,  high,  -deep);
    cust_box_bottom.vertex(wide,  high, -deep);
    cust_box_bottom.vertex(wide,  high, 0);
    cust_box_bottom.endShape();
    
    // Top
    cust_box_top = createShape();
    cust_box_top.beginShape(QUADS);
    cust_box_top.fill(150,220,300);
    cust_box_top.vertex(0, 0, 0);
    cust_box_top.vertex(wide, 0, 0);
    cust_box_top.vertex(wide, 0, -deep);
    cust_box_top.vertex(0, 0, -deep);
    cust_box_top.endShape();
    
    // Right
    cust_box_right = createShape();
    cust_box_right.beginShape(QUADS);
    cust_box_right.fill(270,250,330);
    cust_box_right.vertex(wide, 0,  0);
    cust_box_right.vertex(wide, 0, -deep);
    cust_box_right.vertex(wide, high, -deep);
    cust_box_right.vertex(wide, high,  0);
    cust_box_right.endShape();
    
    // Left
    cust_box_left = createShape();
    cust_box_left.beginShape(QUADS);
    cust_box_left.fill(270,250,330);
    cust_box_left.vertex(0, 0, 0);
    cust_box_left.vertex(0, high,  0);
    cust_box_left.vertex(0,  high,  -deep);
    cust_box_left.vertex(0,  0, -deep);
    cust_box_left.endShape();
    
  }

  
  void display() {
    
    pushMatrix();
    
    //ensure within bounds of box:
    if ( x+wide>600 & y+high>600 ) {
      translate(600-wide,600-high,z);
    } else {
      if (x+wide>600) {
      translate(600-wide,y,z);
      } else{
        if (y+high>600) {
          translate(x,600-high,z);
        } else{
            translate(x,y,z);
          }
        }
      }
      

    //draw:
    shape(cust_box_front);
    shape(cust_box_back);
    shape(cust_box_bottom);
    shape(cust_box_top);
    shape(cust_box_right);
    shape(cust_box_left);
    
    popMatrix();
  
  }
  
  
  void update() {
    
    if (x+wide>=600){  
      xchange= -1;
    }
    if (x<=200){
      xchange = +1;
    }
    if (y+high>=600){  
      ychange = -1;
    }
    if (y<=200){
      ychange = +1;
    }
    
    x+=xchange;
    y+=ychange;

  }
    
  
}
