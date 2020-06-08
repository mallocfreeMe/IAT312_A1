class  Antlion {
  PVector pos, vel;
  float angle = 0;
  
  Antlion() {  
    pos = new PVector(400, 500);
  }
  void display() {
    fill(0);
    rect(pos.x-50, pos.y-50, 100, 100);
  }
  void update(Player p) { 
    display();
    angle = atan2(p.y- pos.y, p.x-pos.x); 
    PVector vel = PVector.fromAngle(angle);
    vel.mult(1);
    pos.add(vel);
  }
}
