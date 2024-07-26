class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  float lifespan = 255;
  
  Particle(PVector explosionPos) {
    pos = explosionPos.copy();
    vel = PVector.random2D().mult(random(1, 5));
    acc = new PVector(0, 0.1);
  }
  
  void update() {
    vel.add(acc);
    pos.add(vel);
    lifespan -= 5;
  }
  
  void display() {
    noStroke();
    pushStyle(); // Start a new style
    fill(204,0,0, lifespan);
    ellipse(pos.x, pos.y, 8, 8);
    popStyle(); // Restore original style
  }
  
  boolean finished() {
    return lifespan < 0;
  }
}
