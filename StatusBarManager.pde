int totalPoints;
int totalLives;
int totalShots;
int enemiesHit;
int accuracy;

class StatusBarManager
{
  StatusBarManager()
  {
    totalPoints = 0;
    totalLives = 5;
    totalShots = 0;
    enemiesHit = 0;
    accuracy = 100;
  }

  void renderStatusBar() {
    // Status bar settings
    int statusBarHeight = 200;
    color statusBarColor = color(100, 100, 255, 150); // Change color as needed

    if(totalLives == 1)
      statusBarColor = #FF0000;

    pushStyle(); // Start a new style
    // Draw the status bar
    fill(statusBarColor);
    rect(0, 0, 400, statusBarHeight);

    // Add text or other status information
    fill(255);
    textSize(20);
    textAlign(LEFT, LEFT);
    text("Lives:   " + totalLives, 10, 20);
    text("Shots:   " + totalShots, 10, 40);
    text("Hits:   " + enemiesHit, 10, 60);
    if (totalPoints>0)
    {
      accuracy = totalPoints / totalShots * 10; 
    }
    
    text("Accuracy:   " + accuracy + "%", 10, 80);
    text("Points:     " + totalPoints, 10, 100);

    popStyle(); // Restore original style
  }
  int consecutiveKills = 0;
  // Enemies
  void incrementEnemiesHit()
  {
    enemiesHit++;
    consecutiveKills ++;
    if(consecutiveKills == 20)
    {
      incrementLives();
      consecutiveKills = 0;
    }
  }
  
  // Shots
  void incrementShots()
  {
    totalShots++;
  }

  // Points
  void incrementPoints()
  {
    totalPoints = totalPoints+10;
  }

  // Lives
  void incrementLives()
  {
    totalLives++;
  }

  boolean decrementLives()
  {
    totalLives--;
    if(totalLives == 0)
    {
      //println("Total lives: " + totalLives);
      return true;
    }
    return false;
  }
  
  String getTotalPoints()
  {
    return str(totalPoints);
  }
  
  void resetGame()
  {
    totalPoints = 0;
    totalLives = 5;
    totalShots = 0;
    enemiesHit = 0;
    accuracy = 100;
  }
  
}
