class Bullet //<>// //<>//
{
  // Variables
  int x;
  int y;
  int d;
  int speed;

  boolean readyToGo;
  boolean fireUp;

  int left;
  int right;
  int top;
  int bottom;

  // constructor
  Bullet(int startingX, int startingY, boolean fireUp)
  {
    x = startingX;
    y = startingY;
    d = 16;
    speed = 5;

    readyToGo = false;
    this.fireUp = fireUp;

    left = x - d/2;
    right = x + d/2;
    top = y -d/2;
    bottom = y + d/2;
  }

  void render()
  {
    checkBulletInCanvas();
    if (!readyToGo)
    {
      if(fireUp)
        moveUp();
      else
        moveDown();
        
      if(fireUp)
        fill(0, 255, 255);
      else
        fill(255, 0, 0); 
        
      circle(x, y, d);
    }
  }

  void moveDown()
  {
    y += speed;

    left = x - d/2;
    right = x + d/2;
    top = y + d/2;
    bottom = y - d/2;
  }
  
  void moveUp()
  {
    y -= speed;

    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
  }

  void checkBulletInCanvas()
  {
    if (y < 0 || y > 1000)
    {
      readyToGo = true;
    }
  }

  boolean shootEnemy(Enemy e)
  {
   // println(y + "=bT: "+top + "/b: "+bottom+"--// eB:" + e.bottom + " e.T " + e.top + "/ e.y "+ e.y); 
      if (top < e.bottom && bottom >= e.top
      && left <= e.right && right >=e.left)
    {
      e.shouldRemove = true;
      readyToGo = true;
      println("dead");
      return true;
    }
    return false;
  }
  
  boolean shootBullet(Bullet e)
  {
    if (bottom > e.bottom && top >= e.top
      && left <= e.right && right >=e.left
      )
    {
      readyToGo = true;
      e.readyToGo = true;
      return true;
    }
    return false;
  }

  boolean shootPlayer(Player p)
  {
    if(bottom >= p.top && 
        right >= p.left &&
        left <= p.right &&
        top <= p.bottom)
    {
      readyToGo = true;
  //    println("Player hit");
      return true;
    }
    return false;
  }
}
