class Player {  
  float w, h, x, y, vx, vy, 
    accX, accY, 
    speedLimit, friction, bounce, gravity, gravity2;
  boolean isOnGround;
  boolean isOnScreenBottom;
  float jumpForce;
  float halfWidth, halfHeight;
  int currentFrame;
  String collisionSide;
  boolean facingRight;
  int frameSequence;
  PImage img;
  int health;
  boolean invisible;
  int startTime;
  int timeOut;
  int count;


  Player(float x, float y, float w, float h, float vx, float vy) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.vx = vx;
    this.vy = vy;
    accX = 0;
    accY = 0;
    speedLimit = 5;
    friction = 0.96;
    bounce = -0.7;
    gravity = 3;
    gravity2 = 0.2;
    isOnGround = false;
    isOnScreenBottom = false;
    jumpForce = -10;
    health = 3;
    invisible = false;

    halfWidth = w/2;
    halfHeight = h/2;

    currentFrame = 0;
    collisionSide = "";
    frameSequence = 6;

    img = loadImage("img/playerRight.png");
  }

  // --------------- For the LEVEL 1 & 3
  void update() {
    if (left) {
      accX = -0.1;
      friction = 1;
      facingRight = false;
    }
    if (right) {
      accX = 0.1;
      friction = 1;
      facingRight = true;
    }
    if (!left&&!right) {
      accX = 0;
      friction = 0.96;
      gravity = 0.3;
    } else if (left&&right) {
      // vx=0;
      accX = 0;
      friction = 0.96;
      gravity = 0.3;
    }
    if (up && isOnGround) {
      vy += jumpForce;
      isOnGround = false;
      friction = 0.5;
      //isOver=true;
    }

    vx += accX;
    vy += accY;

    // apply the forces
    if (isOnGround) {
      vx *= friction;
    }
    vy += gravity;

    // correct for maximum speeds
    if (vx > speedLimit) {
      vx = speedLimit;
    }
    if (vx < -speedLimit) {
      vx = -speedLimit;
    }
    if (vy > speedLimit * 2) {
      vy = speedLimit;
    }


    // --------------------------- Player die when he touch the bottom ------------------------------------   
    if (h + y <= h) {
      isOver = true;
    }

    // ------------------------------------------------------------------------------------------------------


    ////move the player
    x+=vx;
    y+=vy;
  }

  void checkPlatforms() {
    ////update for platform collisions
    if (collisionSide == "bottom" && vy >= 0) {
      isOnGround = true;
      ////flip gravity to neutralize gravity's effect
      vy = -1;
    } else if (collisionSide == "top" && vy <= 0) {
      vy = 0;
    } else if (collisionSide == "right" && vx >= 0) {
      vx = 0;
    } else if (collisionSide == "left" && vx <= 0) {
      vx = 0;
    }
    if (collisionSide != "bottom" && vy > 0) {
      isOnGround = false;
    }
  }


  void checkBoundaries() {
    if (x < -w) {
      x = width;
    }
    if (x  > width) {
      x = -w;
    }
    ////top
    if (y < 0) {
      // vy *= bounce;
      // y = 0;
    }
    // fall into the groud, character will just die
    if (y + h > height) {
      y = height - h;
      isOver = true;
      isOnGround = true;
      vy = -gravity;
    }
  }


  void display() {
    image(img, x, y, w, h);

    if (abs(vx)>1 && isOnGround) {
      currentFrame = (currentFrame+1)%frameSequence;
    } else {
      currentFrame = 0;
    }
  }

  // ------------- The end of LEVEL 1 & 3



  // ------------- For the LEVEL 2

  void display2() {
    image(img, x, y, w, h);
  }

  void fall() {
    vy += gravity2;
    y += vy;
    x += vx;
  }

  void jump() {
    if (keyPressed) {
      if (keyCode == UP) {
        vy = -1;
      }
      if (keyCode == RIGHT) {
        vx = 0.5;
      }
      if (keyCode == LEFT) {
        vx = -0.5;
      }
    }
  }

  void jump2() {
    if (keyPressed) {
      if (keyCode == UP) {
        vy = -5;
      }
      if (keyCode == RIGHT) {
        vx = 2;
      }
      if (keyCode == LEFT) {
        vx = -2;
      }
    }
  }

  void update2() {
    display2();
    fall();
    jump();
  }

  void update3() {
    display2();
    fall();
    jump2();
  }

  // ------------- The end of LEVEL 2
}
