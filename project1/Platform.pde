class Platform{
  float w,h,x,y;
  float halfWidth, halfHeight;

  Platform(float x, float y, float w, float h){
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;

    halfWidth = w/2;
    halfHeight = h/2;
  }

  void display(){
    stroke(0);
    fill(255);
    rect(x,y,w,h);
  }
}
