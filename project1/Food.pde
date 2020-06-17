class Food {
  float w, h, x, y, vx, vy;
  PImage img1, img2, img3;
  int ver;

  Food(float x, float y, float w, float h, float vx, float vy, int ver) {
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    this.ver = ver;

    img1 = loadImage("img/apple.png");
    img2 = loadImage("img/banana.png");
    img3 = loadImage("img/pear.png");
  }

  void display() {
    pushMatrix();
    translate(x-w/2, y-h);

    switch(ver) {
    case 1: 
      image(img1, 0, 0, w, h);
      break;
    case 2: 
      image(img2, 0, 0, w, h);
      break;
    case 3: 
      image(img3, 0, 0, w, h);
      break;
    }

    popMatrix();
  }

  void update() {
    x += vx;
    y += vy;
    display();

    if (x<=0 || x+w>=width) {
      vx *= -1;
    }
  }

  void update2() {
    x += vx;
    y += vy;
    display();

    if (x + 8*w < 0) {
      x = width - x;
    }
  }
}
