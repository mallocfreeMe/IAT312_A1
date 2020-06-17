class Drop {

  float x = random(width);
  float y = random(-500, -50);
  float z = random(0, 20);
  float lenx = map(z, 0, 20, 3, 5);
  float leny = map(z, 0, 5, 5, 8);
  float vy = map(z, 0, 20, 1, 5);
  
  
  void fall() {
    y = y + vy;
    float grav = map(z, 0, 10, 0, 0.1);
    vy = vy + grav;
    
    if (y>height) {
      y = random(-200, -100);
      vy = map(z, 0, 20, 1, 4);
    }
    
  }
  
  void display() {
    fill(255);
    noStroke();
    //line(x,y,x,y+len);
    ellipse(x, y, lenx, leny);
  }
  
}
