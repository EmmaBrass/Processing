PImage beach;

PImage shells_one;
PImage shells_two;
PImage shells_three;
PImage shells_four;
PImage shells_five;
PImage shells_six;

IntDict two_inventory;
IntDict one_inventory;

PImage one;
PImage two;

PImage two_copy;

IntList one_pixels;
IntList two_pixels;

int two_scale = 800;

int two_x_orig;
int two_y_orig;

int num = 0;

ArrayList<PVector> direction = new ArrayList<PVector>();
ArrayList<PVector> one_location = new ArrayList<PVector>();
ArrayList<PVector> two_location = new ArrayList<PVector>();

float point_x;
float point_y;

int total_steps = 3;
int step = 0;

IntList one_pixels_sorted;
IntList two_pixels_sorted;

float h;
float s;
float b;
float a;

int pic = 0;
int load = 0;


void setup() {
  
  size(800,800);
  colorMode (HSB,360,100,100,100);
  imageMode(CENTER);
  
  beach = loadImage("beach1.jpg");
  beach.resize(800,800);
  
  shells_one = loadImage("colorshell.png");
  shells_one.resize(800,800);
  shells_two = loadImage("4shells.png");
  shells_two.resize(800,800);
  shells_three = loadImage("16shells.png");
  shells_three.resize(800,800);
  shells_four = loadImage("64shells.png");
  shells_four.resize(800,800);
  shells_five = loadImage("128shells.png");
  shells_five.resize(800,800);
  shells_six = loadImage("256shells.png");
  shells_six.resize(800,800);


  one_pixels = new IntList();
  two_pixels = new IntList();
  
  //Set up a key/value array for the pixels in image two
  two_inventory = new IntDict();
  
  two_pixels_sorted = new IntList();
  
  //Set up a key/value array for the pixels in image two
  one_inventory = new IntDict();
  
  one_pixels_sorted = new IntList(); 
  
}

void pic_setup() {

  one.resize(two_scale,0);
  
  //find the number of pixels that make up one. If hue != green, then add that pixel loc to the array list one_pixels.  
  for(int x=0; x<one.width; x++) {
    for(int y=0; y<one.height; y++) {
      int loc = x+y*one.width;
      if (alpha(one.pixels[loc]) != 0) {
        one_pixels.append(loc);
      }
    }
  }
  
  two_x_orig = two.width;
  two_y_orig = two.height;
  
  two_scale = one.width - 300;
  
  //while loop to make both one and two have approximately the same number of pixels in them:
  while (num == 0) {
    
    //Make two_copy the original size of two
    two_copy.resize(two.width, two.height);
    
    //Make two_copy identical to two
    for(int x=0; x<two.width; x++) {
      for(int y=0; y<two.height; y++) {
        int loc = x+y*two.width;
        two_copy.pixels[loc] = two.pixels[loc];
      }
    }

    //Resize image two_copy.  Starts off very small.  
    two_copy.resize(two_scale,0);
  
    //find number of pixels that make up image two_copy for the set size.  
    for(int x=0; x<two_copy.width; x++) {
      for(int y=0; y<two_copy.height; y++) {
        int loc = x+y*two_copy.width;
        if (alpha(two_copy.pixels[loc]) != 0) {
          two_pixels.append(loc);
        }
      }
    }
    
    //check if the number of pixels in image one is equal to the number of pixels in image two_copy.  If not, increase size of image two.  
    if (one_pixels.size() <= two_pixels.size()) {
      num = 1;
    } else {
      two_scale++;
      //two_y++;
      two_pixels.clear();
    }

  }

  //Make two the right size
  two.resize(two_scale,0);
  //note that two will have slightly more pixels than one
  
  
  //Now, make an array with the hue of each pixel in each image.
  //the array two_pixels stores the loc of each pixel that is not translucent
  two.loadPixels();
  for(int n=0; n<two_pixels.size(); n++) {
    String pixelloc = str(two_pixels.get(n));                                                  
    two_inventory.set(pixelloc,int(hue(two.pixels[two_pixels.get(n)])));   
  }
  
  //Sort the two_inventory by the value (the hue).
  two_inventory.sortValues();

  // Make an a new array with the KEYS (the pixel locators); the pixels will now be in the new array, ordered by hue.
  String[] two_sorted_pixels_string = two_inventory.keyArray();
  
  
  
  //Need to convert the string array into an int array. -> use a for loop.
  for (int n=0; n<two_sorted_pixels_string.length; n++) {
    two_pixels_sorted.append(int(two_sorted_pixels_string[n]));
  }
  
  
  //need to add some extra bits on to the end of the smaller image (if there is one), so it has the same number of pixels as the slightly bigger image.  (large.length - small.length).  
  if (one_pixels.size() < two_pixels.size()) {
    int difference = two_pixels.size() - one_pixels.size();
    int last = one_pixels.get(one_pixels.size()-1);
    for (int n=0; n<difference; n++) {
      one_pixels.append(last);
    }
  }

  
  //Now, do the same for image one.  
  
  //Now, make an array with the hue of each pixel in each image.
  //the array two_pixels stores the loc of each pixel that is not translucent
  one.loadPixels();
  for(int n=0; n<one_pixels.size(); n++) {
    String pixelloc = str(one_pixels.get(n));                                                  
    one_inventory.set(pixelloc,int(hue(one.pixels[one_pixels.get(n)])));     //the added pixels are lost here because you can't have a key repeated.  
  }
  
  //Sort the two_inventory by the value (the hue).
  one_inventory.sortValues();
  
  // Make an a new array with the KEYS (the pixel locators); the pixels will now be in the new array, ordered by hue.
  String[] one_sorted_pixels_string = one_inventory.keyArray();
  
  //Need to convert the string array into an int array. -> use a for loop.
  for (int n=0; n<one_sorted_pixels_string.length; n++) {
    one_pixels_sorted.append(int(one_sorted_pixels_string[n]));
  }

  
  //make the vectors between corresponsing pixel locations.
  //PVector[] vectors = new PVector[one_sorted_pixels_int.length];
  
  //Check the images heights and widths, then make the x and y values from the pixel loc, then make the vectors.  
  if( one.width >= two.width & one.height >= two.height ) {
    int xdif = (one.width - two.width) /2;
    int ydif = (one.height - two.height ) /2;
    for (int n=0; n<one_pixels_sorted.size(); n++) {
      int one_x = one_pixels_sorted.get(n) % one.width;
      int one_y = (one_pixels_sorted.get(n) - one_x) / one.width;
      int two_x = two_pixels_sorted.get(n) % two.width;
      int two_y = (two_pixels_sorted.get(n) - two_x) / two.width;
      direction.add(new PVector( (two_x + xdif) - one_x , (two_y + ydif) - one_y ));
      one_location.add(new PVector( one_x, one_y ) );
      two_location.add(new PVector( (two_x + xdif), (two_y + ydif) ) );
    }
  }
  
  if( one.width <= two.width & one.height >= two.height ) {
    int xdif = (two.width - one.width) /2;
    int ydif = (one.height - two.height ) /2;
    for (int n=0; n<one_pixels_sorted.size(); n++) {
      int one_x = one_pixels_sorted.get(n) % one.width;
      int one_y = (one_pixels_sorted.get(n) - one_x) / one.width;
      int two_x = two_pixels_sorted.get(n) % two.width;
      int two_y = (two_pixels_sorted.get(n) - two_x) / two.width;
      direction.add(new PVector( two_x - (one_x + xdif) , (two_y + ydif) - one_y ));
      one_location.add(new PVector( (one_x + xdif) , one_y ) );
      two_location.add(new PVector( two_x , (two_y + ydif) ) );
    }
  }
  
  if( one.width >= two.width & one.height <= two.height ) {
    int xdif = (one.width - two.width) /2;
    int ydif = (two.height - one.height ) /2;
    for (int n=0; n<one_pixels_sorted.size(); n++) {
      int one_x = one_pixels_sorted.get(n) % one.width;
      int one_y = (one_pixels_sorted.get(n) - one_x) / one.width;
      int two_x = two_pixels_sorted.get(n) % two.width;
      int two_y = (two_pixels_sorted.get(n) - two_x) / two.width;
      direction.add(new PVector( (two_x + xdif) - one_x , two_y - (one_y + ydif) ));
      one_location.add(new PVector( one_x , (one_y + ydif) ) );
      two_location.add(new PVector( (two_x + xdif) , two_y ) );
    }
  }
  
  if( one.width <= two.width & one.height <= two.height ) {
    int xdif = (two.width - one.width) /2;
    int ydif = (two.height - one.height ) /2;
    for (int n=0; n<one_pixels_sorted.size(); n++) {
      int one_x = one_pixels_sorted.get(n) % one.width;
      int one_y = (one_pixels_sorted.get(n) - one_x) / one.width;
      int two_x = two_pixels_sorted.get(n) % two.width;
      int two_y = (two_pixels_sorted.get(n) - two_x) / two.width;
      direction.add(new PVector( two_x - (one_x + xdif) , two_y - (one_y + ydif) ));
      one_location.add(new PVector( (one_x + xdif) , (one_y + ydif) ) );
      two_location.add(new PVector( two_x , two_y ) );
    }
  }
 
}


void draw() {
  
  
  if (load == 0 & pic == 0) {
    one = shells_one;
    two = shells_two;
    two_copy = createImage(two.width,two.height,HSB);
    load = 1;
    pic_setup();
  }
  if (load == 0 & pic == 1) {
    one = shells_two;
    one.resize(two_scale,0);
    two = shells_three;
    load = 1;
    pic_setup();
  }
  if (load == 0 & pic == 2) {
    one = shells_three;  
    one.resize(two_scale,0);
    two = shells_four;   
    load = 1;
    pic_setup();
  }
  if (load == 0 & pic == 3) {
    one = shells_four;  
    one.resize(two_scale,0);
    two = shells_five;    
    load = 1;
    pic_setup();
  }
  if (load == 0 & pic == 4) {
    one = shells_five;
    one.resize(two_scale,0);
    two = shells_six;
    load = 1;
    pic_setup();
  }

  

  if ( step <= total_steps & load == 1) {

    image(beach,400,400);
    
    float inc = map(step,0,total_steps,0,1);
    
    one.loadPixels();
    two.loadPixels();
    for(int n=0; n<direction.size(); n++) {
      PVector loc = one_location.get(n);
      PVector dir = direction.get(n);
      point_x = loc.x + ((dir.x/total_steps)*step); 
      point_y = loc.y + ((dir.y/total_steps)*step);
      if( step == total_steps) {
        h = hue(two.pixels[two_pixels_sorted.get(n)]);
        s = saturation(two.pixels[two_pixels_sorted.get(n)]);
        b = brightness(two.pixels[two_pixels_sorted.get(n)]);
        a = alpha(two.pixels[two_pixels_sorted.get(n)]);
      }
      else {
        h = lerp( hue(one.pixels[one_pixels_sorted.get(n)]),  hue(two.pixels[two_pixels_sorted.get(n)]), inc );
        s = lerp( saturation(one.pixels[one_pixels_sorted.get(n)]),  saturation(two.pixels[two_pixels_sorted.get(n)]), inc );
        b = lerp( brightness(one.pixels[one_pixels_sorted.get(n)]),  brightness(two.pixels[two_pixels_sorted.get(n)]), inc );
        a = lerp( alpha(one.pixels[one_pixels_sorted.get(n)]),  alpha(two.pixels[two_pixels_sorted.get(n)]), inc );
      }
      stroke(h,s,b,a);
      pushMatrix();
      translate((800-two_scale)/4,(800-two_scale)/4);
      point(point_x,point_y);
      popMatrix();
      
    }
    step++;
    
    println(two_scale);
    
    //saveFrame("output2/####.png");
    
  } else {
    pic++;
    step=0;
    load=0;
    num=0;
    two_inventory.clear();
    one_inventory.clear();
    one_pixels.clear();
    two_pixels.clear();
    one_pixels_sorted.clear();
    two_pixels_sorted.clear();
    direction.clear();
    one_location.clear();
    two_location.clear();
    
    // need to clear all the arrays used in pic_setup
  }
  
}
