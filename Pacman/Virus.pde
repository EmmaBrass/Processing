

class Virus {
  
  PImage virus;
  
  int virus_gone;
  
  int change;
  int vnext;
  
  int check = 46;
  
  int vx;
  int vy;
  
  int xdir = 1;  // if xdir = 1, then x direction. if ydir = 1, then y direction.
  int ydir = 0;
  
  int current_dir;
  
  int num;
  int ran;
  
  int[] available = new int[4];
  
  Virus(int x_initial, int y_initial, int virus_gone_, int change_initial) {
    imageMode(CENTER);
    virus = loadImage("virus.png");
    virus.resize(80,80);
    vx = x_initial;
    vy = y_initial;
    
    virus_gone = virus_gone_;
    change = change_initial;
    
    for (int n=0; n<4; n++) {
      available[n] = 0;
    }

  }
  
  
  
  void render() {  if(virus_gone != 0) {
      
      
      if (current_dir%2 == 0) {
       
        num = 1; 
        vnext = vx + 10;
        if(brightness(pixels[(vnext-check)+(vy-check)*width]) == 0 & brightness(pixels[(vnext+check)+(vy+check)*width]) == 0 & brightness(pixels[(vnext-check)+(vy+check)*width]) == 0 & brightness(pixels[(vnext+check)+(vy-check)*width]) == 0) {
          available[num] = 1;
        }
        
        num = 3; 
        vnext = vx - 10;
        if(brightness(pixels[(vnext-check)+(vy-check)*width]) == 0 & brightness(pixels[(vnext+check)+(vy+check)*width]) == 0 & brightness(pixels[(vnext-check)+(vy+check)*width]) == 0 & brightness(pixels[(vnext+check)+(vy-check)*width]) == 0) {
          available[num] = 1;
        }
           
      }
      
      
      if (current_dir%2 == 1) {
       
        num = 0; 
        vnext = vy - 10;
        if(brightness(pixels[(vx-check)+(vnext-check)*width]) == 0 & brightness(pixels[(vx+check)+(vnext+check)*width]) == 0 & brightness(pixels[(vx-check)+(vnext+check)*width]) == 0 & brightness(pixels[(vx+check)+(vnext-check)*width]) == 0) {
          available[num] = 1;
        }
        
        num = 2; 
        vnext = vy + 10;
        if(brightness(pixels[(vx-check)+(vnext-check)*width]) == 0 & brightness(pixels[(vx+check)+(vnext+check)*width]) == 0 & brightness(pixels[(vx-check)+(vnext+check)*width]) == 0 & brightness(pixels[(vx+check)+(vnext-check)*width]) == 0) {
          available[num] = 1;
        }
           
      }
      
      ran = int(random(0,4));
      if (available[ran] == 1) {
        current_dir = ran;         
        if (ran == 0) {
          change = -1;
        }
        if (ran == 1) {
          change = 1;
        }
        if (ran == 2) {
          change = 1;
        }
        if (ran == 3) {
          change = -1;
        }
      }
        
          
      
      if(current_dir == 1 || current_dir == 3) {
        vnext = vx + change;
        if(brightness(pixels[(vnext-check)+(vy-check)*width]) == 0 & brightness(pixels[(vnext+check)+(vy+check)*width]) == 0 & brightness(pixels[(vnext-check)+(vy+check)*width]) == 0 & brightness(pixels[(vnext+check)+(vy-check)*width]) == 0) {
          vx = vnext;
        } else {
          if (vnext < 50 || vnext > 750) {
            vx = vnext;
          } else {
            ran = int(random(0,4));
            current_dir = ran;         // 0,1,2, or 3
            if (ran == 0) {
              change = -1;
            }
            if (ran == 1) {
              change = 1;
            }
            if (ran == 2) {
              change = 1;
            }
            if (ran == 3) {
              change = -1;
            }
          }
        }
      }
      
      if(current_dir == 0 || current_dir == 2) {
        vnext = vy + change;
        if(brightness(pixels[(vx-check)+(vnext-check)*width]) == 0 & brightness(pixels[(vx+check)+(vnext+check)*width]) == 0 & brightness(pixels[(vx-check)+(vnext+check)*width]) == 0 & brightness(pixels[(vx+check)+(vnext-check)*width]) == 0) {
          vy = vnext;
        } else {
          int ran = int(random(4)); 
          current_dir = ran;          // 0,1,2, or 3
          if (ran == 0) {
            change = -1;
          }
          if (ran == 1) {
            change = 1;
          }
          if (ran == 2) {
            change = 1;
          }
          if (ran == 3) {
            change = -1;
          }
        }
      }
      
      if(vx > 800) {
        vx = 0;
      }
      if(vx < 0) {
        vx = 800;
      }
      
      image(virus,vx,vy);
      
      for (int n=0; n<4; n++) {
        available[n] = 0;
      }
    
  }
  
  //}
  
  }
  
}
