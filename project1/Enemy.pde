class Enemy{
  float w,h;
  PVector pos, vel;
  float angle = 0;
  
  PImage img1, img2, img3;

  Enemy(float x, float y, float w, float h, float vx, float vy){
    this.w = w;
    this.h = h;
    pos = new PVector(x, y);
    vel = new PVector(vx, vy);
    
    img1 = loadImage("img/swimingEnemyRight.png");
  }

  void display(){
    pushMatrix();
    translate(pos.x-w/2, pos.y-h/2);
    //fill(255, 255, 0);
    //rect(0,0,w,h);
    image(img1, 0, 0, w, h);
    popMatrix();
  }
  
  void update1() {
    pos.x += vel.x;
    if (pos.x-w/2 <= 0 || pos.x+w/2 >= width) {
      vel.x *= -1;    
    }
    pos.y += vel.y;
  }
  
  void update2(Player p) {
    angle = atan2(p.y- pos.y, p.x-pos.x); 
    PVector vel = PVector.fromAngle(angle);
    vel.mult(0.8);
    pos.add(vel);
  }
  
  
}
