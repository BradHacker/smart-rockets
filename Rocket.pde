class Rocket {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float fitness;
  
  DNA dna;
  ArrayList<Obstacle> obstacles;
  
  int geneCounter = 0;
  int lifetime;
  int size = 10;
  int lifeCounter;
  
  boolean stopped = false;
  boolean reachedTarget = false;
  
  Rocket(int _lifetime, ArrayList<Obstacle> _obstacles) {
    lifetime = _lifetime;
    dna = new DNA(_lifetime);
    obstacles = _obstacles;
    
    location = new PVector(width/2,height-50);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  void applyForce(PVector f) {
    //System.out.println(f);
    acceleration.add(f);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    if(location.x >= width - size/2) {
      stopped = true;
    }
    if(location.x-size/2 <= 0) {
      stopped = true;
    }
    if(location.y >= height - size/2) {
      stopped = true;
    }
    if(location.y-size/2 <= 0) {
      stopped = true;
    }
  }
  
  void fitness(Target target) {
    float d = PVector.dist(location,target.location);
    fitness = 1/d;
    if(stopped) fitness *= 0.08;
    if(reachedTarget) fitness *= 3.0;
    if(reachedTarget) fitness *= -(1.5/lifetime)*lifeCounter+1.5;
  }
  
  Rocket crossover(Rocket partner) {
    Rocket child = new Rocket(lifetime, obstacles);
    
    for(int i = 0; i < dna.genes.length; i++) {
      if(int(random(2)) == 1) {
        child.dna.genes[i] = dna.genes[i];
        //System.out.println("parent a");
      } else {
        child.dna.genes[i] = partner.dna.genes[i];
        //System.out.println(child.dna.genes[i]);
      }
    }
    //System.out.println(child.dna.genes[0]);
    return child;
  }
  
  Rocket crossoverMidpoint(Rocket partner) {
    Rocket child = new Rocket(lifetime, obstacles);
    int midpoint = int(random(0,dna.genes.length));
    int f = int(random(2));
    
    for(int i = 0; i < dna.genes.length; i++) {
      if(i < midpoint) {
        if(f == 0) child.dna.genes[i] = dna.genes[i];
        else child.dna.genes[i] = partner.dna.genes[i];
        //System.out.println("parent a");
      } else {
        if(f == 1) child.dna.genes[i] = dna.genes[i];
        else child.dna.genes[i] = partner.dna.genes[i];
        //System.out.println(child.dna.genes[i]);
      }
    }
    //System.out.println(child.dna.genes[0]);
    return child;
  }
  
  void mutate(float mutationRate) {
    for(int i = 0; i < dna.genes.length; i++) {
      if(random(1) < mutationRate) {
        dna.genes[i] = PVector.random2D();
        dna.genes[i].mult(random(0,dna.maxForce));
      }
    }
  }
  
  void run(int l) {
    if(!stopped && !reachedTarget) {
      lifeCounter = l;
      applyForce(dna.genes[geneCounter]);
      geneCounter++;
      update();
      obstacles();
      hitTarget();
    }
  }
  
  void display() {
    fill(150);
    if(stopped) fill(165,0,0);
    if(reachedTarget) fill(0, 216, 14);
    stroke(0);
    strokeWeight(1);
    ellipse(location.x,location.y,size,size);
    stroke(244, 206, 66);
    strokeWeight(4);
    line(location.x,location.y,location.x+-8*cos(velocity.heading()),location.y+-8*sin(velocity.heading()));
  }
  
  void obstacles() {
    for(Obstacle obs : obstacles) {
      if(obs.contains(location, size)) {
        //System.out.println("STOP");
        stopped = true;
      }
    }
  }
  
  void hitTarget() {
    float d = PVector.dist(location,target.location);
    if(d <= target.size/2+size/2) {
      //System.out.println("TARGET");
      reachedTarget = true;
    }
  }
}