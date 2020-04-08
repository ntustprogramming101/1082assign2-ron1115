PImage bgImg;
PImage hugImg;
PImage lifeImg;
PImage robotImg;
PImage soliImg;
PImage soldierImg;
PImage cabbgeImg;
PImage titleImg;
PImage gameoverImg;
PImage restartImg;
PImage restartHoveredImg;
PImage startImg;
PImage startHoveredImg;
int x=320,y=240;//center
//soldier
float sx;
int sy;
float xSpeed;
int sWeight;
//robot
float rx,ry;
int rWeight;
//lazer
float lx,lxSpeed,gunx,ly;
//hug
float hugX =240 ,hugY=80;
int hugSpeed = 80,hugSpeedy = 80;
int hugWeight =80;
//cabbge
int cX=floor(random(8))*80;
int cY=floor(random(160,480));
int cWeight80;
//life
int lx1=10,lx2=80,lx3=-50,ly1,ly2,ly3,ld=200;
//game
final int game_start = 1,game_run = 2,game_hurt = 3,game_lose = 4;
int gameState;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;


void setup() { 

    
  size(640,480);
  bgImg = loadImage("img/bg.jpg");
  hugImg = loadImage("img/groundhog.png");
  lifeImg = loadImage("img/life.png");
  robotImg = loadImage("img/robot.png");
  soliImg = loadImage("img/soil.png");
  soldierImg = loadImage("img/soldier.png");
  cabbgeImg = loadImage("img/cabbage.png");
  titleImg = loadImage("img/title.jpg");
   gameoverImg = loadImage("img/gameover.jpg");
   restartImg = loadImage("img/restartNormal.png"); 
   restartHoveredImg = loadImage("img/restartHovered.png"); 
   startImg = loadImage("img/startNormal.png"); 
   startHoveredImg = loadImage("img/startHovered.png"); 
  //soldier
  sx = 0;
  sy = floor(random(160,480));
  sWeight = 100;
  xSpeed = 4;
  //robot
  rWeight = 80;
  rx = floor(random(8))*80;
  ry = floor(random(160,480));
  //lazer
  gunx = rx+25;
  lx = rx+20;
  lxSpeed =1;
  gameState=game_start;
  
}
 void draw(){
    // Switch Game State
    // Game Start
  switch(gameState){
    case game_start:
      image(titleImg, 0, 0);
      image(startImg, 248, 360,144,60);
      if(mouseX > 248 && mouseX < 248+144
      && mouseY > 360 && mouseY < 360+60){       
        if(mousePressed){
          gameState = game_run;
        }
      }else{
        image(startHoveredImg, 248, 360);
      }
      break;
 // Game Run
     case game_run:
 //background
   image(bgImg,0,0);
 //grass
   rectMode(CENTER);
   fill(124,204,25);
   noStroke();
   rect(x,y/1.57,width,y/16);
 //solid
   imageMode(CORNER);
   image(soliImg,0,y-y/3);
 //sun
   fill(253,184,19);
   stroke(255,255,0);
   strokeWeight(5);
   ellipse(width-50,50,120,120);
 //hug
   /*imageMode(CORNER);
   if (upPressed) {
      hugY -= hugSpeed;
    }
    if (downPressed) {
       hugY  += hugSpeed;
    }
    if (leftPressed) {
      hugX -= hugSpeed;
    }
    if (rightPressed) {
      hugX += hugSpeed;
    }*/
   image(hugImg,hugX,hugY);

 //life
   imageMode(CORNER);
   image(lifeImg,lx1,y/24,50,50);
   image(lifeImg,lx2,y/24,50,50);
   image(lifeImg,lx3,y/24,50,50);
   
 
 
 //soldier
   sx = sx + xSpeed;
  if(sx>width){sx = 0-sWeight;
               sy =floor(random(160,480));}
    

  if(sy<240){sy = 160;}
  else if (sy<320){sy = 240;}
  else if (sy<400){sy = 320;}
  else if (sy<480){sy = 400;}

  image(soldierImg,sx,sy);
//crsah----------
 if (hugX<sx+sWeight && hugX+hugWeight>sx && hugY+hugWeight>sy && sy+sWeight>hugY){
   hugX = 240;
   hugY =80; 
   lx2=-ld;
   }
   if(hugX<sx+sWeight && hugX+hugWeight>sx && hugY+hugWeight>sy
   && sy+sWeight>hugY && lx2==-ld){
     lx1=-ld;
     
   }
//life++
if (hugX<cX+sWeight && hugX+hugWeight>cX && hugY+hugWeight>cY && cY+sWeight>hugY){ 
   lx2=80;
    cX=-ld;
   }
   

  //cabbge
  if(cY<240){cY = 160;}
  else if (cY<320){cY = 240;}
  else if (cY<400){cY = 320;}
  else if (cY<480){cY = 400;}
  image(cabbgeImg,cX,cY);
  
//BORDER
  if(hugX>width-hugWeight){hugX = width-hugWeight;}
  if(hugX<0){hugX = 0;}
  if(hugY<y/3){hugY=y/3;}
  if(hugY>=height){hugY = height-hugWeight;}
  
break;
   

    

    // Game Lose
     case game_lose:
    image (gameoverImg,0,0);
      }  
    }
   
void keyPressed() {
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      
          
      case UP:
        hugY -= hugSpeed;
        break;
      case DOWN:
        hugY  += hugSpeed;
        break;
      case LEFT:
       hugX -= hugSpeed;
        break;
      case RIGHT:
        hugX += hugSpeed;
        break;
    }
  }
}     


/*void  keyPressed() {
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      
          
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }

  }*/
