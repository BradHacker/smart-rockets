class Population {
  float mutationRate;
  Rocket[] population;
  ArrayList<Rocket> matingPool;
  int generations;
  Target target;
  ArrayList<Obstacle> obstacles;
  
  Population(float mRate, int size, int lifetime, Target _target) {
    mutationRate = mRate;
    population = new Rocket[size];
    
    obstacles = new ArrayList<Obstacle>();
    
    int obstacleWidth = int(random(200, 400));
    int obstacleHeight = 10;
    
    obstacles.add(new Obstacle(new PVector(random(0,width-obstacleWidth),200),obstacleWidth,obstacleHeight));
    
    for(int i = 0; i < population.length; i++) {
      population[i] = new Rocket(lifetime, obstacles);
    }
    
    target = _target;
    
    matingPool = new ArrayList<Rocket>();
  }
  
  void fitness() {
    for(int i = 0; i < population.length; i++) {
      population[i].fitness(target);
    }
  }
  
  void selection() {
    for(int i = 0; i < population.length; i++) {
      int n = int(population[i].fitness * 10000);
      //System.out.println(population[i].fitness);
      for(int j = 0; j < n; j++) {
        matingPool.add(population[i]);
      }
    }
  }
  
  void reproduction() {
    for(int i = 0; i < population.length; i++) {
      int a = int(random(matingPool.size()));
      int b = int(random(matingPool.size()));
      
      Rocket parentA = matingPool.get(a);
      Rocket parentB = matingPool.get(b);
      
      Rocket child = parentA.crossoverMidpoint(parentB);
      child.mutate(mutationRate);
      
      population[i] = child;
    }
  }
  
  void live(int lifeCounter) {
    for(int i = 0; i < population.length; i++) {
      population[i].run(lifeCounter);
    }
  }
  
  void display() {
    for(int i = 0; i < obstacles.size(); i++) {
      obstacles.get(i).display();
    }
    for(int i = 0; i < population.length; i++) {
      population[i].display();
    }
  }
}