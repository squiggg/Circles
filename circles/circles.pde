int CIRCLES = 4;

ArrayList<Circle> circles = new ArrayList<Circle>();
ArrayList<float[]> lines = new ArrayList<float[]>();

void setup() {
  size(900, 900);
  background(255);
}

void draw() {

  circles.add(new Circle(random(width), random(height * 49/99, height * 50/99), random(50, 75), random(10)));

  if (circles.size() > 1000)
    circles.remove(0);

  for (int i = 0; i < circles.size(); i++) {
    if (circles.get(i).position.x < 0 - circles.get(i).radius || circles.get(i).position.x > width + circles.get(i).radius || circles.get(i).position.y < 0 - circles.get(i).radius || circles.get(i).position.y > height + circles.get(i).radius) {
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
          stroke(map(dist(circles.get(i).position.x, circles.get(i).position.y, circles.get(j).position.x, circles.get(j).position.y), 50, 150, 0, 255));
          line(circles.get(i).position.x, circles.get(i).position.y, circles.get(j).position.x, circles.get(j).position.y);
          //lines.add(new float[] {circles.get(i).position.x, circles.get(i).position.y, circles.get(j).position.x, circles.get(j).position.y});
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
