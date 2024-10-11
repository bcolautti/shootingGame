import processing.sound.*;

class Player
{
  PImage image;
  SoundFile fregadosFile;
  SoundFile shootFile;
  int x ;
  int y ;
  int w;
  int h;

  int left;
  int right;
  int top;
  int bottom;
  
  boolean killedMessagePlayed = false;
  boolean isMovingLeft;
  boolean isMovingRight;
  boolean isMovingUp;
  boolean isMovingDown;

  int speed;
  int imageWidth;
  
  Player(int startingX, int startingY, int startingW, int startingH)
  {
    fregadosFile = new SoundFile(ShootingGame.this, "resources/audio/fregados.mp3");
    shootFile = new SoundFile(ShootingGame.this, "resources/audio/disparo_1.wav");
    image = loadImage("resources/images/caza_1.png");
    image.resize(100, 100);
    imageWidth = image.width;
    //println("imageWidth: "+imageWidth);

    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;

    left = x - w/3;
    right = x + w/3;
    top = y - h/3;
    bottom = y + h/3;
    
    isMovingLeft = false;
    isMovingRight = false;
    isMovingUp = false;
    isMovingDown = false;

    speed = 10;
  }

  void render()
  {
    image(image, x-imageWidth/2, y-50);
    
    left = x - w/3;
    right = x + w/3;
    top = y - w/3;
    bottom = y + w/3;
  }

  void kill()
  {
    
    if(!killedMessagePlayed && !fregadosFile.isPlaying())
    {
      fregadosFile.play();
      killedMessagePlayed = true;
    }
  }
  
  void shoot()
  {
      shootFile.play();
  }

  void move()
  {
    if (isMovingLeft == true)
    {
      if (x != 80)
      {
        x-=speed;
      }
    }
    if (isMovingRight == true)
    {
      if (x != width-80)
      {
        x+=speed;
      }
    }
    if (isMovingUp == true)
    {
      if (y != -80)
      {
        y-=speed;
      }
    }
    if (isMovingDown == true)
    {
      if (y != height-80)
      {
        y+=speed;
      }
    }
  }
}
