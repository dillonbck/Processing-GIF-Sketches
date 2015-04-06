
class ComplexTriangle {
  
  float sideLen;
  PVector center;
  PVector p1;
  PVector p2;
  PVector p3;
  float alphaMultiplier = 1;
  int baseAlpha = 255;
  float growSpeed = 5;
  float rotSpeed = .97;    // Number of rotations
  color c;
  Slide colorSlide;
  
  boolean isDead = false;
  
  ComplexTriangle(float sideLen, PVector center) {
    this.sideLen = sideLen;
    this.center = center;
    
    p1 = new PVector(0, sqrt(3)/6);
    p2 = new PVector(-.5, -sqrt(3)/6);
    p3 = new PVector(.5, -sqrt(3)/6);
   
    growPoints(sideLen);
    colorSlide(0, 0);
  }
  
  void colorSlide(color c1, color c2)
  {
    colorSlide = new Slide(c1, c2);
    colorSlide.setType(Slide.COLOR);
  }
  
  void setColor(color c) {
    this.c = c;
  }
  
  PVector rotatePoint(float x, float y, float rotation) {
    PVector rotatedPoint = new PVector();
    float angle  = radians(rotation);
    rotatedPoint.x = cos(angle) * x - sin(angle) * y;
    rotatedPoint.y = cos(angle) * y + sin(angle) * x;
    return rotatedPoint;
  }
  
  void run() {
    //background(255);
    update();
    display();
    checkDead();
  }
  
  void checkDead() {
    if ( p1.mag() > width ) {
      this.isDead = true;
    }
  }
  
  void growPoints(float speed) {
    
    PVector norm;
    
    norm = p1.get();
    norm.normalize();
    norm.normalize();
    norm.mult(speed);
    //print("\n1mag: " + norm.mag());
    this.p1.add(norm);
    
     norm = p2.get();
    norm.normalize();
    norm.normalize();
    norm.mult(speed);
    //print("\nmag: " + norm.mag());
    this.p2.add(norm);
    
    norm = p3.get();
    norm.normalize();
    norm.normalize();
    norm.mult(speed);
    //print("\nmag: " + norm.mag());
    this.p3.add(norm);
    //print("\nwmag: " + p3.mag());
  }
  
  void update() {
    this.sideLen += growSpeed;
    
    c = colorSlide.getVal(.5);
    
    this.p1.rotate(TWO_PI*rotSpeed);
    this.p2.rotate(TWO_PI*rotSpeed);
    this.p3.rotate(TWO_PI*rotSpeed);
    
    growPoints(growSpeed);
  }
  
  void display() {
   
    stroke(c, this.alphaMultiplier*this.baseAlpha);
    fill(c, this.alphaMultiplier*this.baseAlpha);
    
    triangle(center.x + p1.x, 
             center.y + p1.y, 
             center.x + p2.x, 
             center.y + p2.y, 
             center.x + p3.x, 
             center.y + p3.y);
  }
  
}
