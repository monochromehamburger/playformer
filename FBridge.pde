class FBridge extends FGameObject{
  int timer;
  boolean timerStarted;
  FBridge(float x, float y){
    super();
    setPosition(x, y);
    setName("bridge");
    attachImage(bridge);
    setStatic(true);
    timer=15;
  }
  
  void act(){
    if(isTouching("Player")){
      timerStarted=true;
      //setSensor(true);
    }
    if(timerStarted){
      timer--;
    }
    if(timer==0){
      setStatic(false);
    }
  }
}
