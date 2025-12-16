class FGoomba extends FGameObject{
  int direction = L;
  int speed=50;
  int frame=0;
  FGoomba(float x, float y){
    super();
    setPosition(x, y);
    setName("goomba");
    attachImage(goomba);
    setRotatable(false);
  }
  void act(){
    collide();
    move();
  }
  void collide(){
    if(isTouching("Spike") || isTouching("goomba")){
      direction*=-1;
      setPosition(getX()+direction, getY());
    }
    if(isTouching("Player")){
      if(player1.getY()<getY()-gridSize/2){
        world.remove(this);
        enemies.remove(this);
      }
      else{
        
        setPosition(spawnX, spawnY);
        reset();
      }
    }
  }
  void move(){
    float vy=getVelocityY();
    setVelocity(speed*direction, vy);
  }
}
