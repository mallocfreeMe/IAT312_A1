class Background{
  float w,h,x,y;
  float vy;

  Background(float x, float y, float w, float h, float vy){
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
    this.vy = vy;
  }

  void display(){
    pushMatrix();
    translate(x, y);
    fill(128, 255, 0);
    rect(0,0,w,h);
    fill(0,255, 255);
    rect(0,-h,w,h);
    popMatrix();
  }
  
  void update(){
    y += vy;
    display();
  }
}
