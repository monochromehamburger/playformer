class FGameObject extends FBox{
  final int L=-1;
  final int R=1;
  FGameObject(){
    super(gridSize, gridSize);
  }
  boolean isTouching(String n){
    ArrayList<FContact> contacts=getContacts();
    for(int i=0;i<contacts.size();i++){
      String fc=contacts.get(i).getBody2().getName();
      //println(fc);
      if(fc.equals(n)){
        return true;
      }
    }
    return false;
  }
  void act(){
    
  }
}
