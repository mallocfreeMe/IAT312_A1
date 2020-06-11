class  Antlion {
  float x,y,w,h,vx,vy;
  
  PImage img;
  
  Antlion(float x, float y, float w, float h, float vx, float vy) {  
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.vx = vx;
    this.vy = vy;
    
    img = loadImage("img/antlion.png");
  }
  void display() {
    //fill(0);
    //rect(x, y, w, h);
    image(img,x,y,w,h);
  }
  void update() { 
    //y += vy;
    //if(isAttack == true) {
    //  if (isBack == false) {
    //    println("Attack Time");
    //    vy = -5;
    //  }
    //  else {
    //    vy = 5;
    //  }
      
    //}
    //else { 
    //  vy = 0;
    //}
    y+=vy;
    x+=vx;
    display();
  }
}
