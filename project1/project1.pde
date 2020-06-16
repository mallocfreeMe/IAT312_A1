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

// game won widgets
PImage winTitleImage;
PImage winImage;


ControlP5 cp5;

Player player, player2, player3;
ArrayList<Platform> platforms, platforms2, platforms3;
Platform channel2;
ArrayList<Food> foods, foods2, foods3;
Antlion antlion;
ArrayList<Enemy> enemies1;
ArrayList<Enemy> enemies2;
ArrayList<Enemy> enemies3;
//ArrayList<Seawead> seaweads;
Background bg, bg2, bg3;
Door door;
Door door2;
Door door3;

// Score
int foodNum = 0;

// Level

int L_OVER = -2;
int L_SELECT = -1;
int L_MENU = 0;
int L_ONE = 1;
int L_TWO = 2;
int L_THREE = 3;
int L_WIN = 4;

// stories screen
int L_1_1= 5;
int L_1_2= 6;
int L_1_3= 7;
int L_2_1= 8;
int L_3_1 = 9;

PImage story_1_1;
PImage story_1_2;
PImage story_1_3;
PImage story_2_1;
PImage story_3_1;

Button nextButton;


// set level
boolean isPlaying = true;
// first story
boolean isStory = false;
// second story
boolean isInstruction = false;
// first inst
boolean isInstruction3 = false;
// first level
boolean isInstruction2 = false;
// second level ins
boolean isInstruction4 = false;
// second level
boolean isInstruction5 = false;

boolean isOver = false;
boolean isFinished = false;
boolean isTouchDoor = false;
<<<<<<< HEAD
boolean isDoorOpen = false;
int level = L_MENU;
=======

// Check bottom touch enemies
boolean isBottomTouch = false;

int level = L_TWO;
>>>>>>> 50d12d5ed2c1736f0a4b1343c99c791784946935
int resetLevel;



boolean left, right, up;
boolean isAttack = false;
boolean isBack = false;

// Timer
int attackTimer=0;


// Platform version
int pversion, pversion2, pversion3, pversion4;

//Drop
Drop[] drops = new Drop[100];

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


  // set up the next button
  nextButton = cp5.addButton("Next")
    .setPosition(500, 580)
    .setColorActive(color(100)) 
    .setColorLabel(color(0))
    .setColorBackground(color(255))
    .setColorForeground(color(255, 0, 0))
    .setSize(130, 25)
    .hide()
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

  winTitleImage=loadImage("img/win_title.png");
  winImage=loadImage("img/win.png");


  // load stories and instuctions
  story_1_1 = loadImage("img/1-1.png");
  story_1_2 = loadImage("img/1-2.png");
  story_1_3 = loadImage("img/1-3.png");
  story_2_1 = loadImage("img/2-1.png");
  story_3_1 = loadImage("img/3-1.png");


  // random initialize platforms for level 2
  pversion = (int)random(1, 3);
  pversion2 = (int)random(1, 3);
  pversion3 = (int)random(5, 7);
  pversion4 = (int)random(5, 7);

  platforms = new ArrayList<Platform>();
  platforms2 = new ArrayList<Platform>();


  // initialize player
  player = new Player(300, 500, 50, 50, 0, 0);

  //initialize food
  foods = new ArrayList<Food>();
  // level one 

  generateLevel1();

  // level 2
  generateLevel2();

  // level 3
  generateLevel3();

  // initialize background
  bg = new Background(0, 0, 1080, height, 0.2);
  bg.display();
  bg2 = new Background(0, 0, 1080, height, 0.2);
  bg3 = new Background(0, 0, 1080, height, 0.2);


  // initialize boolean variables
  left = false;
  right = false;
  up = false;


  // initialize the drops
  for (int i=0; i<drops.length; i++) {
    drops[i] = new Drop();
  }
}


void draw() {
  levelCheck();

  //Attack timer
  attackTimer ++;

  // level 1_1
  if (level == L_1_1) {
    nextButton.show();
    color menuColor = color(#9B8F93);
    background(menuColor);
    image(story_1_1, 320, 150);
  }

  if (level == L_1_2) {
    nextButton.show();
    color menuColor = color(#9B8F93);
    background(menuColor);
    image(story_1_2, 320, 150);
  }

  if (level == L_1_3) {
    nextButton.show();
    color menuColor = color(#9B8F93);
    background(menuColor);
    image(story_1_3, 200, 50, width/1.5, height/1.5);
  }

  // ---------------- LEVEL 1 --------------------
  if (level == L_ONE) {
    nextButton.hide();
    bg2.display2();
    setText();

    // check food is collected or not
    if (foods2.size() == 4) {
      door2.ver = 2;
      isDoorOpen = true;
    } else {
      door2.ver = 1;
      isDoorOpen = false;
    }

    door2.update();
    channel2.update();
    player2.update3();
    rectangleCollisions(player2, channel2);
    player2.checkPlatforms();

    // Check the boundaries
    player2.checkBoundaries();

    for (int i=0; i<foods2.size(); i++) {
      Food f = foods2.get(i);
      f.update();

      boolean foodCollision = collectCollision(player2, f);
      if (foodCollision) {
        foodNum++;
        foods2.remove(i);
      }
    }

    // check game is over or not
    if (player2.health == 0) {
      isOver =true;
    }

    // Check the player touch the door
    boolean doorCollision = doorCollision(player2, door2);
    if (doorCollision) {
      if (isDoorOpen) {
        isTouchDoor = true;
      } else {
        isTouchDoor = false;
      }
    }

    // Check the collision of player and platform & DIsplay the platform
    for (int i = 0; i < platforms2.size(); i++) {
      Platform p = platforms2.get(i);
      p.update();

      rectangleCollisions(player2, p);
      player2.checkPlatforms();
    }
  }

  // --------------- LEVEL 2.1 -------------------
  if (level == L_2_1) {
    nextButton.show();
    color menuColor = color(#9B8F93);
    background(menuColor);
    image(story_2_1, 200, 50, width/1.5, height/1.5);
  }

  // --------------- LEVEL 2 -------------------

  if (level == L_TWO) {
    nextButton.hide();
    bg.display();
    door.update();
    player.update();

    // Check the collision of player and platform & DIsplay the platform
    for (int i = 0; i < platforms.size(); i++) {
      Platform p = platforms.get(i);
      p.update2();

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

    // Check the player touch the door
    boolean doorCollision = doorCollision(player, door);
    if (doorCollision) {
      if (isDoorOpen) {
        isTouchDoor = true;
      }
    }


    // Display the enemies
    for (int i=0; i<enemies1.size(); i++) {
      Enemy e = enemies1.get(i);
      e.display();
      e.update1();

      boolean enemyCollision = enemyCollision(player, e);
      if (enemyCollision) {
        player.health--;
        println("Hit by enemy and Lose Health in Level 2");
      }
      if (isBottomTouch) {
        println("hit");
        enemies1.remove(i);
        isBottomTouch = false;
      }
    }


    // Check the boundaries
    player.checkBoundaries();

    // Display
    player.display();
    setText();
  }

  // --------------- LEVEL 3.1 -------------------
  if (level == L_3_1) {
    nextButton.show();
    color menuColor = color(#9B8F93);
    background(menuColor);
    image(story_3_1, 200, 50, width/1.5, height/1.5);
  }

  // --------------- LEVEL 3 -------------------
  if (level == L_THREE) {
    nextButton.hide();
    bg3.display3();
    setText();
    door3.update();
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



    // Check the player touch the door
    boolean doorCollision = doorCollision(player3, door3);
    if (doorCollision) {
      if (isDoorOpen) {
        isTouchDoor = true;
      }
    }


    //Display Antlion

    antlion.update();
    //println(attackTimer);
    if (attackTimer >=100 && attackTimer < 150) {
      antlion.y += -3;
    }
    if (attackTimer >=150 && attackTimer <200) {
      antlion.y += 3;
    }
    if (attackTimer >=200) {
      attackTimer = 0;
    }

    boolean bossCollision = bossCollision(player3, antlion);
    if (bossCollision) {
      player3.health--;
    }

    // Display the enemies
    for (int i=0; i<enemies3.size(); i++) {
      Enemy e = enemies3.get(i);
      e.display();
      e.update1();

      boolean enemyCollision = enemyCollision(player3, e);
      if (enemyCollision) {
        isOver = true;
      }
    }

    if ( player3.health == 0) {
      isOver = true;
    }

    // Show the drops in the level 3
    for (int i=0; i<drops.length; i++) {
      drops[i].display();
      drops[i].fall();
    }
  }

  // ---------------- Menu --------------------
  if (level == L_MENU) {
    color menuColor = color(#9B8F93);
    background(menuColor);
    image( titleImage, 360, 20);
    image(backgroundImage, 380, 200);

    playAgainButton.hide();
    backButton.hide();
    nextButton.hide();

    startButton.show();
    exitButton.show();
    musicButton.show();
  } else {
    musicButton.hide();
    startButton.hide();
    exitButton.hide();
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

  // --------------- LEVEL OVER -------------------
  if (level == L_WIN) {
    color menuColor = color(#9B8F93);
    background(menuColor);
    playAgainButton.show();
    exitButton.show();

    image(winTitleImage, 260, 20);
    image(winImage, 300, 280);
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

  if (player_x_left <= 0 && player_x_right <= 0 && player_y_top<=0 && player_y_bottom <=0 && ep.vy>2) {
    isBottomTouch = true;
  }
  else if (player_x_left <= 0 && player_x_right <= 0 && player_y_top<=0 && player_y_bottom <=0) {
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
  int num = 3;
  if (level == L_ONE) {
    num = 3;
  }
  if (level == L_TWO) {
    num = 5;
  }
  String s = "FOOD: " + foodNum + " " + "/" + " " + num;
  String s2 = "LEVEL:  " + level;
  textSize(24);
  fill(0);
  if (level != L_THREE) {
    text(s, 900, 30);
  }

  text(s2, 30, 30);
}

// Generate and reset the game
// Generate all the items in the level 1
void generateLevel1() {
  channel2 = new Platform(0, 400, 100, 50, 0, 0, 4);
  player2 = new Player(50, 350, 50, 50, 0, 0);
  foods2 = new ArrayList<Food>();

  platforms2 = new ArrayList<Platform>();
  platforms2.add(new Platform(250, 400, 200, 75, -3, 0, 8));
  platforms2.add(new Platform(750, 400, 200, 75, -3, 0, 8));
  platforms2.add(new Platform(500, 250, 200, 75, -3, 0, 8));
  foods2.add(new Food(880, 420, 25, 25, -3, 0, 1));
  foods2.add(new Food(380, 420, 25, 25, -3, 0, 1));
  //platforms2.add(new Platform(650, 100, 200, 75, 0, speed, 8));
  //platforms2.add(new Platform(350, -50, 200, 75, 0, speed, 8));
  //platforms2.add(new Platform(750, -200, 200, 75, 0, speed, 8));
  //platforms2.add(new Platform(500, -350, 200, 75, -2.5, speed, 8));
  //foods2.add(new Food(300, -525, 25, 25, 0, 0.5, 1));
  //foods2.add(new Food(300, -550, 25, 25, 0, 0.5, 1));
  //foods2.add(new Food(300, -575, 25, 25, 0, 0.5, 1));
  //platforms2.add(new Platform(200, -500, 200, 75, 0, speed, 8));
  //platforms2.add(new Platform(450, -650, 200, 75, 0, speed, 8));
  //platforms2.add(new Platform(750, -800, 200, 75, 0, speed, 8));
  //platforms2.add(new Platform(500, -950, 200, 75, 0, speed, 8));
  //platforms2.add(new Platform(300, -1100, 200, 75, -3, speed, 8));
  //foods2.add(new Food(600, -975, 25, 25, 0, 0.5, 1));
  //platforms2.add(new Platform(250, -1250, 200, 75, 0, speed, 8));
  door2 = new Door(800, 200, 60, 80, 0, 1);
}


// Generate all the items in the level 2
void generateLevel2() {
  float speed = 0.5;
  enemies1 = new ArrayList<Enemy>();

  platforms.add(new Platform(300, 600, 200, 25, 0, speed, 3));
  platforms.add(new Platform(550, 500, 200, 25, 0, speed, 1));
  platforms.add(new Platform(250, 400, 200, 25, 0, speed, 1));
  foods.add(new Food(300, 400, 25, 25, 0, speed, 2));
  enemies1.add(new Enemy(350, 395, 40, 30, 0, 0.5, 2));

  platforms.add(new Platform(500, 300, 200, 25, 0, speed, 3));
  foods.add(new Food(550, 300, 25, 25, 0, speed, 2));
  enemies1.add(new Enemy(600, 295, 40, 30, 0, 0.5, 2));

  platforms.add(new Platform(700, 200, 200, 25, 3, speed, 1));

  platforms.add(new Platform(500, 100, 200, 25, 0, speed, 1));

  platforms.add(new Platform(800, 50, 200, 25, 0, speed, 1));
  foods.add(new Food(850, 40, 25, 25, 0, speed, 2));
  enemies1.add(new Enemy(905, 35, 40, 30, 0, 0.5, 2));
  foods.add(new Food(850, 10, 25, 25, 0, speed, 2));
  foods.add(new Food(850, -20, 25, 25, 0, speed, 2));

  speed = 0.6;

  platforms.add(new Platform(300, -100, 200, 25, 0, speed, 1));

  platforms.add(new Platform(500, -200, 200, 25, -3, speed, 1));

  platforms.add(new Platform(800, -300, 200, 25, 0, speed, 1));
  door = new Door(850, -330, 60, 80, speed, 1);
}

// Remove all the items in the level one
void removeItemsInLevel1() {
  for (int i=platforms2.size()-1; i>=0; i--) {
    platforms2.remove(i);
  }

  for (int j=foods2.size()-1; j>=0; j--) {
    foods2.remove(j);
  }

  //for (int j=seaweads.size()-1; j>=0; j--) {
  //  seaweads.remove(j);
  //}

  //for (int j=enemies2.size()-1; j>=0; j--) {
  //  enemies2.remove(j);
  //}
}

// Remove all the items in the level two
void removeItemsInLevel2() {
  for (int i=platforms.size()-1; i>=0; i--) {
    platforms.remove(i);
  }

  for (int i=foods.size()-1; i>=0; i--) {
    foods.remove(i);
  }

  for (int j=enemies1.size()-1; j>=0; j--) {
    enemies1.remove(j);
  }
}


// Generate all the items in the level 3
void generateLevel3() {
  player3 = new Player(250, 350, 50, 50, 0, 0);
  player3.vy = 5;
  platforms3 = new ArrayList<Platform>();

  float speed = 1.2;

  platforms3.add(new Platform(250, 400, 200, 25, 0, speed, 5));
  platforms3.add(new Platform(750, 400, 200, 25, 0, speed, 6));
  platforms3.add(new Platform(500, 250, 200, 25, 0, speed, 7));
  platforms3.add(new Platform(650, 100, 200, 25, 0, speed, 5));
  platforms3.add(new Platform(350, -50, 200, 25, 0, speed, 6));
  platforms3.add(new Platform(750, -200, 200, 25, 0, speed, 7));
  platforms3.add(new Platform(500, -350, 200, 25, 0, speed, 5));
  platforms3.add(new Platform(200, -500, 200, 25, 0, speed, 6));
  platforms3.add(new Platform(450, -650, 200, 25, 0, speed, 7));
  platforms3.add(new Platform(750, -800, 200, 25, 0, speed, 5));
  platforms3.add(new Platform(500, -950, 200, 25, 0, speed, 7));
  platforms3.add(new Platform(300, -1100, 200, 25, 0, speed, 6));
  platforms3.add(new Platform(250, -1250, 200, 25, 0, speed, 5));
  door3 = new Door(300, -1270, 60, 80, speed, 1);

  // initiallize antlion
  antlion = new Antlion(300, 600, 500, 500, 0, 0);


  enemies3 = new ArrayList<Enemy>();
}

//Remove all the items in the level 3
void removeItemsInLevel3() {
  for (int i=platforms3.size()-1; i>=0; i--) {
    platforms3.remove(i);
  }
}


void levelCheck() {
  if (!isPlaying && !isFinished) {
    level = L_MENU;
  } else {
    if (!isOver) {
      if (!isTouchDoor && isStory && level == L_MENU) {
        level = L_1_1;
      }
      if (!isTouchDoor && isInstruction && level == L_1_1) {
        level = L_1_2;
      }
      if (!isTouchDoor && isInstruction3 && level == L_1_2) {
        level = L_1_3;
      }

      if (!isTouchDoor && level == L_1_3 && !isInstruction && !isInstruction3 && isInstruction2) {
        level = L_ONE;
        resetLevel = L_ONE;
      } else if (isTouchDoor==true && level==L_ONE) {
        foodNum = 0;
        isTouchDoor = false;
        level = L_2_1;
      } else if (level == L_2_1 && isInstruction4) {
        level = L_TWO;
        resetLevel = L_TWO;
      } else if (level == L_TWO && isTouchDoor==true) {
        foodNum = 0;
        isTouchDoor = false;
        level = L_3_1;
      } else if (level == L_3_1 && isInstruction5) {
        level = L_THREE;
        resetLevel = L_THREE;
      } else if (level==L_TWO && isTouchDoor==false) {
        level = L_TWO;
      } else if (level==L_THREE && isTouchDoor==false) {
        level = L_THREE;
      } else if (level==L_THREE && isTouchDoor==true) {
        level = L_WIN;
        isPlaying = false;
        isTouchDoor = false;
        isFinished = true;
      } else if (level == L_WIN && isFinished) {
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
      isStory = true;
      break;

      // If the exit button is pressed
    case "/Exit":
      isPlaying = false;
      exit();
      break;

      // if the music button is pressed
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
      // if the next button is pressed
    case "/Next":
      if (isStory && !isInstruction && !isInstruction2 && !isInstruction3) {
        isStory = false;
        isInstruction = true;
      } else if (!isStory && isInstruction && !isInstruction2 && !isInstruction3) {
        isInstruction = false;
        isInstruction3 = true;
      } else if (!isStory && !isInstruction && !isInstruction2 && isInstruction3) {
        isInstruction3 = false;
        isInstruction2 = true;
      } else if (!isInstruction4) {
        isInstruction4 = true;
      } else if (!isInstruction5) {
        isInstruction5 = true;
      }
      break;
    case "/play again":
      if (level != L_WIN) {
        backButton.hide();
        playAgainButton.hide();
        player.x = 300;
        player.y = 500;
        bg.refresh();
        level = resetLevel;
        foodNum = 0;
        isOver = false;
        player.vx = 0;
        player.vy = 0;
        removeItemsInLevel1();
        generateLevel1();
        removeItemsInLevel2();
        generateLevel2();
        removeItemsInLevel3();
        generateLevel3();
      } else {
        level = L_MENU;
        isFinished = false;
      }
      break;
    case "/back":
      isOver = false;
      isPlaying = false;
      isStory = false;
      isInstruction = false;
      isInstruction3 = false;
      isInstruction2 = false;
      isInstruction4 = false;
      isInstruction5 = false;
      break;
    }
  }
}
