ArrayList<Rectangle> rects;
long lastTime = 0;
ArrayList<Column> columns;
int mainSync = 0;
int syncMax = 500;
BPM bpm;
int colW;
int colH;
boolean currentlyMoving;

void setup() {
  colW = 15;
  colH = 15;
  size(510+colW, 510+colH);
  
  
  bpm = new BPM(140);

  columns = new ArrayList<Column>();

  for (int i = 0; i < width/colW + 1; i++) {
    Column c = new Column(colW, colH, i*colW);
    c.setShift(2, (((i%2)*1) + (((i+1)%2)*2))*2);
    columns.add(c);
  }
  
  // Line sourrounding rectangles
  stroke(200);
  
  frameRate(60);
  currentlyMoving = false;
}

void draw() {
  noLoop();
  
  thread("move");
  
  loop();
}

void move() {
  
  if (!currentlyMoving) {
    currentlyMoving = true;
    
    mainSync = (mainSync+1) % syncMax;
    
    for (int i = 0; i < columns.size (); i++) {
      //columns.get(i).loop( (int)  (((i%2*15+1) + (mainSync%50)) * (Math.sin(i))));
      columns.get(i).loop( 1 );
      columns.get(i).setShift(mainSync%2, (((i%2)*1) + (((i+1)%2)*2))*(mainSync%2));
    }
    
    currentlyMoving = false;
  }
  
}

class Column {
  ArrayList<Rectangle> rects;
  long lastTime = 0;
  int shiftX = 0;
  int shiftY = 0;
  int sync = 0;

  public Column(int w, int h, int x) {
    rects = new ArrayList<Rectangle>();

    int colNum = height/h + 1;
    for (int i = 0; i < colNum; i++) { 
      color c;
      boolean colorLock;
      if (i % 2 == 1) {
        c = #000000;
        colorLock = false;
      } else {
        c = #FFFFFF;
        colorLock = true;
      }

      rects.add(new Rectangle(x, h*(i-1), w, h, c, colorLock));
      rects.get(rects.size()-1).draw();
    }
    
  }

  public void loop(int time) {
    while (this.sync <= mainSync) {
      //if ( millis() - lastTime > time ) {

        for (int i = 0; i < rects.size (); i++) {

          Rectangle r = rects.get(i);
          r.shift(shiftX, shiftY);


          int count4 = bpm.getCount(4);
          int count8 = bpm.getCount(16);
/*          if (count8 <= 1) {
            r.setColor(153, 0, 0);
          } else if (count4 > 1 && count4 < 3) {
            r.setColor(32, 32, 32);
          } else {
            r.setColor(0, 0, 0);
          }
*/          
          r.draw();
        }
        //lastTime = millis();
      //}
      this.sync++;
    }
    this.sync = this.sync % syncMax;
  }

  public void setShift(int x, int y) {
    this.shiftX = x;
    this.shiftY = y;
  }
}

class Rectangle {
  int x, y, w, h;
  color c;
  boolean colorLock = false;

  public Rectangle(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  public Rectangle(int x, int y, int w, int h, color c, boolean colorLock) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    this.colorLock = colorLock;
  }

  public void draw() {
    fill(c);
    rect(x, y, w, h, 0);
    //fill(c);
  }

  public void shift(int x, int y) {
    this.x = this.x + x;
    this.y = this.y + y;


    if ( this.x-w > width-w ) {
      this.x = this.x - width-this.w;
    }
    if ( this.y-h > height-h ) {
      this.y = this.y - height-this.h;
    }
  }
  
  public void setColor(int r, int g, int b) {
    if ( !this.colorLock) {
      this.c = color(r, g, b);
    }
  }
}

class BPM {
  
  int bpm = 0;
  float bpmMaxTime = 0;
  String pattern = "";
  boolean looping = false;
  boolean running = false;
  long timeOffset = 0;
  
  public BPM(int bpm) {
    this.bpm = bpm;
    this.bpmMaxTime = 240000/bpm;
    //1/bpm * / 60*1000
  }
  
  public void pattern(String pattern) {
    this.pattern = pattern;
  }
  
  public void loop() {
    this.looping = true;
  }
  
  public void play() {
    running = true;
  }
  
  public double getBpmBreak(int countNum) {
    return countNum * (this.bpmMaxTime/4);
  }
  
  public double getValue() {
    checkTime();
    return (double)timeOffset;
  }
  
  public int getCount(int totalBeats) {
    checkTime();
    return Math.round(timeOffset/(this.bpmMaxTime/totalBeats));
  }
  
  public void checkTime() {
    this.timeOffset = millis() % Math.round(this.bpmMaxTime);
  }
}



