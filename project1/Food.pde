class Food{
  float w,h,x,y,vy;
  //float halfWidth, halfHeight;
  
  PImage img1, img2;

  Food(float x, float y, float w, float h, float vy){
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
    this.vy = vy;
    
    img1 = loadImage("img/apple.png");
    img2 = loadImage("img/banana.png");
  }

  void display(){
    pushMatrix();
    translate(x-w/2, y-h);
    //fill(0, 255, 0);
    //rect(0,0,w,h);
    image(img1,0,0,w,h);
    popMatrix();
  }
  
  void update() {
    y += vy;
    display();
  }
}
