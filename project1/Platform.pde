class Platform{
  float w,h,x,y,vy;
  float halfWidth, halfHeight;

  Platform(float x, float y, float w, float h, float vy){
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
    this.vy = vy;
    
    halfWidth = w/2;
    halfHeight = h/2;
  }

  void display(){
    stroke(0);
    fill(255);
    rect(x,y,w,h);
  }
  
  void update(){
    y += vy;
    display();
  }
}
