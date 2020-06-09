class Platform{
  float w,h,x,y,vy;
  float halfWidth, halfHeight;
  int version;
  
  PImage img1, img2, img3;

  Platform(float x, float y, float w, float h, float vy, int version){
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
    this.vy = vy;
    this.version = version;
    
    halfWidth = w/2;
    halfHeight = h/2;
    
    img1 = loadImage("img/rock1.png");
    img2 = loadImage("img/rock2.png");
    img3 = loadImage("img/rock3.png");
  }

  void display(){
    //stroke(0);
    //fill(255);
    //rect(x,y,w,h);
    //int r = (int)random(1,3);  
    switch(version) {
      case 1: 
        image(img1,x,y,w,h);
        break;
      case 2: 
        image(img2,x,y,w,h);
        break;
      case 3:
        image(img3,x,y,w,h);
        break;
    }
    //image(img1,x,y,w,h);
  }
  
  void update(){
    y += vy;
    display();
  }
}
