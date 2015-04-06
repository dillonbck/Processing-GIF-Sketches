
class BPM {
  ArrayList<Notification> notices;
  ArrayList<Notification> activeNotices;

  public final static int REALTIME = 0;
  public final static int FRAMERATE = 1;
  
  float bpm = 0;
  float bpmMaxTime = 0;
  float bpmMaxFrame = 0;
  //String pattern = "";
  //boolean looping = false;
  //boolean running = false;
  long timeOffsetCount = 0;
  long timeStart = 0;
  long timeCurrent = 0;
  int frameCurrent = 0;
  int frame;
  int type = REALTIME;
  
  public BPM(float bpm) {
    this.bpm = bpm;
    this.bpmMaxTime = 240000/bpm;
    this.bpmMaxFrame = this.bpmMaxTime * .06;
    notices = new ArrayList<Notification>();
    activeNotices = new ArrayList<Notification>();
    timeStart = millis();
  }

  public double getBpmBreak(int countNum) {
    return countNum * (this.bpmMaxTime/4);
  }
  
  public double getValue() {
    checkTime();
    return (double)timeOffsetCount;
  }
  
  public int getCount(int totalBeats) {
    if ( type == REALTIME )
    {
      checkTime();
      // Start at 1, not 0
      return (int)Math.floor(timeOffsetCount/(this.bpmMaxTime/totalBeats)) + 1;
    }
    else if ( type == FRAMERATE )
    {
      // Start at 1, not 0
      return (int)Math.floor(frameCurrent/Math.ceil(this.bpmMaxFrame/totalBeats)) + 1;
    }
    return 0;
  }
  
  public int getBar(int totalBars) {
    if ( type == REALTIME )
    {
      checkTime();
      // Start at 1, not 0
      return (int)(Math.floor(timeCurrent/this.bpmMaxTime) % totalBars) + 1;
    }
    else if ( type == FRAMERATE )
    {
      return (int)(Math.floor(frame/this.bpmMaxFrame) % totalBars) + 1;
    }
    return 0;
    
  }
  
  public void checkTime() {
    this.timeOffsetCount = millis() % Math.round(this.bpmMaxTime);
    this.timeCurrent = millis() - timeStart;
  }
  
  public void addNotice(Notification notice) {
    this.notices.add(notice);
  }
  
  public void addNotices(ArrayList<Notification> notices) {
    for ( int i = 0; i < notices.size(); i++ )
    {
      this.notices.add(notices.get(i));
    }
  }
  
  public ArrayList<Notification> getActiveNotices() {
    if ( type == FRAMERATE ) 
    {
      frameCurrent++;
      frameCurrent = frameCurrent % Math.round(this.bpmMaxFrame);
      frame++;
    }
    checkNotifications();
    ArrayList<Notification> notices = (ArrayList)this.activeNotices.clone();
    this.activeNotices.clear();
    return notices;
  }
  
  public void checkNotifications() {
    for ( int i = 0; i < notices.size(); i++ ) {
      int curCount = 0;
      int curBar = 0;
      
      Notification notice = notices.get(i);
      if ( notice.type == Notification.COUNT )
      {
        curCount = getCount(notice.maxVal);
        
        if ( !notice.multiple )
        {
          if ( (curCount > notice.curVal) )
          {
            /*if ( (notice.repeat)
            || ( !notice.repeat && (notice.status != Notification.HIT ) ) )
            {
              //print("\nMissed by: " + (this.timeOffsetCount));
              notice.status = Notification.HIT;
              activeNotices.add(notice);
            }*/
          }
          else if ( (curCount == notice.curVal) && (!notice.repeat) && (notice.status != Notification.HIT) 
                 || (curCount == notice.curVal) && (notice.repeat) )
          {
            //print("\nMissed by: " + (this.timeOffsetCount));
            notice.status = Notification.HIT;
            activeNotices.add(notice);
          }
          else if ( curCount < notice.curVal 
                 || curCount < notice.lastCount )
          {
            notice.status = Notification.EARLY;
          }
        }
        else if ( notice.multiple )
        {
          if ( (curCount > notice.curValLast)
            && (notice.status != Notification.HIT) )
          {
            notice.status = Notification.HIT;
            activeNotices.add(notice);
          }
          else if ( (curCount >= notice.curVal)
                 && (curCount <= notice.curValLast) )
          {
            if ( (notice.repeat)
            || ( !notice.repeat && (notice.status != Notification.HIT ) ) )
            {
              notice.status = Notification.HIT;
              activeNotices.add(notice);
            }
          }
          else if ( curCount < notice.curVal
                ||  curCount < notice.lastCount )
          {
            notice.status = Notification.EARLY;
          }
        }
        
      }
      
      // Notification per BAR
      else if ( notice.type == Notification.BAR )
      {
        
        curBar = getBar(notice.maxVal);
        
        if ( !notice.multiple )
        {
          if ( (curBar > notice.curVal)
            && (notice.status != Notification.HIT) )
          {
            /*//print("\nMissed by: " + (this.timeOffsetCount));
            notice.status = Notification.HIT;
            activeNotices.add(notice);*/
          }
          else if ( curBar == notice.curVal )
          {
            if ( (notice.repeat)
            || ( !notice.repeat && (notice.status != Notification.HIT ) ) )
            {
              //print("\nMissed by: " + (this.timeOffsetCount));
              notice.status = Notification.HIT;
              activeNotices.add(notice);
            }
          }
          else if ( curBar < notice.curVal 
                 || curBar < notice.lastCount )
          {
            notice.status = Notification.EARLY;
          }
        }
        else if ( notice.multiple )
        {
          if ( (curBar > notice.curValLast)
            && (notice.status != Notification.HIT) )
          {
            notice.status = Notification.HIT;
            activeNotices.add(notice);
          }
          else if ( (curBar >= notice.curVal) 
                 && (curBar <= notice.curValLast) )
          {
            if ( (notice.repeat)
            || ( !notice.repeat && (notice.status != Notification.HIT ) ) )
            {
              notice.status = Notification.HIT;
              activeNotices.add(notice);
            }
          }
          else if ( curBar < notice.curVal
                ||  curBar < notice.lastCount )
          {
            notice.status = Notification.EARLY;
          }
        }
        
      }
      notice.lastCount = curCount;
      notice.lastBar = curBar;
    }
  }
}
