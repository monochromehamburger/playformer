class FPlayer extends FBox{
  int frame;
  FPlayer(){
    super(gridSize, gridSize);
    setPosition(89*gridSize, 19*gridSize-60);
    setName("Player");
    setRotatable(false);
    setFillColor(#F404D3);
    frame=0;
  }
  void act(){
    float vy=getVelocityY();
    if(akey) setVelocity(-200, vy);
    if(dkey) setVelocity(200, vy);
    ArrayList<FContact> contacts=getContacts();
    boolean hasContact=false;
    for(int i=0;i<contacts.size();i++){
      if(contacts.get(i).getY()>getY()+gridSize/2){
        //println(contacts.get(i).getY()+" "+getY());
        hasContact=true;
      }
      if(contacts.get(i).getBody1().getFillColor()==#123456){
        setPosition(spawnX, spawnY);
        reset();
      }
      String fc=contacts.get(i).getBody2().getName();
      String fc1=contacts.get(i).getBody1().getName();
      if(fc.equals("hammer")){
        setPosition(spawnX, spawnY);
        reset();
      }
      if(fc.equals("ending") || fc1.equals("ending")){
        level++;
        if(level==2){
          spawnX=5*gridSize;
          spawnY=96*gridSize-60;
        }
        println(level);
        reset();
      }
      if(contacts.get(i).contains("checkpoint")){
        spawnY=contacts.get(i).getY()-50;
        spawnX=contacts.get(i).getX();
      }
    }
    //println(contacts.size());
    if(wkey && hasContact){
      setVelocity(getVelocityX(), -500);
    }
   
    animate();
  }
  void animate(){
    frame++;
    if(abs(getVelocityY())>0.2){
      attachImage(jump);
    }
    else if(abs(getVelocityX())>0.1){
      if((frame/10)%2==0){
        attachImage(walk1);
      }
      else if((frame/10)%2==1){ 
        attachImage(walk2);
      }
    }
    else{
      attachImage(walk2);
    }
  }
}
