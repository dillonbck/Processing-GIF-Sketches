
class ComplexMultiLine {
  ArrayList<MultiLine> MultiLines;
  PVector loc1;
  PVector loc2;
  float blurRadius = 2;
  float alphaMultiplier;
  int baseAlpha;
  int baseLifetime;
  color c1;
  color c2;
  
  ComplexMultiLine(PVector loc1, PVector loc2, int life) {
    this.loc1 = loc1.get();
    this.loc2 = loc2.get(); 
    MultiLines = new ArrayList<MultiLine>();
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
  
  
  void addMultiLine() {
    //print("addParticle: " + blurRadius);
    MultiLine l = new MultiLine(loc1, 
                      loc2, 
                      new PVector(random(-blurRadius,blurRadius)+random(-1,1)*blurRadius, random(-blurRadius,blurRadius)+random(-1,1)*blurRadius*4), 
                      new PVector(random(-blurRadius,blurRadius)+random(-1,1)*blurRadius, random(-blurRadius,blurRadius)+random(-1,1)*blurRadius*4));
    l.setBreaks(16, 2);
    l.lifetime(this.baseLifetime);
    l.alphaMultiplier(this.alphaMultiplier);
    l.baseAlpha(this.baseAlpha);
    l.setColorSlide2(c1, c2);
    MultiLines.add(l);
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
    addMultiLine();
    //print("\n#particles: " + particles.size());
    for ( int i = MultiLines.size()-1; i >= 0; i--) {
      MultiLine l = MultiLines.get(i);
      //print("C!: " + c1);
      l.setColorSlide2(c1, c2);
      
      l.run();
      if (l.isDead()) {
        MultiLines.remove(i);
      }
    }
  }
}
  
class MultiLine {
  PVector loc1;
  PVector loc2;
  PVector vel1;
  PVector vel2;
  
  ArrayList<PVector> segments;
  
  int staticBreakInterval;
  
  //float blurRadius;
  float alphaMultiplier;
  int baseAlpha;
  int lifetime;
  Slide cSlide;
  color c;
  color c1;
  color c2;
  ArrayList<Integer> colorSlide;
  
  MultiLine (PVector loc1, PVector loc2, PVector vel1, PVector vel2)
  {
    colorSlide = new ArrayList<Integer>();
    segments = new ArrayList<PVector>();
    //setColorSlide(c1, c2);
    this.loc1 = loc1.get();
    this.loc2 = loc2.get();
    this.vel1 = vel1.get();
    this.vel2 = vel2.get();
    //this.loc2.add(this.vel2);
  }
  
  public void setBreaks(int numBreaks, int staticBreakInterval) {
    this.staticBreakInterval = staticBreakInterval;
    float len = loc1.dist(loc2);
    float xDist = (loc2.x - loc1.x)/numBreaks;
    float yDist = (loc2.y - loc1.y)/numBreaks;
    //print("xDist: " + xDist);
    //print("yDist: " + yDist);
    for ( int i = 0; i < numBreaks; i++ ) {
      
      segments.add(new PVector(loc1.x + xDist*i, loc1.y + yDist*i));
      //print("\nSegs: " + segments.get(segments.size()-1).x, segments.get(segments.size()-1).y);
    }
    
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
  
  
  void setColorSlide(color c1, color c2)
  {
    for (int i = 0; i < lifetime; i++)
    {
      colorSlide.add( (((c2-c1)/lifetime)*i) + c1 );  
    }
  }
  
  void setColorSlide2(color c1, color c2)
  {
    float r, g, b;
    //print("lifetime?: " + lifetime);
    for (int i = 0; i < lifetime; i++)
    {
      r = (((red(c2)-red(c1))/lifetime)*i) + red(c1);
      g = (((green(c2)-green(c1))/lifetime)*i) + green(c1);
      b = (((blue(c2)-blue(c1))/lifetime)*i) + blue(c1);
      
      color c = color(r, g, b);
      colorSlide.add( c );  
      //print("\ncolor3: " + c);
    }
    
    cSlide = new Slide(c1, c2);
    cSlide.setType(Slide.COLOR);
  }
  
  void run() {
    update();
    display();
  }
  
  void update() {
    for ( int i = 0; i < segments.size(); i++ ) {
      if ( i % staticBreakInterval != 0 ) {
        //segments.get(i).add(this.vel1);
        //float val = random(-4,4)+random(-1,1)*4;
        segments.get(i).add(new PVector(random(-4,4)+random(-1,1)*1, random(-4,4)+random(-1,1)*4*1));
      }
    }
    //loc2.add(this.vel2);
    c = colorSlide.get(0);
    colorSlide.remove(0);
    
    // new slide function get color
    //c = cSlide.getVal(1/2);
    
    //print("\ncolor1: " + c);
  }
  
  void display() {
    
    //print("\ncolor2: " + c);
    stroke(c, this.lifetime*this.alphaMultiplier+this.baseAlpha);
    fill(c, this.lifetime*this.alphaMultiplier+this.baseAlpha);
    
    //print("\nlifetime: " + this.lifetime + "mult: " + this.alphaMultiplier + "alpha: " + this.baseAlpha);
    //print("\nc: " + red(c) + " " + blue(c) + " " + green(c));
    
    //fill(0, 155);
    //stroke(155, 155);
    //stroke(#FFFFFF, 500);
    for ( int i = 0; i < segments.size()-1; i++ ) {
      line(segments.get(i).x, segments.get(i).y, segments.get(i+1).x, segments.get(i+1).y ); 
      //line(loc1.x, loc1.y, loc2.x, loc2.y);
    }
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

