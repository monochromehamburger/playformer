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
FPlayer player1;
FWorld world;
int zoom;
FBomb bomb=null;
ArrayList<FBox> boxes;
int gridSize;  
PImage stone;
PImage ice;
PImage trampoline;
PImage spike;
void setup(){
  size(1500, 1000, P2D);
  gridSize=25;
  Fisica.init(this);
  world = new FWorld(-10000, -10000, 10000, 10000);
  world.setGravity(0, 900);
  map=loadImage("verytim.png");
  stone=loadImage("brick.png");
  stone.resize(gridSize, gridSize);
  ice=loadImage("blueBlock.png");
  ice.resize(gridSize, gridSize);
  trampoline=loadImage("beautifultrampoline.png");
  trampoline.resize(gridSize, gridSize);
    spike=loadImage("spike.png");
  spike.resize(gridSize, gridSize);
  boxes=new ArrayList<>();
  
  for(int y=0;y<map.height;y++){
    for(int x=0;x<map.width;x++){
      color c=map.get(x, y);
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      if(c==black){
        b.setStatic(true);
        b.attachImage(stone);
        b.setFriction(4);
        world.add(b);
      }
      if(c==#00A2E8){
        b.setStatic(true);
        b.attachImage(ice);
        b.setFriction(0);
        world.add(b);
      }
      if(c==#22B14C){
        b.setStatic(true);
        b.attachImage(trampoline);
        b.setRestitution(1);
        world.add(b);
      }
      if(c==#ED1C24){
        b.setStatic(true);
        b.attachImage(spike);
        b.setFillColor(#123456);
        world.add(b);
      }
    }
  }
  loadPlayer();
  zoom=2;
}
void draw(){
  background(100, 200, 30);
  drawWorld();
  player1.act();
  //  player1.setVelocity(vx*(gridSize/25), player1.getVelocityY());
  
}
void drawWorld(){
  pushMatrix();
  translate(-player1.getX()*zoom+width/2, -player1.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}
void loadPlayer(){
  player1=new FPlayer();
  world.add(player1);
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
  if(key==' ') spacekey=false;
}
