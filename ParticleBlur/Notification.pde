
class Notification {
  int type;
  int curVal;
  int maxVal;
  int curValLast;
  int maxValLast;
  int status = 0;
  boolean repeat = true;
  int lastCount = 0;
  int lastBar = 0;
  boolean multiple;
  
  public static final int COUNT = 0;
  public static final int BAR = 1; 
  
  public static final int EARLY = -1;
  public static final int MISSED = 0;
  public static final int HIT = 1;
  
  
  public Notification(int type, int curVal, int maxVal) {
    
    this(type, curVal, maxVal, curVal, maxVal);
  }
  
  public Notification(int type, int curVal, int maxVal, int curValLast, int maxValLast) {
    this.type = type;
    this.curVal = curVal;
    this.curValLast = curValLast;
    this.maxVal = maxVal;
    this.maxValLast = maxValLast;
    if ( (curVal == curValLast) && (maxVal == maxValLast) )
    {
      multiple = false;
    }
    else
    {
      multiple = true;
    }
  }
  
  @ Override
  boolean equals(Object notification)
  {
    if ( !(notification instanceof Notification) )
    {
      return false;
    }
    
    return this.type   == ((Notification) notification).type
        && this.curVal == ((Notification) notification).curVal
        && this.maxVal== ((Notification) notification).maxVal
        && this.curValLast == ((Notification) notification).curValLast
        && this.maxValLast == ((Notification) notification).maxValLast;
  }
  
}
