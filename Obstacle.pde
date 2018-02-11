class Obstacle {
  PVector location;
  float w,h;
  
  Obstacle(PVector l, float wi, float he) {
    location = l;
    w = wi;
    h = he;
  }
  
  boolean contains(PVector v) {
    if(v.x > location.x && v.x < location.x + w && v.y > location.y && v.y < location.y + h) {
      return true;
    } else {
      return false;
    }
  }
  
  void display() {
    fill(100);
    stroke(100);
    rect(location.x,location.y,w,h);
  }
}