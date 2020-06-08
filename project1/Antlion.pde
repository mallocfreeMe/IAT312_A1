class  Antlion {
  PVector pos, vel;
  float w,h;
  
  Antlion(float x, float y, float w, float h, float vy) {  
    pos = new PVector(x, y);
    vel = new PVector(0, vy);
    this.w = w;
    this.h = h;
  }
  void display() {
    fill(0);
    rect(0, 600, w, h);
  }
  void update() { 
    //pos.add(vel);
    if(isAttack == true) {
      pos.y -= 100;
    }
    else {
      pos.y = 0;
    }
    display();
  }
}
