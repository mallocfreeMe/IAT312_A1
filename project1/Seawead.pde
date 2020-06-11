class Seawead{
  float w,h,x,y;
  
  PImage img;
  
  Seawead(float x, float y, float w, float h){
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
    
    img = loadImage("img/obsticle.png");
  }

  void display(){
    pushMatrix();
    translate(x, y);
    //fill(0, 128, 0);
    //ellipse(0,0,w,h);
    image(img, -w/2, -h/2, w, h);
    popMatrix();
  }
}
