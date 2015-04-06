
class Slide {
  private int val1;
  private int val2;
  private int type = NORM;
  
  public final static int NORM = 0;
  public final static int COLOR = 1;
  
  public Slide(int val1, int val2) {
    this.val1 = val1;
    this.val2 = val2;
  }
  
  public void setType(int type) {
    this.type = type;
  }
  
  public int getVal(float fraction) {
    
    int v1 = this.val1;
    int v2 = this.val2;
    
    if ( this.type == COLOR ) {
      float r = (red(v1)-red(v2))*fraction + red(v2);
      float g = (green(v1)-green(v2))*fraction + green(v2);
      float b = (blue(v1)-blue(v2))*fraction + blue(v2);
      
      return color(r, g, b);
    }
    else
    {
      return (int)((v2 - v1)*fraction + v2);
    }
  }
  
}

