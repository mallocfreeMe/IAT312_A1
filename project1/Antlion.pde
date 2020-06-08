class  Antlion {
  float x,y,w,h,vx,vy;
  
  Antlion(float x, float y, float w, float h, float vx, float vy) {  
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.vx = vx;
    this.vy = vy;
  }
  void display() {
    fill(0);
    rect(x, y, w, h);
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
    display();
  }
}
