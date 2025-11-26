import fisica.*;
PImage map;
int x=0;
int y=0;
color black=#000000;
boolean skey=false;
boolean akey=false;
boolean wkey=false;
boolean dkey=false;
boolean spacekey=false;
float vx;
float vy;
FBox player1;
FWorld world;
int gridSize;
int zoom;
void setup(){
  size(1500, 1000, P2D);
  gridSize=100;
  Fisica.init(this);
  world = new FWorld(-10000, -10000, 10000, 10000);
  map=loadImage("image.png");
  while(y<map.height){
    color c=map.get(x, y);
    if(c==black){
      FBox b= new FBox(gridSize, gridSize);
      b.setFillColor(black);
      b.setPosition(x*gridSize,y*gridSize);  
      b.setStatic(true);
      world.add(b);
    }
    x++;
    if(x==map.width){
      x=0;
      y++;
    }
  }
  player1=new FBox(gridSize, gridSize);
  player1.setFillColor(#F0A4BC);
  player1.setPosition(400*gridSize/25, 0);
  world.add(player1);
  world.setGravity(0, 981*(gridSize/25));
}
void draw(){
  background(100, 200, 30);
  pushMatrix();
  translate(-player1.getX()+width/2, -player1.getY()+height/2);
  world.step();
  world.draw();
  popMatrix();
  
  vx=0;
  if(akey) vx=-200;
  if(dkey) vx=200;
  player1.setVelocity(vx*(gridSize/25), player1.getVelocityY());
  
  ArrayList<FContact> contacts =player1.getContacts();
  if(wkey && contacts.size()>0) player1.setVelocity(player1.getVelocityX(), -500*(gridSize/25));
}
void keyPressed(){
  if(key=='S' || key=='s') skey=true;
  if(key=='A' || key=='a') akey=true;
  if(key=='W' || key=='w') wkey=true;
  if(key=='D' || key=='d') dkey=true;
  if(key==' ') spacekey=true;
}
void keyReleased(){
  if(key=='S' || key=='s') skey=false;
  if(key=='A' || key=='a') akey=false;
  if(key=='W' || key=='w') wkey=false;
  if(key=='D' || key=='d') dkey=false;
  if(key==' ') spacekey=true;
}
