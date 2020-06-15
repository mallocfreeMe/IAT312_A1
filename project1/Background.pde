class Background{
  float w,h,x,y;
  float vy;
  
  float o_x, o_y;
  
  PImage img1, img2, img3;

  Background(float x, float y, float w, float h, float vy){
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
    this.vy = vy;
    o_x = x;
    o_y = y;
    
    img1 = loadImage("img/dirt.png");
    img2 = loadImage("img/water.png");
    img3 = loadImage("img/icy_bg.png");
  }

  void display(){
    pushMatrix();
    translate(x, y);
    fill(128, 255, 0);
    //rect(0,0,w,h);
    image(img1,0,0,w,h);
    //fill(0,255, 255);
    //rect(0,-h,w,h);
    //image(img1,0,-h,w,h);
    //fill(128,255, 255);
    //rect(0,-2*h,w,h);
    //image(img1,0,-2*h,w,h);
    popMatrix();
  }
  
  void display2(){
    pushMatrix();
    translate(x, y);
    //fill(128, 255, 0);
    image(img2,0,0,w,h);
    popMatrix();
  }
  
  void display3(){
    pushMatrix();
    translate(x, y);
    //fill(128, 255, 0);
    image(img3,0,0,w,h);
    popMatrix();
  }
  
  void update(){
    //if(y < 1400) {
    //  y += vy;
    //}
    //if (y >= 1400) {
    //  vy = 0;
    //}
    //display();
  }
  
  void refresh() {
    x = o_x;
    y = o_y;
  }
}
