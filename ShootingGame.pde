import gifAnimation.*; //<>// //<>// //<>// //<>// //<>//
import processing.sound.*;

SoundFile file;
SoundFile kaboom;
SoundFile klang;
SoundFile bulletCollision;
Player p1;
EnemyLauncher eL;
BackgroundManager backgroundMgr;
StatusBarManager statusBarManager;
ArrayList<Bullet> bulletList;
ArrayList<Bullet> enemiesBulletList;
ArrayList<Explosion> explosionsList;
boolean hasShotLast = false;
boolean dflag,restartRequested = false;
boolean isGameOver = false;
int backgroundDarkness = 100;

void setup() {
  size(1200, 1000);
  initializeValues();
  backgroundMgr = new BackgroundManager();
  statusBarManager = new StatusBarManager();

  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "resources/audio/backgroundWind.wav");
  kaboom =  new SoundFile(this, "resources/audio/kaboom.wav");
  klang =  new SoundFile(this, "resources/audio/klang.wav");
  bulletCollision = new SoundFile(this, "resources/audio/bulletKlang.wav");
  file.play();
}

void initializeValues()
{
  bulletList = new ArrayList<Bullet>();
  enemiesBulletList = new ArrayList<Bullet>();
  explosionsList = new ArrayList<Explosion>();
  frameRate(40);

  p1 = new Player(width/2, height-50, 50, 50);
  eL = new EnemyLauncher(int(random(width))  , -110, 200, 50);
}

void restart()
{
  restartRequested = true;
  statusBarManager.resetGame();
  backgroundDarkness = 100;
  background(backgroundDarkness);
  dflag = false;
  isGameOver = false;
  initializeValues();
}

void renderGameObjects()
{
  backgroundMgr.draw();
  statusBarManager.renderStatusBar();
  eL.render();
  eL.move();

  p1.render();
  p1.move();
}

void draw() {
  //background(42);
  renderGameObjects();
  
  if (isGameOver) {
    delay(2000);
    dflag = false;
  }else
  {
    for (Bullet b : bulletList)
    {
      if (!b.readyToGo)
      {
        b.render();
        int counter = 0;
        for (Enemy e : eL.enemyList)
        {
          counter++;
          
          if (b.shootEnemy(e))
          {
            println("Hit target");
            
            b.readyToGo = true;                
            kaboom.play();
            explosionsList.add(new Explosion(b.x, e.y+e.h/2));
            
            statusBarManager.incrementPoints();
            statusBarManager.incrementEnemiesHit();
          }
        }
      }
    }
    
    for (Enemy e : eL.enemyList)
    {
      if (e.canShoot() && enemiesBulletList.size() < 10 )
      {
    //    println("Emeny shooting. Bullets in the air: " + enemiesBulletList.size());
        // Enemy shoots bullet
        Bullet chau = new Bullet(e.x, e.y, false);
        enemiesBulletList.add(chau); 
      }
    }
    
    for (Bullet eB : enemiesBulletList)
    {
          if (eB.shootPlayer(p1))
          {
            println("Hit PLAYER");
            eB.readyToGo =true;                
            explosionsList.add(new Explosion(eB.x, p1.y-p1.h/2));
            isGameOver = statusBarManager.decrementLives();
          }
      if (!eB.readyToGo)
      {
        eB.render();
      }
    }
    
    if (explosionsList.size() > 0)
    {
      for (Explosion ex : explosionsList)
      {
        ex.render();
      } //<>//
    }
  }
   //<>//
  freeResources();
  
  if(isGameOver)
  {
    println("Game over");
    finishGame();
  }
}

void finishGame()
{

  if(!dflag )
    fregadosFile.play();

  background(0);
  textSize(100);
  fill(255, 255, 255); // White text
  text("You Lost",100,100);
  dflag = true;
}

void freeResources()
{
  for (
    int i = bulletList.size() - 1;
    i >= 0;
    i--)
  {
    Bullet b = bulletList.get(i);
    if (b.readyToGo == true)
    {
      bulletList.remove(b);
    }
  }

  for (
    int i = enemiesBulletList.size() - 1;
    i >= 0;
    i--)
  {
    Bullet b = enemiesBulletList.get(i);
    if (b.readyToGo == true)
    {
      enemiesBulletList.remove(b);
    }
  }

  for (
    int i = explosionsList.size() - 1;
    i >= 0;
    i--)
  {
    Explosion e = explosionsList.get(i);
    if (e.finished())
    {
      explosionsList.remove(e);
    }
  }
}

void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == LEFT)
    {
      p1.isMovingLeft = true;
    }
    if (keyCode == RIGHT)
    {
      p1.isMovingRight = true;
    }
  } else
  {
    if (key == ' ')
    {
      if(hasShotLast)
      {
        // to prevent pressing the bar to shot, we ignere it. 
      }else
      {
        Bullet chau = new Bullet(p1.x+2, p1.y-50, true);
        bulletList.add(chau);
        statusBarManager.incrementShots();
        
        hasShotLast = true;
      }
    }
  }
}

void keyReleased()
{
  if (key == CODED)
  {
    if (keyCode == LEFT)
    {
      p1.isMovingLeft = false;
    }
    if (keyCode == RIGHT)
    {
      p1.isMovingRight = false;
    }
    
  }else
  {
    if (key == ' ')
    {
      // reset shooting
      hasShotLast = false;
    }
  }
}
