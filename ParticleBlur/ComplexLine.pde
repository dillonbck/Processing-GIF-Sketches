
class ComplexLine {
  ArrayList<Line> lines;
  PVector loc1;
  PVector loc2;
  float blurRadius = 2;
  float alphaMultiplier;
  int baseAlpha;
  int baseLifetime;
  color c1;
  color c2;
  
  ComplexLine(PVector loc1, PVector loc2, int life) {
    this.loc1 = loc1.get();
    this.loc2 = loc2.get(); 
    lines = new ArrayList<Line>();
    baseLifetime = life;
  }
  
  
  public void blurRadius(float blurRadius) {
    this.blurRadius = blurRadius;
  } 
  
  public float blurRadius() {
    return this.blurRadius;
  } 
  
  public void alphaMultiplier(float alphaMultiplier) {
    this.alphaMultiplier = alphaMultiplier;
  }
  
  public float alphaMultiplier() {
    return this.alphaMultiplier;
  }
  
  public void baseAlpha(int baseAlpha) {
    this.baseAlpha = baseAlpha;
  }
  
  public int baseAlpha() {
    return this.baseAlpha;
  }
  
  
  void addLine() {
    //print("addParticle: " + blurRadius);
    Line l = new Line(loc1, 
                      loc2, 
                      new PVector(random(-blurRadius,blurRadius), random(-blurRadius,blurRadius)), 
                      new PVector(random(-blurRadius,blurRadius), random(-blurRadius,blurRadius)));
    l.baseLifetime(this.baseLifetime);
    l.lifetime(this.baseLifetime);
    l.alphaMultiplier(this.alphaMultiplier);
    l.baseAlpha(this.baseAlpha);
    l.colorSlide(c1, c2);
    lines.add(l);
  }
  
  void baseLifetime(int life) {
    baseLifetime = life;
  }
  
  int baseLifetime() {
    return this.baseLifetime ;
  }
  
  void setColors(color c1, color c2) {
    //print("\ncolor1: " + c1);
    //print("\ncolor1: " + c2);
    this.c1 = c1;
    this.c2 = c2;
  }
  
  void run() {
    addLine();
    //print("\n#particles: " + particles.size());
    for ( int i = lines.size()-1; i >= 0; i--) {
      Line l = lines.get(i);
      l.colorSlide(c1, c2);
      
      l.run();
      if (l.isDead()) {
        lines.remove(i);
      }
    }
  }
}
  
class Line {
  PVector loc1;
  PVector loc2;
  PVector vel1;
  PVector vel2;
  
  //float blurRadius;
  float alphaMultiplier;
  int baseAlpha;
  int baseLifetime;
  int lifetime;
  Slide colorSlide;
  color c;
  color c1;
  color c2;
  
  Line (PVector loc1, PVector loc2, PVector vel1, PVector vel2)
  {
    //setColorSlide(c1, c2);
    this.loc1 = loc1.get();
    this.loc2 = loc2.get();
    this.vel1 = vel1.get();
    this.vel2 = vel2.get();
    this.loc2.add(this.vel2);
  }
  
  
  
  public void alphaMultiplier(float alphaMultiplier) {
    this.alphaMultiplier = alphaMultiplier;
  }
  
  public float alphaMultiplier() {
    return this.alphaMultiplier;
  }
  
  public void baseAlpha(int baseAlpha) {
    this.baseAlpha = baseAlpha;
  }
  
  public int baseAlpha() {
    return this.baseAlpha;
  }
  
  public void lifetime(int lifetime) {
    this.lifetime = lifetime;
  }
  
  public int lifetime() {
    return this.lifetime;
  }
  
  public void baseLifetime(int baseLifetime) {
    this.baseLifetime = baseLifetime;
  }
  
  public int baseLifetime() {
    return this.baseLifetime;
  }
  
  
  void colorSlide(color c1, color c2)
  {
    colorSlide = new Slide(c1, c2);
    colorSlide.setType(Slide.COLOR);
  }
  
  void run() {
    update();
    display();
  }
  
  void update() {
    // new slide function get color
    c = colorSlide.getVal(lifetime/baseLifetime);
  }
  
  void display() {
    stroke(c, this.lifetime*this.alphaMultiplier+this.baseAlpha);
    fill(c, this.lifetime*this.alphaMultiplier+this.baseAlpha);

    line(loc1.x, loc1.y, loc2.x, loc2.y);
    lifetime -= 1;
  }
  
  boolean isDead() {
    if (lifetime < 0){
      return true;
    } else {
      return false;
    }
    
  }
  
}

