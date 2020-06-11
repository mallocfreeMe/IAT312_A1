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
Button winBackButton;
Button winExitButton;

PImage winTitleImage;
PImage winImage;


ControlP5 cp5;

Player player, player2, player3;
ArrayList<Platform> platforms, platforms3;
Platform channel2;
ArrayList<Food> foods, foods2, foods3;
Antlion antlion;
ArrayList<Enemy> enemies1;
ArrayList<Enemy> enemies2;
ArrayList<Enemy> enemies3;
ArrayList<Seawead> seaweads;
Background bg,bg2,bg3;
Door door;
Door door2;
Door door3;

// Score
int foodNum = 0;

// Level
boolean isPlaying = false;
boolean isOver = false;
boolean isTouchDoor = false;

int L_OVER = -2;
int L_SELECT = -1;
int L_MENU = 0;
int L_ONE = 1;
int L_TWO = 2;
int L_THREE = 3;
int L_WON = 4;

// stories screen
int L_one= 5;
int L_two = 6;
int L_three = 7;

//<<<<<<< Updated upstream
int level = L_MENU;
//=======

//int level = L_OVER;
//>>>>>>> Stashed changes


boolean left, right, up;
boolean isAttack = false;
boolean isBack = false;

// Timer
int attackTimer=0;


// Platform version
int pversion;

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

  // initialize platforms
  pversion = (int)random(1, 3);
  platforms = new ArrayList<Platform>();


  // initialize player
  player = new Player(300, 500, 50, 50, 0, 0);
  float speed = 0.5;

  //initialize food
  foods = new ArrayList<Food>();
  // level one 

  generateLevel1();
  //platforms.add(new Platform(300, 600, 200, 25, speed, 3));
  //platforms.add(new Platform(550, 500, 200, 25, speed, 1));
  //platforms.add(new Platform(250, 400, 200, 25, speed, 1));
  //foods.add(new Food(300, 400, 25, 25, speed));

  //platforms.add(new Platform(500, 300, 200, 25, speed, 3));
  //foods.add(new Food(550, 300, 25, 25, speed));

  //platforms.add(new Platform(700, 200, 200, 25, speed, 1));

  //platforms.add(new Platform(500, 100, 200, 25, speed, 1));

  //platforms.add(new Platform(800, 50, 200, 25, speed, 1));
  //foods.add(new Food(850, 40, 25, 25, speed));
  //foods.add(new Food(850, 10, 25, 25, speed));
  //foods.add(new Food(850, -20, 25, 25, speed));

  //speed = 0.6;

  //platforms.add(new Platform(300, -100, 200, 25, speed, 1));

  //platforms.add(new Platform(500, -200, 200, 25, speed, 1));

  //platforms.add(new Platform(800, -300, 200, 25, speed, 1));
  //door = new Door(850, -340, 60, 80, speed);

  // level 2
  generateLevel2();
  //player2 = new Player(50, 350, 50, 50, 0, 0);
  //foods2 = new ArrayList<Food>();
  //foods2.add(new Food(100, 200, 25, 25, 0));
  //foods2.add(new Food(500, 500, 25, 25, 0));
  //foods2.add(new Food(200, 200, 25, 25, 0));
  //foods2.add(new Food(1000, 200, 25, 25, 0));
  //foods2.add(new Food(800, 600, 25, 25, 0));

  //door2 = new Door(540, 260, 60, 80, 0);
  //enemies2 = new ArrayList<Enemy>();
  //enemies2.add(new Enemy(100, 100, 20, 20, 0, 0));
  //enemies2.add(new Enemy(200, 600, 20, 20, 0, 0));
  //enemies2.add(new Enemy(300, 100, 20, 20, 0, 0));

  // level 3
  generateLevel3();
  //player3 = new Player(250, 350, 50, 50, 0, 0);
  //platforms3 = new ArrayList<Platform>();

  //speed = 1.5;
  //platforms3.add(new Platform(250, 400, 200, 25, speed, pversion));
  //platforms3.add(new Platform(750, 400, 200, 25, speed, pversion));
  //platforms3.add(new Platform(500, 250, 200, 25, speed, pversion));
  //platforms3.add(new Platform(650, 100, 200, 25, speed, pversion));
  //platforms3.add(new Platform(350, -50, 200, 25, speed, pversion));
  //platforms3.add(new Platform(750, -200, 200, 25, speed, pversion));
  //platforms3.add(new Platform(500, -350, 200, 25, speed, pversion));
  //platforms3.add(new Platform(200, -500, 200, 25, speed, pversion));
  //platforms3.add(new Platform(450, -650, 200, 25, speed, pversion));
  //platforms3.add(new Platform(750, -800, 200, 25, speed, pversion));
  //platforms3.add(new Platform(500, -950, 200, 25, speed, pversion));
  //platforms3.add(new Platform(300, -1100, 200, 25, speed, pversion));
  //platforms3.add(new Platform(250, -1250, 200, 25, speed, pversion));
  //door3 = new Door(300, -1290, 60, 80, speed);

  //// initiallize antlion
  //antlion = new Antlion(300, 600, 500, 500, 0, 0);


  //enemies3 = new ArrayList<Enemy>();

  //// initialize seawead
  //seaweads = new ArrayList<Seawead>();
  //for (int i = 0; i < 3; i++) {
  //  float rx = random(1080);
  //  float ry = random(700);
  //  seaweads.add(new Seawead(rx, ry, 75, 75));
  //}


  // initialize background
  bg = new Background(0, 0, 1080, height, 0.2);
  bg.display();
  
  bg2 = new Background(0, 0, 1080, height, 0.2);
  //bg2.display2();
  bg3 = new Background(0, 0, 1080, height, 0.2);


  // initialize boolean variables
  left = false;
  right = false;
  up = false;
}


void draw() {
  levelCheck();

  //Attack timer
  attackTimer ++;
  //if (attackTimer >= 600) {
  //  isAttack = true;
  //  isBack = false;
  //}
  //if(attackTimer >= 660){
  //  isAttack = true;
  //}
  //if (attackTimer >= 720) {
  //  isAttack = false;
  //  isBack = true;
  //  attackTimer = 0;
  //}

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
    //print(player.y);
    bg.display();
    door.update();
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

     //Display the enemies
    for (int i=0; i<enemies1.size(); i++) {
      Enemy e = enemies1.get(i);
      e.display();
      e.update1();

      boolean enemyCollision = enemyCollision(player, e);
      if (enemyCollision) {
        println("YOU DIE!");
        isOver = true;
      }
    }

    // Display antlion
    //antlion.update();
    //boolean bossCollision = bossCollision(player, antlion);
    //  if (bossCollision) {
    //    isOver = true;
    //  }


    // Check the player touch the door
    boolean doorCollision = doorCollision(player, door);
    if (doorCollision) {
      isTouchDoor = true;
    }



    // Check the boundaries
    player.checkBoundaries();

    // Display
    player.display();
    setText();
  }

  // --------------- LEVEL 2 -------------------

  if (level == L_TWO) {
    //background(135, 206, 235);
    bg2.display2();
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

    // Check the player touch the door
    boolean doorCollision = doorCollision(player2, door2);
    if (doorCollision) {
      isTouchDoor = true;
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
      }
    }
    
    setText();
  }


  // --------------- LEVEL 3 -------------------
  if (level == L_THREE) {
    //background(255, 204, 203);
    bg3.display3();
    
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
      isTouchDoor = true;
    }


    //Display Antlion

    antlion.update();
    //println(attackTimer);
    if (attackTimer >=150 && attackTimer < 200) {
      antlion.y += -2;
    }
    if (attackTimer >=200 && attackTimer <250) {
      antlion.y += 2;
    }
    if (attackTimer >=300) {
      attackTimer = 0;
    }

    boolean bossCollision = bossCollision(player3, antlion);
    if (bossCollision) {
      isOver = true;
    }

    // Display the enemies
    for (int i=0; i<enemies3.size(); i++) {
      Enemy e = enemies3.get(i);
      e.display();
      e.update1();

      boolean enemyCollision = enemyCollision(player3, e);
      if (enemyCollision) {
        println("YOU DIE!");
        isOver = true;
      }
    }
    
    for (int i=0; i<foods3.size(); i++) {
      Food f = foods3.get(i);
      f.update();

      boolean foodCollision = collectCollision(player3, f);
      if (foodCollision) {
        foodNum++;
        foods3.remove(i);
      }
    }
    
    setText();
    
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

  if (player_x_left <= 0 && player_x_right <= 0 && player_y_top<=0 && player_y_bottom <=0) {
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
  if (level == L_TWO) {
    String s3 = "Keep pressing up key to stay alive";
    textSize(18);
    fill(255);
    text(s3, 430, 30);
  }
  textSize(24);
  fill(0);
  if (level != L_THREE) {
    text(s, 900, 30);
  }

  text(s2, 30, 30);
}

void levelCheck() {
  if (!isPlaying) {
    level = L_MENU;
  } else {
    if (!isOver) {
      //level = L_ONE;
      //level = L_TWO;
      //level = L_THREE;

      if (isTouchDoor==true && level==L_ONE) {
        foodNum = 0;
        level = L_TWO;
        isTouchDoor = false;
      } else if (level == L_TWO && isTouchDoor==true) {
        foodNum = 0;
        level = L_THREE;
        isTouchDoor = false;
      } else if (level==L_TWO && isTouchDoor==false) {
        level = L_TWO;
      } else if (level==L_THREE && isTouchDoor==true) {
        isPlaying = false;
        isTouchDoor = false;
      } else if (level==L_THREE && foodNum<5) {
        level = L_THREE;
      } else {
        //level = L_ONE;
        // --------------------------------------- Change the level here --------------------------------------------

        level = L_ONE;

        // ----------------------------------------------------------------------------------------------------------
      }
    } else {
      level = L_OVER;


      // reset all the items in the background
      //player = new Player(200,-100,50,50,0,0);
    }
  }
}



// Generate and reset the game
// Generate all the items in the level 1
void generateLevel1(){
  
  float speed = 0.5;

  platforms.add(new Platform(300, 600, 200, 25, speed, 3));
  platforms.add(new Platform(550, 500, 200, 25, speed, 1));
  platforms.add(new Platform(250, 400, 200, 25, speed, 1));
  foods.add(new Food(300, 400, 25, 25, speed));

  platforms.add(new Platform(500, 300, 200, 25, speed, 3));
  foods.add(new Food(550, 300, 25, 25, speed));

  platforms.add(new Platform(700, 200, 200, 25, speed, 1));

  platforms.add(new Platform(500, 100, 200, 25, speed, 1));

  platforms.add(new Platform(800, 50, 200, 25, speed, 1));
  foods.add(new Food(850, 40, 25, 25, speed));
  foods.add(new Food(850, 10, 25, 25, speed));
  foods.add(new Food(850, -20, 25, 25, speed));

  speed = 0.6;

  platforms.add(new Platform(300, -100, 200, 25, speed, 1));

  platforms.add(new Platform(500, -200, 200, 25, speed, 1));

  platforms.add(new Platform(800, -300, 200, 25, speed, 1));
  door = new Door(850, -340, 60, 80, speed);
  
  enemies1 = new ArrayList<Enemy>();
  enemies1.add(new Enemy(100, 100, 40, 40, -2, 0));
  enemies1.add(new Enemy(200, 400, 40, 40, 2, 0));
  enemies1.add(new Enemy(300, 250, 40, 40, -3, 0));
  
}

// Remove all the items in the level one
void removeItemsInLevel1() {
  for (int i=platforms.size()-1; i>=0;i--) {
    platforms.remove(i);
  }
  
  for (int j=foods.size()-1; j>=0; j--) {
    foods.remove(j);
  }
  
  for (int k=enemies1.size()-1; k>=0; k--) {
    enemies1.remove(k);
  }
}


// Generate all the items in the level 2
void generateLevel2() {
  channel2 = new Platform(0,400,100,50, 0, 4);
  player2 = new Player(10, 350, 50, 50, 0, 0);
  foods2 = new ArrayList<Food>();
  foods2.add(new Food(100, 200, 25, 25, 0));
  foods2.add(new Food(500, 500, 25, 25, 0));
  foods2.add(new Food(200, 200, 25, 25, 0));
  foods2.add(new Food(1000, 200, 25, 25, 0));
  foods2.add(new Food(800, 600, 25, 25, 0));

  door2 = new Door(540, 260, 60, 80, 0);
  enemies2 = new ArrayList<Enemy>();
  enemies2.add(new Enemy(100, 100, 20, 20, 0, 0));
  enemies2.add(new Enemy(200, 600, 20, 20, 0, 0));
  enemies2.add(new Enemy(300, 100, 20, 20, 0, 0));
  
    // initialize seawead
  seaweads = new ArrayList<Seawead>();
  for (int i = 0; i < 3; i++) {
    float rx = random(1080);
    float ry = random(700);
    seaweads.add(new Seawead(rx, ry, 75, 75));
  }
  

}

// Remove all the items in the level one
void removeItemsInLevel2(){
  for(int i=foods2.size()-1; i>=0; i--) {
    foods2.remove(i);
  }
  
  for(int j=seaweads.size()-1; j>=0;j--) {
    seaweads.remove(j);
  }
}


// Generate all the items in the level 3
void generateLevel3() {
  player3 = new Player(250, 350, 50, 50, 0, 0);
  platforms3 = new ArrayList<Platform>();

  float speed = 1.5;
  platforms3.add(new Platform(250, 400, 200, 25, speed, pversion));
  platforms3.add(new Platform(750, 400, 200, 25, speed, pversion));
  platforms3.add(new Platform(500, 250, 200, 25, speed, pversion));
  platforms3.add(new Platform(650, 100, 200, 25, speed, pversion));
  platforms3.add(new Platform(350, -50, 200, 25, speed, pversion));
  platforms3.add(new Platform(750, -200, 200, 25, speed, pversion));
  platforms3.add(new Platform(500, -350, 200, 25, speed, pversion));
  platforms3.add(new Platform(200, -500, 200, 25, speed, pversion));
  platforms3.add(new Platform(450, -650, 200, 25, speed, pversion));
  platforms3.add(new Platform(750, -800, 200, 25, speed, pversion));
  platforms3.add(new Platform(500, -950, 200, 25, speed, pversion));
  platforms3.add(new Platform(300, -1100, 200, 25, speed, pversion));
  platforms3.add(new Platform(250, -1250, 200, 25, speed, pversion));
  door3 = new Door(300, -1290, 60, 80, speed);
  foods3 = new ArrayList<Food>();
  foods3.add(new Food(600, 250, 25, 25, speed));
  foods3.add(new Food(450, -50, 25, 25, speed));
  foods3.add(new Food(450, -75, 25, 25, speed));
  foods3.add(new Food(300, -500, 25, 25, speed));

  // initiallize antlion
  antlion = new Antlion(300, 600, 500, 500, 0, 0);


  enemies3 = new ArrayList<Enemy>();
}

//Remove all the items in the level 3
void removeItemsInLevel3() {
  for(int i=platforms3.size()-1; i>=0; i--) {
    platforms3.remove(i);
  }
  
  for(int j=foods3.size()-1; j>=0; j--) {
    foods3.remove(j);
  }
}


// -----------------------------------------------------------------


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
      //
      player.x = 300;
      player.y = 500;
      foodNum = 0;
      player.vx = 0;
      player.vy = 0;
      removeItemsInLevel1();
      generateLevel1();
      removeItemsInLevel2();
      generateLevel2();
      removeItemsInLevel3();
      generateLevel3();
      //
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
      backButton.hide();
      playAgainButton.hide();
      player.x = 300;
      player.y = 500;
      bg.refresh();
      //isOver = false;
      
      // ---------------------------- modify play again ------------------------
      level = L_ONE;
      foodNum = 0;
      isOver = false;
      player.vx = 0;
      player.vy = 0;
      removeItemsInLevel1();
      generateLevel1();
      //door = new Door(850, -340, 60, 80, 0.6);
      removeItemsInLevel2();
      generateLevel2();
      removeItemsInLevel3();
      generateLevel3();
      
      // -----------------------------------------------------------------------
      
      
      break;
    case "/back":
      isOver = false;
      isPlaying = false;
      break;
    }
  }
}
