class Background{
  float w,h,x,y;
  float vy;
  
  PImage img1;

  Background(float x, float y, float w, float h, float vy){
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
    this.vy = vy;
    
    img1 = loadImage("img/dirt.png");
  }

  void display(){
    pushMatrix();
    translate(x, y);
    //fill(128, 255, 0);
    //rect(0,0,w,h);
    image(img1,0,0,w,h);
    //fill(0,255, 255);
    //rect(0,-h,w,h);
    image(img1,0,-h,w,h);
    //fill(128,255, 255);
    //rect(0,-2*h,w,h);
    image(img1,0,-2*h,w,h);
    popMatrix();
  }
  
  void update(){
    if(y < 1400) {
      y += vy;
    }
    if (y >= 1400) {
      vy = 0;
    }
    display();
  }
}
