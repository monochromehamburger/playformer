class FPlayer extends FBox{
  FPlayer(){
    super(gridSize, gridSize);
    setPosition(300, 0);
    setFillColor(#F404D3);
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
        setPosition(300, 0);
      }
    }
    //println(contacts.size());
    if(wkey && hasContact){
      setVelocity(getVelocityX(), -500);
    }
  }
}
