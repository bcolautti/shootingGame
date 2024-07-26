
class Enemy
{
  PImage image;
  int x;
  int y;
  int w;
  int h;

  int speed;

  int left;
  int right;
  int top;
  int bottom;
  
  int shots;

  boolean shouldRemove;
  
  Enemy(int startingX, int startingY, int startingW, int startingH)
  {
    image = loadImage("images/nave_enemiga_1.png");
    image.resize(100, 100);

    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;

    left = x - w/3;
    right = x + w/3;
    top = y - h/3;
    bottom = y + h/3;

    shouldRemove = false;

    speed = 3;
  }
  int rounds = 0;
  boolean canShoot()
  {
    float r = random(50);
    rounds++;
    if(shots == 0 || (rounds * 10 / shots) > 130 * shots )
      if(r < 30  && r > 25)
      {
        shots++;
        return true;
      }
    
    return false;
  }  

  void render()
  {
    image(image, x-50, y-50);
  }

  void move()
  {
    y+=speed;
    top = y - h/3;
    bottom = y + h/3;
  }
}
