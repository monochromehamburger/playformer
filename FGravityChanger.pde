class FWater extends FGameObject{
  int timer;
  boolean timerStarted;
  int frame;
  int frameTimer;
  FWater(float x, float y){
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("water");
    setStatic(true);
    setSensor(true);
    frame=0;
    frameTimer=0;
  }
  
  void act(){
    if(frameTimer>=10){
      if(frame==0) frame=1;
      else frame=0;
      frameTimer=0;
    }
    frameTimer++;
    attachImage(water[frame]);
    if(isTouching("Player")){
      player1.adjustVelocity(0, -10);
      player1.setVelocity(player1.getVelocityX()/1.03, max(player1.getVelocityY(), -200));
    }
  }
}
