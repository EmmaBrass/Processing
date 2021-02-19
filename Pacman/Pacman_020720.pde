int directionx;
int directiony;

int gap_w = 100;

int pacx = 100;
int pacy = 100;

int radius = 80;

int next;

int loc;

int[][] dot_array = new int[800][800];

Virus[] viruses = new Virus[4];

PFont ready;


void setup() {
  size(800,800);
  colorMode(HSB,360,100,100);
  
  ready = createFont("emulogic.ttf", 60);
  
  for (int n=0; n<800; n++) {
    for (int m=0; m<800; m++) {
      dot_array[n][m] = 1;
    }
  }
  
  //set initial positions of the viruses:
  viruses[0] = new Virus(700,300,1,-1);
  viruses[1] = new Virus(400,300,1,1);
  viruses[2] = new Virus(400,700,1,1);
  viruses[3] = new Virus(700,700,1,-1);
  
}


void draw() {
  
  if(millis() < 7000) {
  background(0,0,0);
  barriers();
  dots();
  
  
  fill(60,100,100);
  noStroke();
  arc(100, 100, radius, radius, map(150, 0, 250, PI/3, 0), map(150, 0, 250, TWO_PI - PI/3, TWO_PI) );
  
  textFont(ready);
  textAlign(CENTER, CENTER);
  fill(60,100,100);
  text("READY!", 400, 400);
  
  } else {
    
  background(0,0,0);
  barriers();
  dots();
    
  
  //If pacman position is equal to virus position, then the virus should not appear
  for (int n=0; n<viruses.length; n++) {
    viruses[n].render();
    if(viruses[n].vx > pacx-10 & viruses[n].vx < pacx+10 & viruses[n].vy > pacy-10 & viruses[n].vy < pacy+10) {
      viruses[n].virus_gone = 0;
    }
  }
  
  pacman();
  }
  
}

void barriers() {
  stroke(240,100,100);
  strokeWeight(7);
  fill(200,100,5);
  
  rect(0,0,800,50);
  rect(0,750,800,50);
  rect(0,150,50,500);    //gap_w = 100
  rect(750,150,50,500);
  
  rect(150,150,200,300);
  rect(450,150,200,200);
  rect(450,450,200,200);
  rect(150,550,200,100);
   
}


void dots() {
  loadPixels();
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      int check = 20;
      loc = x+y*width;
      if( x%50 == 0 & y%50 == 0 & brightness(pixels[loc]) == 0) {
        if(brightness(pixels[(x-check)+(y-check)*width]) == 0 & brightness(pixels[(x+check)+(y+check)*width]) == 0 & brightness(pixels[(x-check)+(y+check)*width]) == 0 & brightness(pixels[(x+check)+(y-check)*width]) == 0) {
          if( dot_array[x][y] == 1) {
            stroke(0,0,100);
          } else {
            stroke(0,0,100,0);
          }
          strokeWeight(7);
          strokeCap(PROJECT);
          point(x,y);
        }
      }
    }
  }
}


void pacman() {

      pushMatrix();
      translate(pacx, pacy);
      if ( directionx == 1) { 
        rotate(0);
      }
      if ( directionx == -1) { 
        rotate(PI);
      }
      if ( directiony == 1) { 
        rotate(HALF_PI);
      }
      if ( directiony == -1) { 
        rotate(3*PI/2);
      }
      
      fill(60,100,100);
      noStroke();
      
      if((millis() % 500) > 250) {
        arc(0, 0, radius, radius, map((millis() % 500), 251, 500, 0, PI/3), map((millis() % 500), 251, 500, TWO_PI, TWO_PI - PI/3) );
      }
      
      if((millis() % 500) <= 250) {
        arc(0, 0, radius, radius, map((millis() % 500), 0, 250, PI/3, 0), map((millis() % 500), 0, 250, TWO_PI - PI/3, TWO_PI) );
      }
      
      if(pacx<800 & pacy<800) {
        dot_array[pacx][pacy] = 0;
      }
      
      popMatrix();

}



void keyPressed() {
  loadPixels();
  int check = 45;
  if (key == CODED) {
    if (keyCode == LEFT) {
      next = pacx - 10;
      //if(next-check < 0) {
      //  next = 799;
      //}
      if(brightness(pixels[(next-check)+(pacy-check)*width]) == 0 & brightness(pixels[(next+check)+(pacy+check)*width]) == 0 & brightness(pixels[(next-check)+(pacy+check)*width]) == 0 & brightness(pixels[(next+check)+(pacy-check)*width]) == 0) {
        pacx = next;
      }
      directionx = -1;
      directiony = 0;
    }
    else if (keyCode == RIGHT) {  
      next = pacx + 10;
      if(brightness(pixels[(next-check)+(pacy-check)*width]) == 0 & brightness(pixels[(next+check)+(pacy+check)*width]) == 0 & brightness(pixels[(next-check)+(pacy+check)*width]) == 0 & brightness(pixels[(next+check)+(pacy-check)*width]) == 0) {
        pacx = next;
      }
      directionx = 1;
      directiony = 0;
    }
    else if (keyCode == UP) {
      next = pacy - 10;
      if(brightness(pixels[(pacx-check)+(next-check)*width]) == 0 & brightness(pixels[(pacx+check)+(next+check)*width]) == 0 & brightness(pixels[(pacx-check)+(next+check)*width]) == 0 & brightness(pixels[(pacx+check)+(next-check)*width]) == 0) {
        pacy = next;
      }
      directionx = 0;
      directiony = -1;
    }
    else if (keyCode == DOWN) { 
      next = pacy + 10;
      if(brightness(pixels[(pacx-check)+(next-check)*width]) == 0 & brightness(pixels[(pacx+check)+(next+check)*width]) == 0 & brightness(pixels[(pacx-check)+(next+check)*width]) == 0 & brightness(pixels[(pacx+check)+(next-check)*width]) == 0) {
        pacy = next;
      }
      directionx = 0;
      directiony = 1;
    }
  }
  
  if(pacx > 800) {
    pacx = 0;
  }
  if(pacx < 0) {
    pacx = 800;
  }
  
}
