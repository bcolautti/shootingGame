// EnemyLaucher's responsability is launch enemy objects to kill the player //<>// //<>//
public class EnemyLauncher
{
  private ArrayList<Enemy> enemyList;
  ArrayList<PowerUp> powerUpList;
  Enemy lastLaunched;
  int x;
  int y;
  int w;
  int h;

  int speed;

  boolean isMovingLeft;
  boolean isMovingRight;

  int projectilFrequency;
  
  int renderedTimes;
  int lastLaunchedRenderTime;

  EnemyLauncher(int startingX, int startingY, int startingW, int startingH)
  {
    enemyList = new ArrayList<Enemy>();
    powerUpList = new ArrayList<PowerUp>();
    
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;

    isMovingLeft = true;
    isMovingRight = false;

    speed = 5;
    projectilFrequency = 300;
    lastLaunched = null;
    renderedTimes   = 0;
  }

  // we'll use a render just for testing purposes.
  void render()
  {
    renderedTimes+=1;
    //println(renderedTimes);
    
    rectMode(CENTER);
    rect(x, y, w, h);

    for (Enemy e : enemyList)
    {
      e.render();
      e.move();
    }
    
    if(powerUpList.size() > 0)
    {
       for (
        int i = powerUpList.size() - 1;
        i >= 0;
        i--)
      {
        PowerUp e = powerUpList.get(i);
        if (e.shouldRemove == true)
        {
          powerUpList.remove(e);
        }

        if (e.y > height + 200)
        {
          powerUpList.remove(e);
        }
      }
    }

    if (enemyList.size() > 0)
      // println(enemyList.size());
      for (
        int i = enemyList.size() - 1;
        i >= 0;
        i--)
      {
        Enemy e = enemyList.get(i);
        if (e.shouldRemove == true)
        {
          enemyList.remove(e);
        }

        if (e.y > height + 200)
        {
          enemyList.remove(e);
        }
      }
    //println(enemyList.size());
  }

  void move()
  {
    if (x == 0)
      x = 10;

    if (isMovingLeft == true)
    {
      x-=speed;
    }
    if (isMovingRight == true)
    {
      x+=speed;
    }

    if (width - (w/2) < x)
    {
      isMovingLeft = true;
      isMovingRight = false;
    } else if (x <=  (w/2))
    {
      isMovingRight = true;
      isMovingLeft = false;
    }

    if (enemyList.size() < 6 )
    {
      float rnd = random(width);
      boolean isFarEnough = false;

      if (lastLaunched != null)
      {
    //    println("last launched x : " + lastLaunched.x + "/"+x+" width " + lastLaunched.w);
        isFarEnough = x - lastLaunched.w + random(100) > lastLaunched.x || x + lastLaunched.w + random(100) < lastLaunched.x ;

        if (rnd > x && isFarEnough && renderedTimes + 10 + random(20) > lastLaunchedRenderTime )
        {
          launch();
        }
      } else
      {
        launch();
      }
    }
  }

  void launch()
  {
    lastLaunchedRenderTime = renderedTimes;
    lastLaunched = new Enemy(x, y, 100, 100);


    enemyList.add(lastLaunched);
  }
}
