class FThwomp extends FGameObject{
  int direction = 0;
  int speed=50;
  int frame=0;
  float spawnPosition=0;
  float endPosition=0;
  float spawnX=0;
  boolean goingDown;
  int thwompMode=0;
  final int WAITING=0;
  final int FALLING=1;
  final int GOINGUP=2;
  int timer=0;
  FThwomp(float x, float y, float e){
    super(gridSize*2, gridSize*2);
    setPosition(x, y);
    spawnPosition=y;
    spawnX=x;
    setFillColor(#1F1F1F);
    setRotatable(false);
    endPosition=e;
    goingDown=false;
    setStatic(true);
    attachImage(thwomp);
    timer=0;
    setDensity(1);
  }
  void act(){
    collide();
    move();
    checkMode();
  }
  void collide(){
    if(isTouching("Player")){
      if(player1.getY()>getY()+gridSize){
        setPosition(spawnX, spawnY);
        reset();
      }
    }
  }
  void checkMode(){
    if((isTouching("wall") || isTouching("ice") || isTouching("bridge") || isTouching("goomba") || isTouching("spike")) && thwompMode==FALLING){
      if(timer<120){
        timer++;
        setVelocity(0,0);
      }
      else{
        thwompMode=GOINGUP;
      }
    }
    if(getY()<=spawnPosition+1 && thwompMode==GOINGUP){
      thwompMode=WAITING;
      timer=0;
      setStatic(true);
    }
    if(getX()-gridSize<player1.getX() && getX()+gridSize>player1.getX() && player1.getY()>getY()+gridSize && player1.getY()<endPosition && thwompMode==WAITING){
      thwompMode=FALLING;
      setStatic(false);
    }
  }
  void move(){
    setPosition(spawnX, getY());
    if(thwompMode==WAITING){
      setVelocity(0,0);
      attachImage(thwomp);
    }
    else if(thwompMode==FALLING){
      attachImage(thwompEvil);
      adjustVelocity(0, -10);
    }
    else{
      setVelocity(0, -50);
      attachImage(thwomp);
    }
    //if(isTouching("spike"))println(thwompMode+" mode "+spawnPosition+" "+getY());
  }
}
