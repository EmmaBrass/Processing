
class Diamond {
  
  PShape layer1;
  PShape[] layer2 = new PShape[8];
  PShape[] layer3 = new PShape[8];
  PShape[] layer4a = new PShape[8];
  PShape[] layer4b = new PShape[8];
  PShape[] layer5a = new PShape[8];
  PShape[] layer5b = new PShape[8];
  PShape[] layer6 = new PShape[8];
  
  float r1 = 45;
  float r2 = 60;
  float r3 = 70;
  float r4 = 37;
  
  float r1_z = 50;
  float r2_z = 45;
  float r3_z = 30;
  float r4_z = -10;
  float r5_z = -50;
  
  float angle = 0;
  
  int next;
  int prev;
  
  float[] radius1_x = new float[8];
  float[] radius1_y = new float[8];
  
  float[] radius2_x = new float[8];
  float[] radius2_y = new float[8];
  
  float[] radius3a_x = new float[8];
  float[] radius3a_y = new float[8];
  
  float[] radius3b_x = new float[8];
  float[] radius3b_y = new float[8];
  
  float[] radius4_x = new float[8];
  float[] radius4_y = new float[8];
  
  //color settings:
  int h = 200;
  int s = 40;
  int b = 100;
  int alpha = 80;
  int spec_h = 190;
  int spec_s = 0;
  int spec_b = 100;
  int amb_h = 00;
  int amb_s = 00;
  int amb_b = 30;
  int shin = 20;
  
  

  Diamond() {
    
    angle = 0;
    for(int n=0;n<8;n++) {
      radius1_x[n] = r1*cos(angle);
      radius1_y[n] = r1*sin(angle);
      angle+=PI/4;
    }
    
    angle = PI/8;
    for(int n=0;n<8;n++) {
      radius2_x[n] = r2*cos(angle);
      radius2_y[n] = r2*sin(angle);
      angle+=PI/4;
    }
    
    angle = 0;
    for(int n=0;n<8;n++) {
      radius3a_x[n] = r3*cos(angle);
      radius3a_y[n] = r3*sin(angle);
      angle+=PI/4;
    }
    
    angle = PI/8;
    for(int n=0;n<8;n++) {
      radius3b_x[n] = r3*cos(angle);
      radius3b_y[n] = r3*sin(angle);
      angle+=PI/4;
    }
    
    angle = PI/8;
    for(int n=0;n<8;n++) {
      radius4_x[n] = r4*cos(angle);
      radius4_y[n] = r4*sin(angle);
      angle+=PI/4;
    }
    
    layer1 = createShape();
    layer1.beginShape();
    layer1.fill(h,s,b,alpha);
    layer1.specular(spec_h,spec_s,spec_b);
    layer1.ambient(amb_h,amb_s,amb_b);
    layer1.shininess(shin);
    for(int n=0;n<8;n++) {
      layer1.vertex(radius1_x[n],radius1_y[n],r1_z);
    }
    layer1.endShape(CLOSE);
    
    for(int n=0;n<8;n++) {
      if(n==7) {
        next = 0;
      } else {
        next = n+1;
      }
      layer2[n] = createShape();
      layer2[n].beginShape();
      layer2[n].fill(h,s,b,alpha);
      layer2[n].specular(spec_h,spec_s,spec_b);
      layer2[n].ambient(amb_h,amb_s,amb_b);
      layer2[n].shininess(shin);
      layer2[n].vertex(radius1_x[n],radius1_y[n],r1_z);
      layer2[n].vertex(radius1_x[next],radius1_y[next],r1_z);
      layer2[n].vertex(radius2_x[n],radius2_y[n],r2_z);
      layer2[n].endShape(CLOSE);
    }
    
    for(int n=0;n<8;n++) {
      if(n==0) {
        prev = 7;
      } else {
        prev = n-1;
      }
      layer3[n] = createShape();
      layer3[n].beginShape();
      layer3[n].fill(h,s,b,alpha);
      layer3[n].specular(spec_h,spec_s,spec_b);
      layer3[n].ambient(amb_h,amb_s,amb_b);
      layer3[n].shininess(shin);
      layer3[n].vertex(radius1_x[n],radius1_y[n],r1_z);
      layer3[n].vertex(radius2_x[n],radius2_y[n],r2_z);
      layer3[n].vertex(radius3a_x[n],radius3a_y[n],r3_z);
      layer3[n].vertex(radius2_x[prev],radius2_y[prev],r2_z);
      layer3[n].endShape(CLOSE);
    }
    
    for(int n=0;n<8;n++) {
      layer4a[n] = createShape();
      layer4a[n].beginShape();
      layer4a[n].fill(h,s,b,alpha);
      layer4a[n].specular(spec_h,spec_s,spec_b);
      layer4a[n].ambient(amb_h,amb_s,amb_b);
      layer4a[n].shininess(shin);
      layer4a[n].vertex(radius3a_x[n],radius3a_y[n],r3_z);
      layer4a[n].vertex(radius3b_x[n],radius3b_y[n],r3_z);
      layer4a[n].vertex(radius2_x[n],radius2_y[n],r2_z);
      layer4a[n].endShape(CLOSE);
    }
    
    for(int n=0;n<8;n++) {
      if(n==7) {
        next = 0;
      } else {
        next = n+1;
      }
      layer4b[n] = createShape();
      layer4b[n].beginShape();
      layer4b[n].fill(h,s,b,alpha);
      layer4b[n].specular(spec_h,spec_s,spec_b);
      layer4b[n].ambient(amb_h,amb_s,amb_b);
      layer4b[n].shininess(shin);
      layer4b[n].vertex(radius3a_x[next],radius3a_y[next],r3_z);
      layer4b[n].vertex(radius3b_x[n],radius3b_y[n],r3_z);
      layer4b[n].vertex(radius2_x[n],radius2_y[n],r2_z);
      layer4b[n].endShape(CLOSE);
    }
    
    for(int n=0;n<8;n++) {
      layer5a[n] = createShape();
      layer5a[n].beginShape();
      layer5a[n].fill(h,s,b,alpha);
      layer5a[n].specular(spec_h,spec_s,spec_b);
      layer5a[n].ambient(amb_h,amb_s,amb_b);
      layer5a[n].shininess(shin);
      layer5a[n].vertex(radius3a_x[n],radius3a_y[n],r3_z);
      layer5a[n].vertex(radius3b_x[n],radius3b_y[n],r3_z);
      layer5a[n].vertex(radius4_x[n],radius4_y[n],r4_z);     
      layer5a[n].endShape(CLOSE);
    }
    
    for(int n=0;n<8;n++) {
      if(n==7) {
        next = 0;
      } else {
        next = n+1;
      }
      layer5b[n] = createShape();
      layer5b[n].beginShape();
      layer5b[n].fill(h,s,b,alpha);
      layer5b[n].specular(spec_h,spec_s,spec_b);
      layer5b[n].ambient(amb_h,amb_s,amb_b);
      layer5b[n].shininess(shin);
      layer5b[n].vertex(radius3a_x[next],radius3a_y[next],r3_z);
      layer5b[n].vertex(radius3b_x[n],radius3b_y[n],r3_z);
      layer5b[n].vertex(radius4_x[n],radius4_y[n],r4_z);    
      layer5b[n].endShape(CLOSE);
    }

    
    for(int n=0;n<8;n++) {
      if(n==0) {
        prev = 7;
      } else {
        prev = n-1;
      }
      layer6[n] = createShape();
      layer6[n].beginShape();
      layer6[n].fill(h,s,b,alpha);
      layer6[n].specular(spec_h,spec_s,spec_b);
      layer6[n].ambient(amb_h,amb_s,amb_b);
      layer6[n].shininess(shin);
      layer6[n].vertex(0,0,r5_z);
      layer6[n].vertex(radius4_x[n],radius4_y[n],r4_z);        
      layer6[n].vertex(radius3a_x[n],radius3a_y[n],r3_z);
      layer6[n].vertex(radius4_x[prev],radius4_y[prev],r4_z);       
      layer6[n].endShape(CLOSE);
    }

  }
  
  void display() {
    shape(layer1);
    for(int n=0;n<8;n++) {
      shape(layer2[n]);
    }
    for(int n=0;n<8;n++) {
      shape(layer3[n]);
    }
    for(int n=0;n<8;n++) {
      shape(layer4a[n]);
    }
    for(int n=0;n<8;n++) {
      shape(layer4b[n]);
    }
    for(int n=0;n<8;n++) {
      shape(layer5a[n]);
    }
    for(int n=0;n<8;n++) {
      shape(layer5b[n]);
    }
    for(int n=0;n<8;n++) {
      shape(layer6[n]);
    }
  }
  
}
