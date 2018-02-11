int lifetime;
int lifeCounter;
int genCount;
int reachedAmount;
int populationSize = 20;

float percentReachedTarget;
float mutationRate;

Population population;

Target target;

void setup() {
  size(640, 480);
  lifetime = 700;
  lifeCounter = 0;
  genCount = 1;
  
  target = new Target();
  
  mutationRate = 0.01;
  population = new Population(mutationRate, populationSize, lifetime, target);
}

void draw() {
  background(255);
  if(lifeCounter < lifetime) {
    lifeCounter++;
    population.live(lifeCounter);
  } else {
    reachedAmount = 0;
    for(int i = 0; i < population.population.length; i++) {
      if(population.population[i].reachedTarget) reachedAmount++;
    }
    percentReachedTarget = float(reachedAmount)/float(population.population.length)*100.0;
    
    population.fitness();
    population.selection();
    population.reproduction();
    
    lifeCounter = 0;
    genCount++;
  }
  
  target.display();
  population.display();
  
  int textMargin = 4;
  
  fill(200,50);
  noStroke();
  rect(0,0,250,62);
  fill(0);
  text("Time Left In Gen: " + (lifetime - lifeCounter),textMargin,12);
  text("Percent Hit Target Last Gen: " + percentReachedTarget + "%",textMargin,24);
  text("Gen: " + genCount,textMargin,36);
  text("Mutation Rate: " + mutationRate*100 + "%",textMargin,48);
  text("Population Size: " + populationSize,textMargin,60);
}