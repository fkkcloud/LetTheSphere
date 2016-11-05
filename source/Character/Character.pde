/*
2014/07/06
Author : Jae Hyun Yoo
Class for Chractor
*/
public class Character {
  
  AudioPlayer sound;
  PImage [] imgseq;
  float posX;
  float posY;
  List<PVector> posList;
  
  public Character(float x, float y, String path, String extension, int framelen)
  {
    posList = new ArrayList<PVector>();
    this.imgseq = loadImages(path, extension, framelen);
    this.posX = x;
    this.posY = y;
  }
  
  public List<PVector> scanPts(float mousex, float mousey)
  {
    this.posList.clear();
    PVector currentPos = new PVector(posX, posY);
    PVector dir = new PVector(this.posX, this.posY);
    dir.sub(new PVector(mousex, mousey));
    dir.normalize();
    
    int[] angles = {34, 24, 8, 0, -8, -24, -34};
    for (int i=0; i<angles.length; i++){
      PVector vec = new PVector(dir.x, dir.y);
      vec.rotate(radians(angles[i]+180));
      vec.setMag(57);
      vec.add(currentPos);
      this.posList.add(new PVector(vec.x, vec.y));
      
      PVector vec2 = new PVector(dir.x, dir.y);
      vec2.setMag(22);
      vec2.rotate(radians(angles[i]+180));
      vec2.add(currentPos);
      this.posList.add(new PVector(vec2.x, vec2.y));
    }
    return this.posList;
  }
  
  public int getImageLen()
  {
    return this.imgseq.length;
  }
  
  public void setSound(String path)
  {
    this.sound = maxim.loadFile(path);
    this.sound.setLooping(true);
  }
  
  public void playSound(float speed)
  {
    this.sound.speed(speed);
    this.sound.volume(1);
    this.sound.play();
  }
  
  public void stopSound()
  {
    this.sound.stop();
  }
  
  public void draw(int currentAnimFrame)
  {
    currentAnimFrame = currentAnimFrame % this.imgseq.length;
    image(imgseq[currentAnimFrame], this.posX, this.posY, 50, 50);
  }
  
  public void setPos(float x, float y)
  {
    this.posX = x;
    this.posY = y;
  }
  
  public void setPos(PVector pos)
  {
    this.posX = pos.x;
    this.posY = pos.y;
  }
  
  public PVector getPos()
  {
    return new PVector(posX, posY);
  }
  
}
