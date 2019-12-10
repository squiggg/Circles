final float MAX_CIRCLES = 300, SPAWN_RADIUS = 300, MIN_GREY = 0, MAX_GREY = 255, MIN_SIZE = 50, MAX_SIZE = 75, MIN_SPEED = 0, MAX_SPEED = 10, STROKE_WEIGHT = .5;

ArrayList<Circle> circles = new ArrayList<Circle>();
//ArrayList<float[]> lines = new ArrayList<float[]>();

float t = 0;
String[] modes = new String[] {"center", "x-axis", "y-axis", "circle", "mouse", "random"};
int mode = 0;
String spawnMode = modes[mode];


void setup() {
  size(900, 900);
  background(255);
  strokeWeight(STROKE_WEIGHT);
}

void draw() {

  if (spawnMode == "center") {
    float x  =  width/2;
    float y  =  height/2;
    circles.add(new Circle(x, y, random(MIN_SIZE, MAX_SIZE), random(MIN_SPEED, MAX_SPEED)));
  } else if (spawnMode == "x-axis") {
    float x  =  random(width);
    float y  =  height/2;
    circles.add(new Circle(x, y, random(MIN_SIZE, MAX_SIZE), random(MIN_SPEED, MAX_SPEED)));
  } else if (spawnMode == "y-axis") {
    float x  =  width/2;
    float y  =  random(height);
    circles.add(new Circle(x, y, random(MIN_SIZE, MAX_SIZE), random(MIN_SPEED, MAX_SPEED)));
  } else if (spawnMode == "circle") {
    float x  =  (width/2) + SPAWN_RADIUS * cos(t);
    float y  =  (height/2) + SPAWN_RADIUS * sin(t);
    t+= TWO_PI / 360;
    circles.add(new Circle(x, y, random(MIN_SIZE, MAX_SIZE), random(MIN_SPEED, MAX_SPEED)));
  } else if (spawnMode == "mouse") {
    float x = mouseX;
    float y = mouseY;
    circles.add(new Circle(x, y, random(MIN_SIZE, MAX_SIZE), random(MIN_SPEED, MAX_SPEED)));
  } else if (spawnMode == "random") {
    float x = random(width);
    float y = random(height);
    circles.add(new Circle(x, y, random(MIN_SIZE, MAX_SIZE), random(MIN_SPEED, MAX_SPEED)));
  }

  if (circles.size() > MAX_CIRCLES)
    circles.remove(0);

  for (int i = 0; i < circles.size(); i++) {
    if (circles.get(i).getPosition().x < 0 - circles.get(i).getRadius() || circles.get(i).getPosition().x > width + circles.get(i).getRadius() || circles.get(i).getPosition().y < 0 - circles.get(i).getRadius() || circles.get(i).getPosition().y > height + circles.get(i).getRadius()) {
      circles.remove(i);
      i--;
    } /*else {
     circles.get(i).render();
     }*/
  }


  for (int i = 0; i < circles.size(); i++) {
    for (int j = 0; j < circles.size(); j++) {
      if (i != j) {
        if (circles.get(i).circleCollide(circles.get(j))) {
          stroke(map(dist(circles.get(i).getPosition().x, circles.get(i).getPosition().y, circles.get(j).getPosition().x, circles.get(j).getPosition().y), 0, circles.get(i).getRadius() + circles.get(j).getRadius(), MIN_GREY, MAX_GREY));
          line(circles.get(i).getPosition().x, circles.get(i).getPosition().y, circles.get(j).getPosition().x, circles.get(j).getPosition().y);
          //lines.add(new float[] {circles.get(i).getPosition().x, circles.get(i).getPosition().y, circles.get(j).getPosition().x, circles.get(j).getPosition().y});
          //if (lines.size() > 100) {
          //  lines.remove(0);
          //}
        }
      }
    }
  }

  //for (int i = 0; i < lines.size(); i++) {
  //  line(lines.get(i)[0], lines.get(i)[1], lines.get(i)[2], lines.get(i)[3]);
  //}

  for (int i = 0; i < circles.size(); i++) {
    circles.get(i).update();
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    mode++;
    mode = mode % modes.length;
    spawnMode = modes[mode];
  } else if (mouseButton == RIGHT) {
    background(255);
    circles.clear();
  }
}
