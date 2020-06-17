class Heart {

  float w,h,x,y;
  
  PImage img;
  
  Heart(float x, float y, float w, float h){
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
    
    img = loadImage("img/health.png");
  }

  void display(){
    pushMatrix();
    translate(x, y);
    image(img, -w/2, -h/2, w, h);
    popMatrix();
  }

}
