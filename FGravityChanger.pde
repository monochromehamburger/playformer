class FWater extends FGameObject{
  int timer;
  boolean timerStarted;
  FWater(float x, float y){
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("water");
    attachImage(water);
    setStatic(true);
    setSensor(true);
  }
  
  void act(){
    if(isTouching("Player")){
      player1.adjustVelocity(0, -10);
      player1.setVelocity(player1.getVelocityX(), max(player1.getVelocityY(), -50));
    }
  }
}
