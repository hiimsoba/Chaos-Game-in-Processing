final int NUMPOINTS = 6;
PVector[] startingPoints;
PVector currentPoint;

float factor = 0.50;
int iterations = 500;

float angle_offset = PI / 3.5;

final int prev_len = 1;
int[] previousPoints;
boolean previous = true;
int prev_idx = 0;

void setup() {
  // set the canvas, black background
  //size(800, 600);
  fullScreen();
  background(0);

  // set the drawing options
  strokeWeight(1);
  stroke(255, 255, 255, 20);

  // initialize the starting points array
  startingPoints = new PVector[NUMPOINTS];

  // add the points around a circle
  for (int i = 0; i < NUMPOINTS; i++) {
    // angle of the point
    float angle = i * TWO_PI / NUMPOINTS + angle_offset;
    // x = r * cos(a)
    // y = r * sin(a)
    // r is like width / 2 or whatever
    startingPoints[i] = new PVector(floor((height / 2) * cos(angle) + width / 2), floor((height / 2) * sin(angle) + height / 2)); 
    // also draw
    //point(startingPoints[i].x, startingPoints[i].y);
  }

  // and get a random current point
  currentPoint = new PVector(floor(random(width)), floor(random(height)));

  // and set the framerate and antialiasing to something crazy, 'cuz why not
  frameRate(150000000);
  smooth(123456789);

  previousPoints = new int[prev_len];
  for (int i = 0; i < previousPoints.length; i++) {
    previousPoints[i] = -1;
  }
}

void draw() {
  // to speed up the drawing process, do 100 points ( or whatever the iterations are set to ) per frame
  for (int i = 0; i < iterations; i++) {
    // get a random number between [0, NUMPOINTS)
    int idx = floor(random(NUMPOINTS));

    // if we got the same point as the previous one, ignore and continue
    if (previous) {
      boolean cont = false;
      for (int k = 0; k < previousPoints.length; k++) {
        if (previousPoints[k] == idx) {
          cont = true;
          break;
        }
      }
      if (cont) {
        continue;
      }
    }

    // draw the current point
    point(currentPoint.x, currentPoint.y);

    // and set our current point to be at the middle of the distance between itself and startingPoints[idx]
    currentPoint.x = lerp(currentPoint.x, startingPoints[idx].x, factor);
    currentPoint.y = lerp(currentPoint.y, startingPoints[idx].y, factor);

    previousPoints[prev_idx] = idx;
    prev_idx = (prev_idx + 1) % previousPoints.length;
  }
}
