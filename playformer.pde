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
PImage stone, ice, trampoline, spike, bridge, treeIntersect, treeMiddle, treeEndWest, treeEndEast, treeTrunk, walk1, walk2, jump, goomba, thwomp, thwompEvil, hammerBro, hammer, hammerBroReversed, portal;
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;
ArrayList<FPortal> openPortals=new ArrayList<>();
color green=#B5E61D;
color brown=#880015;
float spawnX, spawnY;
PImage[] water;
int level=1;
int portalCooldown=0;
void setup(){
  size(1500, 1000, P2D);
  spawnX=200;
  spawnY=0;
  gridSize=25;
  Fisica.init(this);
  world = new FWorld(-20000, -20000, 20000, 20000);
  world.setGravity(0, 900);
  stone=loadImage("brick.png");
  stone.resize(gridSize, gridSize);
  ice=loadImage("blueBlock.png");
  ice.resize(gridSize, gridSize);
  trampoline=loadImage("beautifultrampoline.png");
  trampoline.resize(gridSize, gridSize);
  spike=loadImage("spike.png");
  spike.resize(gridSize, gridSize);
  bridge=loadImage("bridge_e.png");
  bridge.resize(gridSize, gridSize);
  treeIntersect=loadImage("tree_intersect.png");
  treeIntersect.resize(gridSize, gridSize);
  treeMiddle=loadImage("treetop_center.png");
  treeMiddle.resize(gridSize, gridSize);
  treeEndEast=loadImage("treetop_e.png");
  treeEndEast.resize(gridSize, gridSize);
  treeEndWest=loadImage("treetop_w.png");
  treeEndWest.resize(gridSize, gridSize);
  treeTrunk=loadImage("tree_trunk.png");
  treeTrunk.resize(gridSize, gridSize);
  walk1=loadImage("img_1.png");
  walk2=loadImage("img_2.png");
  jump=loadImage("img_jump.png");
  jump.resize(gridSize, gridSize/2+gridSize/4);
  goomba=loadImage("goomba.png");
  goomba.resize(gridSize, gridSize);
  walk2.resize(gridSize, gridSize);
  walk1.resize(gridSize/2+gridSize/4, gridSize);
  thwomp=loadImage("thwomp.png");
  thwomp.resize(gridSize*2, gridSize*2);
  thwompEvil=loadImage("thwompEvil.png");
  thwompEvil.resize(gridSize*2, gridSize*2);
  hammerBro=loadImage("hammerBro.png");
  hammerBro.resize((gridSize*2), (gridSize*2));
  hammer=loadImage("hammer.png");
  hammer.resize(gridSize/2, gridSize/2);
  hammerBroReversed=loadImage("hammerBroReversed.png");
  hammerBroReversed.resize(gridSize*2, gridSize*2);
  water=new PImage[2];
  water[0]=loadImage("water.png");
  water[0].resize(gridSize, gridSize);
  water[1]=loadImage("waterWave.png");
  water[1].resize(gridSize, gridSize);
  portal=loadImage("portal.png");
  portal.resize((int)(0.6*gridSize), (int)(0.6*gridSize));
  terrain = new ArrayList<FGameObject>();
  boxes=new ArrayList<>();
  enemies=new ArrayList<>();
  reset();
  zoom=2;
}
void reset(){
  world = new FWorld(-10000, -10000, 10000, 10000);
  world.setGravity(0, 900);
  enemies=new ArrayList<FGameObject>();
  if(level==1){
    map=loadImage("level2.png");
  }
  else if(level==2){
    map=loadImage("level2.png");
  }
  for(int y=0;y<map.height;y++){
    for(int x=0;x<map.width;x++){
      color c=map.get(x, y);
      color s=map.get(x, y+1);
      color w=map.get(x-1, y);
      color e=map.get(x+1, y);
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      if(c==black){
        b.attachImage(stone);
        b.setFriction(4);
        b.setName("wall");
        world.add(b);
      }
      else if(c==#00A2E8){
        b.attachImage(ice);
        b.setFriction(0);
        b.setName("ice");
        world.add(b);
      }
      else if(c==#22B14C){
        b.attachImage(trampoline);
        b.setRestitution(1);
        b.setName("idk");
        world.add(b);
      }
      else if(c==#ED1C24){
        FPoly p=new FPoly();
        p.vertex(x*gridSize-gridSize/2, y*gridSize+gridSize/2);
        p.vertex(x*gridSize+gridSize/2, y*gridSize+gridSize/2);
        p.vertex(x*gridSize, y*gridSize-gridSize/2);
        //p.attachImage(spike);
        p.setFillColor(#123456);
        p.setName("spike");
        p.setStatic(true);
        world.add(p);
      }
      else if(c==#B97A57){
        FBridge br=new FBridge(gridSize*x, gridSize*y);
        br.setFriction(4);
        br.setName("bridge");
        world.add(br);
        terrain.add(br);
      }
      else if(c==green && s==brown){
        b.attachImage(treeIntersect);
        b.setName("treetop");
        b.setFriction(4);
        world.add(b);
      }
      else if(c==green && w==green && e==green){
        b.attachImage(treeMiddle);
        b.setName("treetop");
        b.setFriction(4);
        world.add(b);
      }
      else if(c==green && w!=green){
        b.attachImage(treeEndWest);
        b.setName("treetop");
        b.setFriction(4);
        world.add(b);
      }
      else if(c==green && e!=green){
        b.attachImage(treeEndEast);
        b.setName("treetop");
        b.setFriction(4);
        world.add(b);
      }
      else if(c==brown){
        b.attachImage(treeTrunk);
        b.setName("treeTrunk");
        world.add(b);
      }
      else if(c==#FFF200){
        b.setFillColor(#FFF200);
        b.setName("checkpoint");
        world.add(b);
      }
      else if(c==#FFAEC9){
        FGoomba g=new FGoomba(x*gridSize, y*gridSize);
        g.setName("goomba");
        world.add(g);
        enemies.add(g);
      }
      else if(c==#7F7F7F){
        int newY=y;
        newY++;
        c=map.get(x, newY);
        while(c==#FFFFFF || c==#B97A57){
          newY++;
          c=map.get(x, newY);
        }
        FThwomp t=new FThwomp(x*gridSize+gridSize/2, y*gridSize+gridSize/2, (newY)*gridSize);
        t.setName("thwomp");
        world.add(t);
        enemies.add(t);
      }
      else if(c==#A349A4){
        FHammerBro h = new FHammerBro(x*gridSize+gridSize/2, y*gridSize+gridSize/2);
        world.add(h);
        enemies.add(h);
      }
      else if(c==#3F48CC){
        FWater g=new FWater(gridSize*x, gridSize*y);
        g.setName("water");
        terrain.add(g);
        world.add(g);
      }
      else if(c==#FFC90E){
        b.setFillColor(#FFC90E);
        b.setName("ending");
        world.add(b);
        
      }
      else if(c==#FF7F27){
        FPoly p=new FPoly();
        p.vertex(x*gridSize-gridSize/2, y*gridSize-gridSize/2);
        p.vertex(x*gridSize+gridSize/2, y*gridSize-gridSize/2);
        p.vertex(x*gridSize, y*gridSize+gridSize/2);
        //p.attachImage(spike);
        p.setFillColor(#123456);
        p.setName("spike");
        p.setStatic(true);
        world.add(p);
      }
      else if(c==#FFFFFF){
      }
      else{
        boolean found=false;
        for(int i=openPortals.size()-1;i>=0;i--){
          if(openPortals.get(i).getFillColor()==c){
            FPortal p = new FPortal(x*gridSize, y*gridSize, openPortals.get(i));
            FBox t = new FBox(gridSize, gridSize);
           
            t.setFillColor(c);
            t.setStatic(true);
            t.setSensor(true);
            t.setPosition(x*gridSize, y*gridSize);
            t.setName("none");
            t.setNoStroke();
            world.add(t);
            
            FBox q = new FBox(gridSize, gridSize);
            q.setFillColor(c);
            q.setStatic(true);
            q.setSensor(true);
            q.setPosition(openPortals.get(i).getX(), openPortals.get(i).getY());
            q.setNoStroke();
            q.setName("none");
            world.add(q);
           
            
            openPortals.get(i).attachPortal(p);
            p.setFillColor(c);
            terrain.add(p);
            terrain.add(openPortals.get(i));
            world.add(p);
            world.add(openPortals.get(i));
            openPortals.remove(i);
            found=true;
            break;
          }
        }
        if(found==false){
          openPortals.add(new FPortal(x*gridSize, y*gridSize));
          openPortals.get(openPortals.size()-1).setFillColor(c);
        }
      }
    }
  }
  loadPlayer();
  player1.setVelocity(0, 0);
}
void draw(){
  background(100, 200, 30);
  drawWorld();
  actWorld();
  //  player1.setVelocity(vx*(gridSize/25), player1.getVelocityY());
  
}
void actWorld(){
  player1.act();
  for(int i=0;i<terrain.size();i++){
    FGameObject t = terrain.get(i);
    t.act();
  }
  for(int i=0;i<enemies.size();i++){
    FGameObject e = enemies.get(i);
    e.act();
  }
}
void drawWorld(){
  portalCooldown--;
  pushMatrix();
  translate(-player1.getX()*zoom+width/2, -player1.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}
void loadPlayer(){
  player1=new FPlayer();
  player1.setName("Player");
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
