class Door {
  float x,y,w,h, vy;
  
  Door(float x, float y, float w, float h, float vy) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.vy = vy;
  }
  
  void display() {
    pushMatrix();
    translate(x-w/2, y-h/2);
    fill(45,180,110);
    rect(0,0,w,h);
    popMatrix();
  }
  
  void update(){
    y+=vy;
    display();
  }
}
