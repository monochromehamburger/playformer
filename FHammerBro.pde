class FHammerBro extends FGameObject{
  int direction = L;
  int speed=50;
  int frame=0;
  int timer=0;
  boolean dead=false;
  FHammerBro(float x, float y){
    super(gridSize*2, gridSize*2);
    setPosition(x, y);
    setName("hammerBro");
    attachImage(hammerBro);
    setRotatable(false);
    
  }
  void act(){
    println("what");
    collide();
    move();
    timer++;
  }
  void collide(){
    if(timer>=200 && dead==false){
      timer=0;
      FGameObject h = new FGameObject(gridSize, gridSize);
      h.setPosition(getX()+10*direction, getY()-10);
      h.attachImage(hammer);
      h.setName("hammer");
      h.setSensor(true);
      h.setVelocity(200*direction, -400);
      h.setRotatable(true);
      h.setAngularVelocity(50);
      world.add(h);
      direction*=-1;
     
    }
    if(isTouching("Player")){
      if(player1.getY()<getY()-gridSize/2){
        dead=true;
        world.remove(this);
        enemies.remove(this);
        player1.setVelocity(player1.getVelocityX(), -250);
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
    if(direction==-1){
      attachImage(hammerBro);
    }
    else{
      attachImage(hammerBroReversed);
    }
  }
}
