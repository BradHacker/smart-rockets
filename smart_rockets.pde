int lifetime;
int lifeCounter;
int genCount;
int reachedAmount;
int populationSize = 50;
int avgTimeTaken;

float percentReachedTarget;
float mutationRate;

boolean fullscreen = true;
boolean crossoverTypeMidpoint = true;

Population population;
Target target;
Graph graph;

void settings() {
  if(fullscreen) {
    fullScreen();
  }
}

void setup() {
  if(!fullscreen) {
    size(600,400);
  }
  lifetime = 1000;
  lifeCounter = 0;
  genCount = 1;
  
  target = new Target();
  
  mutationRate = 0.01;
  population = new Population(mutationRate, populationSize, lifetime, target, crossoverTypeMidpoint);
  
  graph = new Graph(200,100);
}

void draw() {
  background(255);
  if(lifeCounter < lifetime) {
    lifeCounter++;
    population.live(lifeCounter);
  } else {
    reachedAmount = 0;
    avgTimeTaken = 0;
    for(int i = 0; i < population.population.length; i++) {
      if(population.population[i].reachedTarget) {
        reachedAmount++;
        avgTimeTaken += population.population[i].lifeCounter;
      }
    }
    percentReachedTarget = float(reachedAmount)/float(population.population.length)*100.0;
    if(reachedAmount > 0) avgTimeTaken /= reachedAmount;
    
    graph.update(avgTimeTaken);
    
    population.fitness();
    population.selection();
    population.reproduction();
    
    lifeCounter = 0;
    genCount++;
  }
  
  target.display();
  population.display();
  graph.display();
  
  int textMargin = 4;
  
  fill(200,50);
  noStroke();
  rect(0,0,250,74);
  fill(0);
  text("Time Left In Gen: " + (lifetime - lifeCounter),textMargin,12);
  text("Percent Hit Target Last Gen: " + percentReachedTarget + "%",textMargin,24);
  text("Gen: " + genCount,textMargin,36);
  text("Mutation Rate: " + mutationRate*100 + "%",textMargin,48);
  text("Population Size: " + populationSize,textMargin,60);
  text("Avg. Time To Target Last Gen: " + avgTimeTaken,textMargin,72);
}