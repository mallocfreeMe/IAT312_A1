class Food{
  float w,h,x,y;
  //float halfWidth, halfHeight;

  Food(float x, float y, float w, float h){
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
  }

  void display(){
    pushMatrix();
    translate(x-w/2, y-h);
    fill(0, 255, 0);
    rect(0,0,w,h);
    popMatrix();
  }
}
