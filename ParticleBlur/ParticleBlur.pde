ParticleGrid pg;
ComplexLine cl;
ComplexMultiLine cml;
ComplexMultiLine cml2;
ComplexMultiLine cml3;
ComplexMultiLine cml4;
ComplexMultiLine cml5;
ComplexMultiLine cml6;

ArrayList<ComplexTriangle> cts; 

BPM bpm;

ArrayList<Notification> notices;
Notification notice1;
Notification notice2;
Notification notice3;
Notification notice4;
Notification notice5;
Notification notice6;
Notification notice7;
Notification notice8;

long drawTime;

int runCount;


void setup() {
  size(600, 600);
  //size(1366, 768, P2D);
  frameRate(60);
  background(0);
  noStroke();
  
  bpm = new BPM(93.1);
  //bpm = new BPM(320);
  bpm.type = BPM.FRAMERATE;
  
  notices = new ArrayList<Notification>();
  cts = new ArrayList<ComplexTriangle>();

  pg = new ParticleGrid(2, 2, 20);
  pg.baseLifetime(10);
  pg.alphaMultiplier(3);
  pg.baseAlpha(50);
  
  notice1 = new Notification(Notification.COUNT, 1, 4, 2, 4);
  notice2 = new Notification(Notification.COUNT, 3, 4, 4, 4);
  notice3 = new Notification(Notification.BAR, 4, 8, 8, 8);
  notice4 = new Notification(Notification.COUNT, 1, 8);
  notice4.repeat = false;
  notice5 = new Notification(Notification.COUNT, 1, 8, 2, 8);
  notice5.repeat = true;
  notice6 = new Notification(Notification.COUNT, 3, 8, 4, 8);
  notice6.repeat = true;
  notice7 = new Notification(Notification.COUNT, 5, 8, 6, 8);
  notice7.repeat = true;
  notice8 = new Notification(Notification.COUNT, 7, 8, 8, 8);
  notice8.repeat = true;
  //notice6 = new Notification(Notification.COUNT, 7, 8);
  //notice6.repeat = false;
  //notice7 = new Notification(Notification.COUNT, 1, 16, 2, 16);
  
  
  //notices.add(notice1);
  //notices.add(notice2);
  //notices.add(notice3);
  //notices.add(notice4);
  notices.add(notice5);
  notices.add(notice6);
  notices.add(notice7);
  notices.add(notice8);
  
  bpm.addNotices(notices);
  
  
  cl = new ComplexLine(new PVector(width/2, height/2),
                  new PVector(width/2, height/2),
                  20);
  
  cml = new ComplexMultiLine(new PVector(0, 0),
                  new PVector(width, height),
                  20);
                  
  cml2 = new ComplexMultiLine(new PVector(0, height/2),
                  new PVector(width/2, height),
                  20);
                  
  cml3 = new ComplexMultiLine(new PVector(width/2, 0),
                  new PVector(width, height/2),
                  20);
             
                  
  cml4 = new ComplexMultiLine(new PVector(0, height),
                  new PVector(width, 0),
                  20);
                  
  cml5 = new ComplexMultiLine(new PVector(0, height/2),
                  new PVector(width/2, 0),
                  20);
  
  cml6 = new ComplexMultiLine(new PVector(width/2, height),
                  new PVector(width, height/2),
                  20);
                  
  runCount = 0;
} 

void draw () {
  
  
  
  ArrayList<Notification> notices = bpm.getActiveNotices();
  drawTime = millis();
  
  
  if ( notices.contains(notice4) )
  {
    ComplexTriangle ct = new ComplexTriangle(40, new PVector(width/2, height/2));
    ct.growSpeed = 1;
    ct.rotSpeed = .001;
    ct.colorSlide(#FFFFFF, #FF0000);
    //cts.add(ct);
    
  }
  else if ( notices.contains(notice5) || notices.contains(notice7) )
  {
    ComplexTriangle ct = new ComplexTriangle(3, new PVector(width/2, height/2));
    ct.setColor(color(0, 0, 0)); 
    ct.colorSlide(#0000FF, #FF0000);
    ct.baseAlpha = 150;
    ct.growSpeed = 2;
    cts.add(ct);
    
    ct = new ComplexTriangle(0, new PVector(width/2, height/2));
    ct.setColor(color(0, 0, 0)); 
    ct.colorSlide(#FF0000, #FF0000);
    ct.baseAlpha = 150;
    ct.growSpeed = 2;
    cts.add(ct);
  }
  else if ( notices.contains(notice6) || notices.contains(notice8) )
  {
    ComplexTriangle ct = new ComplexTriangle(5, new PVector(width/2, height/2));
    ct.setColor(color(0, 0, 0)); 
    ct.colorSlide(#FFFFFF, #FFFFFF);
    ct.baseAlpha = 150;
    ct.growSpeed = 2;
    cts.add(ct);
    
    ct = new ComplexTriangle(0, new PVector(width/2, height/2));
    ct.setColor(color(0, 0, 0)); 
    ct.colorSlide(#000000, #000000);
    ct.baseAlpha = 150;
    ct.growSpeed = 2;
    cts.add(ct);
    
    /*ComplexTriangle ct = new ComplexTriangle(5, new PVector(width/2, height/2));
    //ct.colorSlide(#FF0000, #00F0FF);
    ct.colorSlide(#FFFFFF, #FFFFFF);
    ct.baseAlpha = 150;
    //ct.baseAlpha = 5000;
    ct.growSpeed = 2;
    ct.rotSpeed = -.98;
    //cts.add(ct);
    
    ct = new ComplexTriangle(0, new PVector(width/2, height/2));
    //ct.colorSlide(#FF0000, #00F0FF);
    ct.colorSlide(#000000, #000000);
    //ct.baseAlpha = 150;
    ct.baseAlpha = 5000;
    ct.growSpeed = 2;
    ct.rotSpeed = -.98;
    //cts.add(ct);*/
  }
  
  if ( notices.contains(notice7) )
  {
    for ( int i = 0; i < cts.size(); i++ ) {
      ComplexTriangle ct = cts.get(i);
      //ct.baseAlpha += 2;
    }
  }
  /*
  if ( notices.contains(notice3) )
  {
    if ( notices.contains(notice1) )
    {
      pg.baseLifetime(40);
      pg.colorParticles(#000000, #FFFFFF);
      pg.blurRadius(3);
      pg.alphaMultiplier(3);
      
      cl.baseLifetime(40);
      cl.setColors(#000000, #FFFFFF);
      cl.baseAlpha(50);
      cl.blurRadius(32);
      cl.alphaMultiplier(3);
      
    }
    else if ( notices.contains(notice2) )
    {
      pg.baseLifetime(40);
      pg.colorParticles(#000000, #FFFFFF);
      pg.blurRadius(16);
      pg.alphaMultiplier(3);
      
      cl.baseLifetime(40);
      cl.setColors(#000000, #FFFFFF);
      cl.blurRadius(64);
      cl.alphaMultiplier(3);
    }
    else 
    {
      pg.baseLifetime(40);
      pg.colorParticles(#000000, #FFFFFF);
      pg.blurRadius(8);
      pg.alphaMultiplier(3);
      
      cl.baseLifetime(40);
      cl.setColors(#000000, #FFFFFF);
      cl.blurRadius(32);
      cl.alphaMultiplier(3);
    }
  }
  else
  { 
    if ( notices.contains(notice1) )
    {
      pg.baseLifetime(30);
      pg.colorParticles(#0000FF, #0000FF);
      pg.blurRadius(1.5);
      
      cl.setColors(#0000FF, #0000FF);
    }
    else if ( notices.contains(notice2) )
    {
      pg.baseLifetime(30);
      pg.colorParticles(#FFFFFF, #FF0000);
      pg.blurRadius(1.5);
      
      cl.setColors(#FFFFFF, #FF0000);
    }
    else 
    {
      pg.baseLifetime(30);
      pg.colorParticles(#FFFFFF, #FF0000);
      pg.blurRadius(1.5);
      
      cl.setColors(#FFFFFF, #FF0000);
    }
  }*/
  
  runParticles();
  
  printBpmCount(8);
  printBpmBar(51);
  
  fill(255, 255, 255);
  textSize(16);
  text(millis() - drawTime, 40, height-10);
  
  fill(255, 255, 255);
  textSize(16);
  text(frameRate, 100, height-10);
}
  
void runParticles() {
  background(0);
  //baseLifetime = (runCount % 100) / 5;
  
  pg.runParticles();
  
  cml.baseLifetime(8);
  cml.baseLifetime(20);
    cml.alphaMultiplier(5);
    cml.baseAlpha(5);
    cml.blurRadius(2);
    cml.setColors(#000000, #FFFFFF);
  //cml.run();
  
  cml2.baseLifetime(8);
  cml2.baseLifetime(20);
    cml2.alphaMultiplier(1);
    cml2.baseAlpha(5);
    cml2.blurRadius(2);
    cml2.setColors(#000000, #FFFFFF);
  //cml2.run();
  
  cml3.baseLifetime(8);
  cml3.baseLifetime(20);
    cml3.alphaMultiplier(1);
    cml3.baseAlpha(5);
    cml3.blurRadius(2);
    cml3.setColors(#000000, #FFFFFF);
  //cml3.run();
  
  cml4.baseLifetime(8);
  cml4.baseLifetime(20);
    cml4.alphaMultiplier(1);
    cml4.baseAlpha(5);
    cml4.blurRadius(2);
    cml4.setColors(#000000, #FFFFFF);
  //cml4.run();
  
  cml5.baseLifetime(8);
  cml5.baseLifetime(20);
    cml5.alphaMultiplier(1);
    cml5.baseAlpha(5);
    cml5.blurRadius(2);
    cml5.setColors(#000000, #FFFFFF);
  //cml5.run();
  
  cml6.baseLifetime(8);
  cml6.baseLifetime(20);
    cml6.alphaMultiplier(1);
    cml6.baseAlpha(5);
    cml6.blurRadius(2);
    cml6.setColors(#000000, #FFFFFF);
  //cml6.run();
  
  /*cl.baseLifetime(8);
  cl.baseLifetime(50);
    cl.alphaMultiplier(3);
    cl.baseAlpha(50);
    cl.blurRadius(32);
    cl.setColors(#0000FF, #FFFF00);
    */
    
  cl.run();
  
  print("\nsize " + cts.size());
  for ( int i = 0; i < cts.size(); i++ ) {
    ComplexTriangle ct = cts.get(i);
    if ( ct.isDead ) {
      cts.remove(ct);
    }
    else {
      ct.run();
    }
    
    
    
  }
  
  runCount++;
  //saveFrame("triangle-########.jpg");
}


  
void printBpmCount(int totalBeats) {
  printBpmCount(totalBeats, 5, height-10);
}

void printBpmCount(int totalBeats, int x, int y) {
  fill(255, 255, 255);
  textSize(16);
  text(bpm.getCount(totalBeats), x, y);
}

void printBpmBar(int totalBars) {
  printBpmBar(totalBars, 20, height-10);
}

void printBpmBar(int totalBars, int x, int y) {
  fill(255, 255, 255);
  textSize(16);
  text(bpm.getBar(totalBars), x, y);
}


class ParticleGrid {
  ArrayList<ComplexParticle> cParticles = new ArrayList<ComplexParticle>();
  
  int rowCount;
  int colCount;
  float blurRadius;
  float alphaMultiplier;
  int baseAlpha;
  int baseLifetime;
  
  
  public ParticleGrid(int rowCount, int colCount, int baseLifetime)
  {
    this.rowCount = rowCount;
    this.colCount = colCount;
    
    for ( int i = 0; i < rowCount; i++ )
    {
      for ( int k = 0; k < colCount; k++ )
      {
        int w = ((width / (rowCount+1)) * i) + (width/(rowCount+1));
        int h = ((height / (colCount+1)) * k) + (height/(colCount+1));
        cParticles.add(new ComplexParticle(new PVector(w, h), baseLifetime));
      }
    }
  }
  
  public ParticleGrid(int rowCount, int colCount)
  {
    this(rowCount, colCount, 20);
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
  
  public void baseLifetime(int baseLifetime) {
    this.baseLifetime = baseLifetime;
  }
  
  public int baseLifetime() {
    return this.baseLifetime;
  }
  
  public void runParticles() {
    for ( int i = 0; i < cParticles.size(); i++ )
    {
      ComplexParticle cp = cParticles.get(i);
      cp.baseLifetime(baseLifetime);
      cp.blurRadius(this.blurRadius);
      cp.alphaMultiplier(this.alphaMultiplier);
      cp.baseAlpha(this.baseAlpha);
      cp.run();
    }
  }
  
  public void colorParticles(color c1, color c2) {
    
    //print("\nsize: " + cParticles.size());
    for ( int i = 0; i < cParticles.size(); i++ )
    {
      ComplexParticle cp = cParticles.get(i);
      cp.baseLifetime(this.baseLifetime);
      cp.alphaMultiplier(this.alphaMultiplier);
      cp.baseAlpha(this.baseAlpha);
      cp.setColors(c1, c2);
      //print("setcolor");
    }
  }
}




