int CIRCLES = 4;

ArrayList<Circle> circles = new ArrayList<Circle>();
ArrayList<float[]> lines = new ArrayList<float[]>();

float t = 0;
String[] modes = new String[] {"center", "x-axis", "y-axis", "circle", "mouse", "random"};
int mode = 0;
String spawnMode = modes[mode];


void setup() {
  size(900, 900);
  background(255);
  strokeWeight(.5);
}

void draw() {

  if (spawnMode == "center") {
    float x  =  width/2;
    float y  =  height/2;
    circles.add(new Circle(x, y, random(50, 75), random(10)));
  } else if (spawnMode == "x-axis") {
    float x  =  random(width);
    float y  =  height/2;
    circles.add(new Circle(x, y, random(50, 75), random(10)));
  } else if (spawnMode == "y-axis") {
    float x  =  width/2;
    float y  =  random(height);
    circles.add(new Circle(x, y, random(50, 75), random(10)));
  } else if (spawnMode == "circle") {
    float x  =  (width/2) + 300 * cos(t);
    float y  =  (height/2) + 300 * sin(t);
    t+= TWO_PI / 180;
    circles.add(new Circle(x, y, random(50, 75), random(10)));
  } else if (spawnMode == "mouse") {
    float x = mouseX;
    float y = mouseY;
    circles.add(new Circle(x, y, random(50, 75), random(10)));
  } else if (spawnMode == "random") {
    float x = random(width);
    float y = random(height);
    circles.add(new Circle(x, y, random(50, 75), random(10)));
  }

  if (circles.size() > 1000)
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
          stroke(map(dist(circles.get(i).getPosition().x, circles.get(i).getPosition().y, circles.get(j).getPosition().x, circles.get(j).getPosition().y), 0, 150, 0, 255));
          line(circles.get(i).getPosition().x, circles.get(i).getPosition().y, circles.get(j).position.x, circles.get(j).position.y);
          //lines.add(new float[] {circles.get(i).getPosition().x, circles.get(i).getPosition().y, circles.get(j).position.x, circles.get(j).position.y});
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
    mode = mode % 6;
    spawnMode = modes[mode];
  } else if (mouseButton == RIGHT) {
    background(255);
    circles.clear();
  }
}
