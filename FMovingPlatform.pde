class FMovingPlatform extends FGameObject{
  int timer;
  boolean timerStarted;
  int directionY=0;
  int directionX=0;
  float endX=0;
  float endY=0;
  float startX, startY;
  FMovingPlatform(float x, float y, float ex, float ey){
    super(gridSize*5, gridSize);
    setPosition(x, y);
    endX=ex;
    endY=ey;
    startX=x;
    startY=y;
    setName("movingBlock");
    setFriction(1);
    setStatic(true);
    if(endX!=x){
      directionX=1;
    }
    if(endY!=y){
      directionY=1;
    }
    attachImage(movingPlatform);
  }
  
  void act(){
    setPosition(getX()+directionX, getY()+directionY);
    if(isTouching("Player")){
      player1.setPosition(player1.getX()+directionX, player1.getY()+directionY);
    }
    if(getX()>endX){
      directionX*=-1;
      setPosition(getX()+directionX*0.5, getY());
    }
    if(getY()>endY){
      directionY*=-1;
      setPosition(getX(), getY()+directionY*0.5);
    }
    if(getX()<startX){
      directionX*=-1;
      setPosition(getX()+directionX*0.5, getY());
    }
    if(getY()<startY){
      directionY*=-1;
      setPosition(getX(), getY()+directionY*0.5);
    }
   
  }
}
