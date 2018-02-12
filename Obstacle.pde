class Obstacle {
  PVector location;
  float w,h;
  
  Obstacle(PVector l, float wi, float he) {
    location = l;
    w = wi;
    h = he;
  }
  
  boolean contains(PVector v, int size) {
    if(v.x + size/2 > location.x && v.x - size/2 < location.x + w && v.y + size/2 > location.y && v.y - size/2 < location.y + h) {
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