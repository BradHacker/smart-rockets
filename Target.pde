class Target {
  PVector location;
  int size = 50;
  
  Target() {
    location = new PVector(int(random(size/2,width-(size/2))),int(random(size/2,200-size/2)));
  }
  
  void display() {
    stroke(0);
    fill(150);
    ellipse(location.x,location.y,size,size);
  }
}