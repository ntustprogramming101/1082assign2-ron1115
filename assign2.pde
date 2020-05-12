
PImage bgImg;
PImage groundhogIdleImg;
PImage lifeImg;
PImage soliImg;
PImage soldierImg;
PImage cabbgeImg;
PImage titleImg;
PImage gameoverImg;
PImage restartImg;
PImage restartHoveredImg,  groundhogDownImg,
  groundhogLeftImg,
  groundhogRightImg;
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
float groundhogX=320 ,groundhogY =80;
int hugSpeed = 80,hugSpeedy = 80;
int hugWeight =80;
float groundhogLestX, groundhogLestY;
int groundhogMoveTime = 250;
int actionFrame; //groundhog's moving frame 
float lastTime; //time when the groundhog finished moving
//cabbge
int cX=floor(random(8))*80;
int cY=floor(random(2,6))*80;
int cWeight80;
//life
int lifepoint =2;
//game
final int game_start = 1,game_run = 2,game_hurt = 3,game_lose = 4;
int gameState;

boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;


void setup() { 

    
  size(640,480);
  bgImg = loadImage("img/bg.jpg");
  groundhogIdleImg = loadImage("img/groundhogIdle.png");
  groundhogDownImg = loadImage("img/groundhogDown.png");
  groundhogLeftImg = loadImage("img/groundhogLeft.png");
  groundhogRightImg = loadImage("img/groundhogRight.png");
  lifeImg = loadImage("img/life.png");
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
  sWeight = 80;
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
      image(startHoveredImg, 248, 360,144,60);
      if(mouseX > 248 && mouseX < 248+144
      && mouseY > 360 && mouseY < 360+60){       
        if(mousePressed){
          gameState = game_run;
        }
      }else{
        image(startImg, 248, 360);
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
    //groundhog
    //print(downPressed+"\n");
    //When the button is not pressed, draw the groundhogIdle image
    if (downPressed == false && leftPressed == false && rightPressed == false) {
      image(groundhogIdleImg, groundhogX, groundhogY, hugWeight, hugWeight);
    }
    //draw the groundhogDown image between 1-14 frames
    if (downPressed) {
      actionFrame++;
      if (actionFrame > 0 && actionFrame < 15) {
        groundhogY += hugWeight / 15.0;
        image(groundhogDownImg, groundhogX, groundhogY, hugWeight, hugWeight);
      } else {
        groundhogY = groundhogLestY + hugWeight;
        downPressed = false;
        
      }
    }
    
    //draw the groundhogLeft image between 1-14 frames
    if (leftPressed) {
      actionFrame++;
      if (actionFrame > 0 && actionFrame < 15) {
        groundhogX -= hugWeight / 15.0;
        image(groundhogLeftImg, groundhogX, groundhogY, hugWeight, hugWeight);
      } else {
        groundhogX = groundhogLestX - hugWeight;
        leftPressed = false;
      }
    }
    //draw the groundhogRight image between 1-14 frames
    if (rightPressed) {
      actionFrame++;
      if (actionFrame > 0 && actionFrame < 15) {
        groundhogX += hugWeight / 15.0;
        image(groundhogRightImg, groundhogX, groundhogY, hugWeight, hugWeight);
      } else {
        groundhogX = groundhogLestX + hugWeight;
        rightPressed = false;
      }
    }
 

 //life
 
   imageMode(CORNER);
   for(int lx1=0; lx1 < lifepoint ;lx1++){
   image(lifeImg,70*lx1,y/24,50,50);
   }
 
 
 //soldier
   sx = sx + xSpeed;
  if(sx>width){sx = 0-sWeight;
               }
    
  if(sy<240){sy = 160;}
  else if (sy<320){sy = 240;}
  else if (sy<400){sy = 320;}
  else if (sy<480){sy = 400;}

  image(soldierImg,sx,sy);
//crsah----------
  if (groundhogX<sx+sWeight && groundhogX+hugWeight>sx && groundhogY+hugWeight>sy &&
  sy+sWeight>groundhogY){
   groundhogX = 240;
   groundhogY =80; 
   lifepoint--;
   if (lifepoint > 0 && lifepoint <= 3) {
          groundhogX = 320;
          groundhogY = 80;
        }
        //When returning to its original position, the groundhog doesn't start moving directly
        downPressed = false; 
        leftPressed = false;
        rightPressed = false;
      }
    
   
  if(lifepoint==0){
  gameState=game_lose;
}       
   
//life++
  if (groundhogX<cX+sWeight && groundhogX+hugWeight>cX && groundhogY+hugWeight>cY &&
  cY+sWeight>groundhogY){ 
     lifepoint++;
      cX=-100;
      cY=-100;
     }
   

//cabbge
  /*if(cY<240){cY = 160;}
  else if (cY<320){cY = 240;}
  else if (cY<400){cY = 320;}
  else if (cY<480){cY = 400;}*/
  image(cabbgeImg,cX,cY);
  
//BORDER
 
  if(groundhogX>width-hugWeight){groundhogX = width-hugWeight;}
  if(groundhogX<0){groundhogX = 0;}
  if(groundhogY<y/3){groundhogY=y/3;}
  if(groundhogY>=height-hugWeight){groundhogY = height-hugWeight;}
 
 
 break;
   
// Game Lose
    case game_lose:
    image (gameoverImg,0,0);
     image(restartHoveredImg, 248, 360,144,60);
      groundhogX =240; 
      groundhogY=80;
      if(mouseX > 248 && mouseX < 248+144
      && mouseY > 360 && mouseY < 360+60){       
        if(mousePressed){
          lifepoint = 2;
           cX=floor(random(8))*80;
           cY=floor(random(2,6))*80;
          image(cabbgeImg,cX,cY);
          
          gameState = game_run;
        }
      }else{
        image(restartImg, 248, 360);
      }
      break;
    
 }       
 }
  
void keyPressed() {
  float newTime = millis(); //time when the groundhog started moving
  if (key == CODED) {
    switch (keyCode) {
    case DOWN:
      if (newTime - lastTime > 250) {
        downPressed = true;
        actionFrame = 0;
        groundhogLestY = groundhogY;
        lastTime = newTime;
      }
      break;
    case LEFT:
      if (newTime - lastTime > 250) {
        leftPressed = true;
        actionFrame = 0;
        groundhogLestX = groundhogX;
        lastTime = newTime;
      }
      break;
    case RIGHT:
      if (newTime - lastTime > 250) {
        rightPressed = true;
        actionFrame = 0;
        groundhogLestX = groundhogX;
        lastTime = newTime;
      }
      break;
    }
  }
}
   
/*void keyPressed() {
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      
          
      case UP:
        
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


void  keyPressed() {
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
     
 
 

 
 
