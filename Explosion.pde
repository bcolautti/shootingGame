ArrayList<Particle> particles = new ArrayList<Particle>();
int numParticles = 100;

class Explosion
{
  Explosion(int xPos, int yPos)
  {
    PVector explosionPos = new PVector(xPos, yPos);
    for (int i = 0; i < numParticles; i++) {
      particles.add(new Particle(explosionPos));
    }
  }
  
  void render()
  {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.update();
      p.display();
      if (p.finished()) {
        particles.remove(i);
      }
    }
  }
  
  boolean finished()
  {
    return particles.size()==0;
  }
}
