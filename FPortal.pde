class FPortal extends FGameObject{
  int timer;
  boolean timerStarted;
  FPortal connectedPortal;
  FPortal(float x, float y, FPortal c){
    super(gridSize, gridSize);
    setPosition(x, y);
    connectedPortal=c;
    setName("portal");
    //attachImage(portal);
    
    setStatic(true);
    setSensor(true);
   }
  FPortal(float x, float y){
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("portal");
    //attachImage(portal);
    setStatic(true);
    setSensor(true);
    //println("DASAWEIORJAKLDFJKLASDFK;ASDJFKLAJDF");
  }
  void attachPortal(FPortal c){
    connectedPortal=c;
  }
  void act(){
    if(isTouching("Player") && portalCooldown<0){
      player1.setPosition(connectedPortal.getX(), connectedPortal.getY());
      portalCooldown=60;
    }
  }
}
