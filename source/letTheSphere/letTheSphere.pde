/*
2014/07/06
Author : Jae Hyun Yoo
Main
*/

import java.util.List;

Maxim maxim;
AudioPlayer sound_warning;
AudioPlayer sound_gameover;
Character ball;
PImage map;
PVector pos;
float soundSpeed;
int currentAnimFrame;
int gameover = 0;
int clear = 0;


void setup()
{
  // setting main
  size(640, 960);
  background(0);
  currentAnimFrame = 0;
  imageMode(CENTER);
  pos = new PVector(width * 0.9, height * 0.8);
  
  // init maxim object
  maxim = new Maxim(this);
  
  // loading sound fx for warning
  sound_warning = maxim.loadFile("warning.wav");
  sound_warning.setLooping(true);
  sound_warning.play();
  sound_warning.volume(0);
  
  // loading image sequence for rolling ball
  map = loadImage("map.jpg");
  
  ball = new Character(width*0.82, height*0.84, "data/sanim_", ".png", 194);
  ball.setSound("rolling.wav");
}

void draw()
{
  background(0);
  
  // debug map show
  //image(map, width * 0.5, height * 0.5);
  
  //goal
  fill(255,255,0);
  text("Goal", 600, 20);
  
  // get scanned positions
  List<PVector> scanPts = ball.scanPts(pmouseX, pmouseY);
  
  // detecting objects
  for ( PVector pos : scanPts )
  {
    // grep clr
    color c = map.get((int)pos.x, (int)pos.y);
    
    // gameover setting
    if ( green(c) > 200 && dist(pos.x, pos.y, ball.posX, ball.posY) < 23 )
    {
      gameover = 1;
      break;
    }
   
    if ( green(c) > 200 )
    {
      //float distance = dist(pos.x, pos.y, ball.posX, ball.posY);
      //sound_warning.speed(map(distance, 0, 32, 4, 1));
      sound_warning.volume(1);
      if (gameover == 0)
      {
        fill(255,0,0);
        text("WARNING", width *0.45, height*0.475);
      }
      break;
    } 
    else if ( red(c) > 200 ) 
    {
      clear = 1;
      break;
    } 
    else 
    {
      sound_warning.volume(0);
    }
    //debug scanning
    //rect(pos.x, pos.y, 10, 10);
  }
  
  // moving ball
  int frame = 0;
  float distance  = dist(mouseX, mouseY, ball.posX, ball.posY);
  PVector ballPos = new PVector(ball.posX, ball.posY);
  
  if (distance < 85)
  {
    
    fill(0,255,0);
    frame = millis()/16;
    
    PVector v1 = new PVector(mouseX, mouseY);
    
    v1.sub(ballPos);
    v1.normalize();
    
    if (gameover == 0)
    {
      v1.setMag(distance * 0.012);
      ball.playSound(1.0);
    } else if (gameover == 1) 
    {
      v1.setMag(0);
      ball.stopSound();
      sound_warning.stop();
      frame = 0;
    }
    ballPos.add(v1);
  } 
  else 
  {
    if (gameover == 0)
    {
      fill(255,255,0);
      text("To activate the ball,\nStay close to the ball.", mouseX, mouseY);
      ball.stopSound();
    }
  }
  
  // draw game over
  if (gameover == 1){
    fill(255,0,0,255);
    text("GAME OVER", width *0.45, height*0.475);
  }
  
  // draw victory
  if (clear == 1){
    fill(10, 200, 10, 200);
    text("CLEAR", width *0.45, height*0.475);
  }
  
  // cursor
  rect(mouseX-5, mouseY-5, 5, 5);
  ball.setPos(ballPos);
  ball.draw(frame);
}

