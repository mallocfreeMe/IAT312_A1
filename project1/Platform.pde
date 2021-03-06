class Platform {
  float w, h, x, y, vx, vy;
  float halfWidth, halfHeight;
  int version;

  PImage img1, img2, img3, img4, img5, img6, img7, img8;

  Platform(float x, float y, float w, float h, float vx, float vy, int version) {
    //>>>>>>> Stashed changes
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    this.version = version;

    halfWidth = w/2;
    halfHeight = h/2;

    img1 = loadImage("img/rock1.png");
    img2 = loadImage("img/rock2.png");
    img3 = loadImage("img/rock3.png");
    img4 = loadImage("img/level2_channel.png");
    img5 = loadImage("img/ice platform 1.png");
    img6 = loadImage("img/ice platform 2.png");
    img7 = loadImage("img/ice platform 3.png");
    img8 = loadImage("img/turtle.png");
  }

  void display() {
    switch(version) {

    case 1: 
      image(img1, x, y, w, h);
      break;
    case 2: 
      image(img2, x, y, w, h);
      break;
    case 3:
      image(img3, x, y, w, h);
      break;
    case 4:
      image(img4, x, y, w, h);
      break;
    case 5:
      image(img5, x, y, w, h);
      break;
    case 6:
      image(img6, x, y, w, h);
      break;
    case 7:
      image(img7, x, y, w, h);
      break;
    case 8:
      image(img8, x, y, w, h);
      break;
    }
  }

  // out of screen
  void update() {
    x += vx;
    y += vy;
    display();
  }
  
  // bounce back
  void update2() {
    x += vx;
    y += vy;
    display();

    if (x<=0 || x+w>=width) {
      vx *= -1;
    }
  }
  
  // go from another direction
  void update3() {
    x += vx;
    y += vy;
    display();
    
    if(x + w < 0) {
      x = width - x; 
    }
  }
}
