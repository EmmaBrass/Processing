//Processing program for an animated version of Joy Division's 1979 album Unknown Pleasures
//Creates a series of png images that must be combined to create a movie
//Author: Emma Brass

int xMin = 250;
int xMax = 550;
int yMin = 200;
int yMax = 600;

float xMid;

int amplitude = 350;  //multiple for increasing amplitude of the normal distributions
int ampChange = 4;  //change in the amplitude for yReset() method

int nLines = 80;  //number of horizontal lines
int nPoints = 60;  //number of points in each line

float dx;  //x difference between each line
float dy;  //y difference between each point in a line

int[] nModes = new int[nLines];  //Number of normal distributions contributing to each line

FloatList[] sigmas = new FloatList[nLines];  //An array of FloatLists; 1 array for each line, 1 FloatList for each normal distribution contributing to the line.  Sigma values for normal distributions

FloatList[] mus_changeable = new FloatList[nLines];  //An array of FloatLists; 1 array for each line, 1 FloatList for each normal distribution contributing to the line.  Mu values for normal distributions
FloatList[] mus_change = new FloatList[nLines];  //An array of FloatLists; 1 array for each line, 1 FloatList for each normal distribution contributing to the line.  Value for the change in mu for each iteration of draw()

float changeRan;  //used for setting the values of mus_change[]

float[][] yValues = new float[nLines][nPoints];  //2D array for the y values of each point
float[][] xValues = new float[nLines][nPoints];  //2D array for the x values of each point
  
float[][] yValRan = new float[nLines][nPoints];  //2D array for randomness in the y direction for each point

//floats used in the muChange() method:
float change;
float current;
float new_val;


void setup() {  //runs once
  size(800,800);
  background(0);
  stroke(255);
  strokeWeight(1);
  
  xMid = (xMax+xMin)/2;
  
  dx = (xMax - xMin) / nPoints;
  dy = (yMax - yMin) / nLines;
  
  //set the number of normal distributions for each line, and their mu and sigma values:
  for (int i=0; i<nLines; i++) {
    nModes[i] = int(random(2,4));
    sigmas[i] = new FloatList();
    mus_changeable[i] = new FloatList();
    mus_change[i] = new FloatList();
    for (int j=0; j<nModes[i]; j++) {
      if (random(0,10) < 5) {
        changeRan = 0.7;
      } else {
        changeRan = -0.7;
      }
      mus_changeable[i].append(random(xMid-45, xMid+45));
      sigmas[i].append(random(5, 25));  
      mus_change[i].append(changeRan);
    }
  }
   
  //set the x values, y values, and y randomness of all the points
  for (int i = 0; i < nLines; i++) {       // i = line number
    for (int j = 0; j < nPoints; j++) {    // j = point number
      xValues[i][j] = xMin + (dx*j);
      float yval = yMin + (dy*i) - amplitude*sumPDF(i,xValues[i][j]);                  //y value from the summed normal distributions function
      yValRan[i][j] = random(-1,1);                                                    //randomness for the y value
      yValues[i][j] = yval + (yValRan[i][j] * (((yMin + dy*i) - yval) + 5) * 0.18);    //final y value = the value from the summed normal distributions function, plus the randomness scaled by the value of y (more randomness for greater y values)
      
    }
  }
 
}


void draw() {  //iterates continuously, for animation
  
  background(0);
  
  //draw the lines
  for (int i = 0; i < nLines; i++) {         // i = line number
    for (int j = 0; j < nPoints-1; j++) {    // j = point number
      for(float k = 0; k<50; k+=0.5) {       //this for loop is used to create a black block below each line, to cover the white lines behind
        stroke(0);
        line(xValues[i][j], yValues[i][j] +k, xValues[i][j+1], yValues[i][j+1] +k);
      }
      stroke(255);
      line(xValues[i][j], yValues[i][j], xValues[i][j+1], yValues[i][j+1]);    //the white lines you see
    }
  }
  
  muChange();
  yReset();

  saveFrame("output/####.png");  //save the resulting image as a png file

}


void yReset() {  //changes y values of all the point, via a change in amplitude and a change in the mu values
  
  if(amplitude > 440 || amplitude < 100) {
    ampChange *= -1;
  }
  
  amplitude += ampChange;
  
  for (int i = 0; i < nLines; i++) {   // i = line number
    for (int j = 0; j < nPoints; j++) {    // j = point number
      float yval = yMin + (dy*i) - amplitude*sumPDF(i,xValues[i][j]);
      yValues[i][j] = yval + (yValRan[i][j] * (((yMin + dy*i) - yval) + 5) * 0.18);   // y2 with some randomness for the line wobble
    }
  }  
  
}


float normalPDF(float x, float mu, float sigma) {  //standard normal distribution functions
  float sigma2 = pow(sigma, 2);
  float numerator = exp(-pow((x - mu), 2) / (2 * sigma2));
  float denominator = sqrt(2 * PI * sigma2);
  return numerator / denominator;
}


float sumPDF(int LineNo, float xvalue) {  //sum of normal distributions that contribute to a specified line
  float pdfSum = 0;
  for (int i=0; i<nModes[LineNo]; i++) {
    pdfSum += normalPDF(xvalue, mus_changeable[LineNo].get(i), sigmas[LineNo].get(i));
    
  }
  return pdfSum;  //the y value
}



void muChange() {  //shifts the mu value of each normal distribution

    for (int i=0; i<nLines; i++) {
      for (int j=0; j<nModes[i]; j++) {
        current = mus_changeable[i].get(j);
        change = mus_change[i].get(j);
        if ( (current >= xMid+45) || (current <= xMid-45) ) {    //When mu hits a certain upper or lower limit, the direction of change switches
          change *= -1;
          mus_change[i].set(j, change);
        }
        new_val = current + change;
        mus_changeable[i].set(j, new_val);
      }
  }
  
}
  
