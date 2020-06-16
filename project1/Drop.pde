class Drop {

  float x = random(width);
  float y = random(-500, -50);
  float z = random(0, 20);
  float len = map(z, 0, 20, 10, 20);
  float vy = map(z, 0, 20, 1, 20);
  
  
  void fall() {
    y = y + vy;
    float grav = map(z, 0, 20, 0, 0.2);
    vy = vy + grav;
    
    if (y>height) {
      y = random(-200, -100);
      vy = map(z, 0, 20, 4, 10);
    }
    
  }
  
  void display() {
    stroke(135,206,235);
    line(x,y,x,y+len);
  }
  
}
