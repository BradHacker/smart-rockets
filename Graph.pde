class Graph {
  ArrayList<Integer> vals;
  int highestVal;
  int lowestVal;
  int avgVal;
  int lowestGen;
  int highestGen;
  
  float xinc;
  float yinc;
  
  int w, h;
  int margin = 10;
  
  Graph(int _w, int _h) {
    w = _w;
    h = _h;
    
    vals = new ArrayList<Integer>();
  }
  
  void display() {
    noStroke();
    fill(180,150);
    rect(0,height-(h+margin)-20,w+margin+20,h+margin+20);
    fill(255,150);
    rect(margin/2,height-(h+margin/2),w,h);
    
    pushMatrix();
    stroke(0);
    strokeWeight(1);
    translate(margin/2,height-margin/2);
    rotate(-PI/2);
    if(vals.size() > 1) {
      for(int i = 1; i < vals.size(); i++) {
        line((vals.get(i-1)-lowestVal)*yinc,(i-1)*xinc,(vals.get(i)-lowestVal)*yinc,i*xinc);
      }
    }
    popMatrix();
    
    fill(0);
    text(highestVal,margin+w,height-h-margin/2+12);
    text(lowestVal,margin+w,height-margin/2);
    text(lowestGen,margin/2,height-h-margin);
    text(highestGen,w,height-margin-h);
  }
  
  void update(int val) {
    vals.add(val);
    xinc = w;
    if(vals.size() > 1) xinc = w/(vals.size()-1);
    if(xinc < 10) {
      vals.remove(0);
      xinc = w/(vals.size()-1);
      lowestGen++;
    }
    for(int i = 0; i < vals.size(); i++) {
      if(i == 0) highestVal = vals.get(i);
      else {
        if(vals.get(i) > highestVal) {
          highestVal = vals.get(i);
        }
      }
    }
    for(int i = 0; i < vals.size(); i++) {
      if(i == 0) lowestVal = vals.get(i);
      else {
        if(vals.get(i) < lowestVal) {
          lowestVal = vals.get(i);
        }
      }
    }
    for(int i = 0; i < vals.size(); i++) {
      avgVal += vals.get(i);
    }
    
    if(highestVal > 0) yinc = h/(float(highestVal)-float(lowestVal));
    
    if(vals.size() < 2) {
      lowestGen = 1;
      highestGen = 1;
    } else {
      highestGen++;
    }
  }
}