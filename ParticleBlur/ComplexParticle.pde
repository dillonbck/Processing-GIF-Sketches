
class ComplexParticle {
  ArrayList<Particle> particles;
  PVector origin;
  float blurRadius;
  float alphaMultiplier;
  int baseAlpha;
  int baseLifetime;
  color c1;
  color c2;
  
  ComplexParticle(PVector loc, int life) {
    origin = loc.get();
    particles = new ArrayList<Particle>();
    baseLifetime = life;
  }
  
  
  public void blurRadius(float blurRadius) {this.blurRadius = blurRadius;} 
  public float blurRadius() {return this.blurRadius;} 
  
  public void alphaMultiplier(float alphaMultiplier) {this.alphaMultiplier = alphaMultiplier;}
  public float alphaMultiplier() {return this.alphaMultiplier;}
  
  public void baseAlpha(int baseAlpha) {this.baseAlpha = baseAlpha;}
  public int baseAlpha() {return this.baseAlpha;}
  
  void baseLifetime(int life) {baseLifetime = life;}
  int baseLifetime() {return this.baseLifetime;}
  
  
  void addParticle() {
    //print("addParticle: " + blurRadius);
    Particle p = new Particle(origin, new PVector(random(-blurRadius,blurRadius), random(-blurRadius,blurRadius)));
    p.lifetime(this.baseLifetime);
    p.alphaMultiplier(this.alphaMultiplier);
    p.baseAlpha(this.baseAlpha);
    p.colorSlide(c1, c2);
    particles.add(p);
  }
  
  
  
  void setColors(color c1, color c2) {
    this.c1 = c1;
    this.c2 = c2;
  }
  
  void run() {
    addParticle();
    //print("\n#particles: " + particles.size());
    for ( int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.colorSlide(c1, c2);
      p.colorSlide(c1, c2);
      
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
  
class Particle {
  PVector loc;
  PVector vel;
  float blurRadius;
  float alphaMultiplier;
  int baseAlpha;
  int baseLifetime;
  int lifetime;
  Slide colorSlide;
  color c;
  color c1;
  color c2;
  
  
  Particle (PVector l, PVector v)
  {
    this.loc = l.get();
    this.vel = v.get();
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
  
  public void lifetime(int lifetime) {
    this.baseLifetime = lifetime;
    this.lifetime = lifetime;
  }
  
  public int lifetime() {
    return this.lifetime;
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
    loc.add(this.vel);
    c = colorSlide.getVal(lifetime/baseLifetime);
  }
  
  void display() {
    stroke(c, this.lifetime*this.alphaMultiplier+this.baseAlpha);
    fill(c, this.lifetime*this.alphaMultiplier+this.baseAlpha);

    ellipse(loc.x, loc.y, 8, 8);
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
