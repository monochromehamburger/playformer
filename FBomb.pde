class FBomb extends FBox{
  int timer;
  FBomb(){
    super(25, 25);
    this.setFillColor(#DCD010);
    this.setPosition(player1.getX(), player1.getY()-25);
    timer=60;
    world.add(this);
  }
  
  void act(){
    timer--;
    if(timer==0){
      explode();
      world.remove(this);
      bomb=null;
    }
  }
  void explode(){
    for(int i=0;i<boxes.size();i++){
      FBox b= boxes.get(i);
      if(dist(this.getX(), this.getY() ,b.getX(), b.getY())<200){
        b.setStatic(false);
      }
    }
  }
}
