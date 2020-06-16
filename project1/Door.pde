class Door {
  float x,y,w,h, vy;
  int ver;
  PImage img1, img2;
  
  Door(float x, float y, float w, float h, float vy, int ver) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.vy = vy;
    this.ver = ver;
    
    img1 = loadImage("img/closeDoor.png");
    img2 = loadImage("img/openDoor.png");
  }
  
  void display() {
    pushMatrix();
    translate(x-w/2, y-h/2);
    
    switch(ver) {
      case 1: 
        image(img1, 0, 0, w, h);
        break;
      case 2: 
        image(img2, 0, 0, w, h);
        break;
    }

    popMatrix();
  }
  
  void update(){
    y+=vy;
    display();
  }
}
