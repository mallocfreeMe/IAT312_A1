import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import processing.serial.*;

import controlP5.*;

// menu page widgets
Button startButton;
Button exitButton;

Button musicButton;
Minim minim;
AudioPlayer song;
boolean playBackgroundMusic =false;

PImage titleImage;
PImage backgroundImage;

// game over widgets
Button playAgainButton;
Button backButton;

PImage overImage;
PImage lostImage;

ControlP5 cp5;

Player player, player2, player3;
ArrayList<Platform> platforms, platforms3;
ArrayList<Food> foods, foods2, foods3;
Antlion antlion;
ArrayList<Enemy> enemies1;
ArrayList<Enemy> enemies2;
ArrayList<Seawead> seaweads;
Background bg;
Door door;

// Score
int foodNum = 0;

// Level
boolean isPlaying = false;
boolean isOver = false;

int L_OVER = -2;
int L_SELECT = -1;
int L_MENU = 0;
int L_ONE = 1;
int L_TWO = 2;
int L_THREE = 3;

int level = L_MENU;

boolean left, right, up;
boolean isAttack = false;
boolean isBack = false;

// Timer
int attackTimer=0;

void setup() {
  size(1080, 700);

  cp5 = new ControlP5(this);
  smooth();

  ControlFont cf1 = new ControlFont(createFont("Arial", 20));

  // set up the start button
  startButton = cp5.addButton("Start")
    .setPosition(370, 580)
    .setColorActive(color(100)) 
    .setColorLabel(color(0))
    .setColorBackground(color(255))
    .setColorForeground(color(255, 0, 0))
    .setSize(130, 25)
    .setFont(cf1);

  // set up the exit button
  exitButton = cp5.addButton("Exit")
    .setPosition(570, 580)
    .setColorActive(color(100)) 
    .setColorLabel(color(0))
    .setColorBackground(color(255))
    .setColorForeground(color(255, 0, 0))
    .setSize(130, 25)
    .setFont(cf1);

  // set music button
  musicButton = cp5.addButton("sound")
    .setColorActive(color(100)) 
    .setColorLabel(color(0))
    .setColorBackground(color(255))
    .setColorForeground(color(255, 0, 0))
    .setImages()
    .setPosition(50, 30);

  // Use Minim library
  minim = new Minim(this);
  song = minim.loadFile("sound/background.mp3");

  titleImage= loadImage("img/title.png");
  titleImage.resize(350, 200);

  backgroundImage = loadImage("img/menu.png");
  backgroundImage.resize(320, 300);

  // set playAgainButton
  playAgainButton = cp5.addButton("play again")
    .setPosition(370, 580)
    .setSize(130, 25)
    .setColorActive(color(100)) 
    .setColorLabel(color(0))
    .setColorBackground(color(255))
    .setColorForeground(color(255, 0, 0))
    .setImages()
    .setFont(cf1)
    .hide();

  // set backButton
  backButton = cp5.addButton("back")
    .setPosition(570, 580)
    .setSize(130, 25)
    .setColorActive(color(100)) 
    .setColorLabel(color(0))
    .setColorBackground(color(255))
    .setColorForeground(color(255, 0, 0))
    .setImages()
    .setFont(cf1)
    .hide();

  // set over image and lost image
  overImage=loadImage("img/over.png");
  overImage.resize(200, 200);

  lostImage=loadImage("img/lost.png");
  lostImage.resize(320, 300);

  // initialize player
  player = new Player(200, 300, 50, 50, 0, 0);
  player2 = new Player(50, 350, 50, 50, 0, 0);
  player3 = new Player(50, 600, 50, 50, 0, 0);

  // initialize platforms
  platforms = new ArrayList<Platform>();
  //for (int i=-1400; i<600; i=i+150){
  //  float randpx = random(4) * 100;
  //  float randpx2 = random(5,10) *100;
  //  platforms.add(new Platform(randpx, i, 200, 25, 0.25));
  //  platforms.add(new Platform(randpx2, i, 200, 25, 0.25));
  //}
  //platforms.add(new Platform(300, 1000, 200, 25));
  //platforms.add(new Platform(500, 900, 200, 25));
  //platforms.add(new Platform(800, 800, 200, 25));
  //platforms.add(new Platform(500, 700, 200, 25));
  platforms.add(new Platform(200, 400, 200, 25, 0.25));
  platforms.add(new Platform(300, 600, 200, 25, 0.25));
  platforms.add(new Platform(500, 500, 200, 25, 0.25));
  platforms.add(new Platform(800, 400, 200, 25, 0.25));
  platforms.add(new Platform(500, 300, 200, 25, 0.25));
  platforms.add(new Platform(700, 200, 200, 25, 0.25));
  platforms.add(new Platform(300, 100, 200, 25, 0.25));
  platforms.add(new Platform(650, 0, 200, 25, 0.25));
  platforms.add(new Platform(800, -100, 200, 25, 0.25));
  platforms.add(new Platform(500, -200, 200, 25, 0.25));
  platforms.add(new Platform(100, -300, 200, 25, 0.25));
  platforms.add(new Platform(450, -400, 200, 25, 0.25));
  platforms.add(new Platform(100, -500, 200, 25, 0.25));
  platforms.add(new Platform(500, -600, 200, 25, 0.25));
  platforms.add(new Platform(650, -700, 200, 25, 0.25));
  platforms.add(new Platform(700, -800, 200, 25, 0.25));
  platforms.add(new Platform(300, -900, 200, 25, 0.25));
  platforms.add(new Platform(0, -1000, 200, 25, 0.25));
  platforms.add(new Platform(300, -1100, 200, 25, 0.25));
  platforms.add(new Platform(500, -1200, 200, 25, 0.25));


  platforms3 = new ArrayList<Platform>();
  platforms3.add(new Platform(500, 550, 200, 25, 0.3));
  platforms3.add(new Platform(250, 400, 200, 25, 0.3));
  platforms3.add(new Platform(750, 400, 200, 25, 0.3));
  platforms3.add(new Platform(500, 250, 200, 25, 0.3));

  //initialize food
  foods = new ArrayList<Food>();
  //foods.add(new Food(550, 900, 25, 25));
  //foods.add(new Food(350, 1000, 25, 25));
  foods.add(new Food(350, 600, 25, 25, 0.25));
  foods.add(new Food(550, 500, 25, 25, 0.25));
  foods.add(new Food(850, 400, 25, 25, 0.25));
  foods.add(new Food(550, 300, 25, 25, 0.25));

  foods2 = new ArrayList<Food>();
  for (int i = 0; i < 8; i++) {
    float rx = random(1080);
    float ry = random(700);
    foods2.add(new Food(rx, ry, 25, 25, 0));
  }

  // initiallize antlion
  antlion = new Antlion(300,600,500,500,0,0);


  // initialize enemy
  enemies1 = new ArrayList<Enemy>();
  enemies1.add(new Enemy(100, 550, 50, 50, 2.5, 0));
  enemies1.add(new Enemy(800, 350, 50, 50, -3, 0));
  enemies1.add(new Enemy(100, 150, 50, 50, 5, 0));

  enemies2 = new ArrayList<Enemy>();
  enemies2.add(new Enemy(100, 100, 50, 50, 0, 0));
  enemies2.add(new Enemy(800, 600, 50, 50, 0, 0));


  // initialize seawead
  seaweads = new ArrayList<Seawead>();
  for (int i = 0; i < 3; i++) {
    float rx = random(1080);
    float ry = random(700);
    seaweads.add(new Seawead(rx, ry, 75, 75));
  }


  // initialize background
  bg = new Background(0, 0, width, height, 0.25);


  // initialize boolean variables
  left = false;
  right = false;
  up = false;
}


void draw() {
  levelCheck();

  // Attack timer
  attackTimer ++;
  if (attackTimer >= 600) {
    isAttack = true;
    isBack = false;
  }
  if(attackTimer >= 660){
    isAttack = true;
  }
  if (attackTimer >= 720) {
    isAttack = false;
    isBack = true;
    attackTimer = 0;
  }

  // ---------------- Menu --------------------
  if (level == L_MENU) {
    color menuColor = color(#9B8F93);
    background(menuColor);
    image( titleImage, 360, 20);
    image(backgroundImage, 380, 200);

    playAgainButton.hide();
    backButton.hide();
    startButton.show();
    exitButton.show();
    musicButton.show();
  } else {
    musicButton.hide();
    startButton.hide();
    exitButton.hide();
  }

  // ---------------- LEVEL 1 --------------------
  if (level == L_ONE) {
    background(255);
    bg.update();
    //door.update();
    setText();
    player.update();

    // Check the collision of player and platform & DIsplay the platform
    for (int i = 0; i < platforms.size(); i++) {
      Platform p = platforms.get(i);
      p.update();

      rectangleCollisions(player, p);
      player.checkPlatforms();
    }

    // Display the foods
    for (int i=0; i<foods.size(); i++) {
      Food f = foods.get(i);
      f.update();

      boolean foodCollision = collectCollision(player, f);
      if (foodCollision) {
        foodNum++;
        foods.remove(i);
      }
    }

    // Display the enemies
    for (int i=0; i<enemies1.size(); i++) {
      Enemy e = enemies1.get(i);
      e.display();
      e.update1();

      boolean enemyCollision = enemyCollision(player, e);
      if (enemyCollision) {
        isOver = true;
      }
    }

    // Display antlion
    antlion.update();
    boolean bossCollision = bossCollision(player, antlion);
      if (bossCollision) {
        isOver = true;
      }



    // Check the boundaries
    player.checkBoundaries();

    // Display
    player.display();
  }

  // --------------- LEVEL 2 -------------------

  if (level == L_TWO) {
    background(135, 206, 235);
    setText();
    player2.update2();

    for (int i=0; i<foods2.size(); i++) {
      Food f = foods2.get(i);
      f.update();

      boolean foodCollision = collectCollision(player2, f);
      if (foodCollision) {
        foodNum++;
        foods2.remove(i);
      }
    }

    // Display the enemies
    for (int i=0; i<enemies2.size(); i++) {
      Enemy e = enemies2.get(i);
      e.display();
      e.update2(player2);

      boolean enemyCollision = enemyCollision(player2, e);
      if (enemyCollision) {
        isOver =true;
      }
    }


    // Display the seaweads
    for (int i=0; i<seaweads.size(); i++) {
      Seawead s = seaweads.get(i);
      s.display();

      boolean seaweadCollision = seaweadCollision(player2, s);
      if (seaweadCollision) {
        float speedLimit = 0.8;
        player2.vx *= speedLimit;
        player2.vy *= speedLimit;
        println("You are caught by seaweed!!");
      }
    }
  }


  // --------------- LEVEL 3 -------------------
  if (level == L_THREE) {
    background(255, 204, 203);
    setText();
    player3.update();
    player3.display();

    // Check the collision of player and platform & DIsplay the platform
    for (int i = 0; i < platforms3.size(); i++) {
      Platform p = platforms3.get(i);
      p.update();

      rectangleCollisions(player3, p);
      player3.checkPlatforms();
    }


    // Check the boundaries
    player3.checkBoundaries();
  }

  // --------------- LEVEL OVER -------------------
  if (level == L_OVER) {
    color menuColor = color(#9B8F93);
    background(menuColor);
    playAgainButton.show();
    backButton.show();

    image(lostImage, 400, 20);
    image(overImage, 420, 280);
  }
}


void keyPressed() {
  switch (keyCode) {
  case 37:
    left = true;
    break;
  case 39:
    right = true;
    break;
  case 38:
    up = true;
    break;
  }
}


void keyReleased() {
  switch (keyCode) {
  case 37:
    left = false;
    break;
  case 39:
    right = false;
    break;
  case 38:
    up = false;
    break;
  }
}

void rectangleCollisions(Player p1, Platform p2) {
  float dx = (p1.x+p1.w/2) - (p2.x+p2.w/2);
  float dy = (p1.y+p1.h/2) - (p2.y+p2.h/2);

  float combinedHalfWidths = p1.halfWidth + p2.halfWidth;
  float combinedHalfHeights = p1.halfHeight + p2.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    if (abs(dy) < combinedHalfHeights) {
      float overlapX = combinedHalfWidths - abs(dx);
      float overlapY = combinedHalfHeights - abs(dy);
      if (overlapX >= overlapY) {
        if (dy > 0) {
          p1.collisionSide = "top";
          p1.y += overlapY;
        } else {
          p1.collisionSide = "bottom";
          p1.y -= overlapY;
        }
      } else {
        if (dx > 0) {
          p1.collisionSide = "left";
          p1.x += overlapX;
        } else {
          p1.collisionSide = "right";
          p1.x -= overlapX;
        }
      }
    } else {
      p1.collisionSide = "none";
    }
  } else {
    p1.collisionSide = "none";
  }
}


Boolean collectCollision(Player cp, Food cf) {
  float player_x_left = (cf.x-cf.w/2)-(cp.x+cp.w);
  float player_x_right = (cp.x)-(cf.x+cf.w/2);
  float player_y_top = (cf.y-cf.h/2)-(cp.y+cp.h);
  float player_y_bottom = (cp.y) - (cf.y+cf.h/2);

  if (player_x_left <= 0 && player_x_right <= 0 && player_y_top <=0 && player_y_bottom <=0) {
    return true;
  }
  return false;
}

Boolean enemyCollision(Player ep, Enemy ee) {
  float player_x_left = (ee.pos.x-ee.w/2)-(ep.x+ep.w);
  float player_x_right = (ep.x)-(ee.pos.x+ee.w/2);
  float player_y_top = (ee.pos.y-ee.h/2)-(ep.y+ep.h);
  float player_y_bottom = (ep.y) - (ee.pos.y+ee.h/2);

  if (player_x_left <= 0 && player_x_right <= 0 && player_y_top <=0 && player_y_bottom <=0) {
    return true;
  }
  return false;
}

Boolean bossCollision(Player bp, Antlion bb) {
  float player_x_left = (bb.x)-(bp.x+bp.w);
  float player_x_right = (bp.x)-(bb.x+bb.w);
  float player_y_top = (bb.y)-(bp.y+bp.h);
  float player_y_bottom = (bp.y) - (bb.y+bb.h);

  if (player_x_left <= 0 && player_x_right <= 0 && player_y_top <=0 && player_y_bottom <=0) {
    return true;
  }
  return false;
}


Boolean doorCollision(Player dp, Door dd) {
  float player_x_left = (dd.x-dd.w/2)-(dp.x+dp.w);
  float player_x_right = (dp.x)-(dd.x+dd.w/2);
  float player_y_top = (dd.y-dd.h/2)-(dp.y+dp.h);
  float player_y_bottom = (dp.y) - (dd.y+dd.h/2);

  if (player_x_left <= 0 && player_x_right <= 0 && player_y_top <=0 && player_y_bottom <=0) {
    return true;
  }
  return false;
}


Boolean seaweadCollision(Player sp, Seawead ss) {
  float disx = abs((sp.x+sp.w/2)-(ss.x));
  float disy = abs((sp.y+sp.h/2)-(ss.y));
  float sumx = sp.w/2 + ss.w/2;
  float sumy = sp.h/2 + ss.h/2;

  if (disx<=sumx && disy<=sumy) {
    return true;
  }
  return false;
}


void setText() {
  String s = "FOOD:  " + foodNum;
  String s2 = "LEVEL:  " + level;
  if (level == L_TWO) {
    String s3 = "Keep jumping and don't fall";
    textSize(18);
    fill(255);
    text(s3, 400, 30);
  }
  textSize(24);
  fill(0);
  text(s, 900, 30);
  text(s2, 30, 30);
}

void levelCheck() {
  if (!isPlaying) {
    level = L_MENU;
  } else {
    if (!isOver) {
      level = L_ONE;

      if (foodNum >= 3 && player.y < 0 && level == L_ONE) {
        foodNum = 0;
        level = L_TWO;
      }

      if (foodNum >= 5 && player2.x+player2.w > width && level == L_TWO) {
        foodNum = 0;
        level = L_THREE;
      }
    } else {
      level = L_OVER;
    }
  }
}

// callback function from ControlP5 library
// it triggers whenever there is a CallbackEvent is happening
void controlEvent(CallbackEvent event) {
  // if the there is click event for the ControlP5 widgets 
  if (event.getAction() == ControlP5.ACTION_CLICK) {
    // switch the Controller name based on their adress in the memory
    switch(event.getController().getAddress()) {

      // If the play button is pressed
    case "/Start":
      isPlaying = true;
      break;

      // If the exit button is pressed
    case "/Exit":
      isPlaying = false;
      exit();
      break;

      // if the music button is pressed
      // it will play the music
      // if the music button is pressed again
      // stop the music
      // the button will loop the conditions I describe above 
    case "/sound":
      if (playBackgroundMusic) {
        playBackgroundMusic=false;
      } else {
        playBackgroundMusic=true;
      }
      if (playBackgroundMusic) {
        song.rewind();
        song.play();
      } else {
        song.pause();
      }
      break;
    case "/play again":
      isOver = false;
      backButton.hide();
      playAgainButton.hide();
      player.x = 50;
      player.y = 600;
      break;
    case "/back":
      isOver = false;
      isPlaying = false;
      break;
    }
  }
}
