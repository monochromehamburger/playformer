class FGravityChanger extends FGameObject{
  int timer;
  boolean timerStarted;
  FGravityChanger(float x, float y){
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("bridge");
    attachImage(bridge);
    setStatic(true);
    timer=15;
  }
  
  void act(){
    if(isTouching("Player")){
      timerStarted=true;
    }
    if(timerStarted){
      timer--;
    }
    if(timer==0){
      setSensor(true);
      setStatic(false);
    }
  }
}
