class Circle {

  PVector position, velocity;
  float radius;
  boolean bounce = true;

  Circle() {
    this.position = new PVector(random(width), random(height));
    this.velocity = PVector.random2D();
    this.radius = random(5, width/2);
  }

  Circle(float x, float y) {
    this.position = new PVector(x, y);
    this.velocity = PVector.random2D();
    this.radius = random(5, width/2);
  }

  Circle(float x, float y, float radius) {
    this.position = new PVector(x, y);
    this.velocity = PVector.random2D();
    this.radius = radius;
  }

  Circle(float x, float y, float radius, float speed) {
    this.position = new PVector(x, y);
    this.velocity = PVector.random2D().mult(speed);
    this.radius = radius;
  }

  void render() {
    circle(position.x, position.y, 2 * radius);
  }

  void update() {
    this.position.add(this.velocity);
  }

  void veer(PVector point1, PVector point2) {
    PVector barrier = PVector.sub(point2, point1);
  }

  boolean circleCollide(float x2, float y2, float r2) {
    if (dist(this.position.x, this.position.y, x2, y2) <= (this.radius + r2)) {
      return true;
    } else {
      return false;
    }
  }

  boolean circleCollide(Circle circle) {
    if (dist(this.position.x, this.position.y, circle.position.x, circle.position.y) <= (this.radius + circle.radius)) {
      return true;
    } else {
      return false;
    }
  }
  
  void rotateCircle(float turn) {
    this.velocity.rotate(turn);
  }
}
