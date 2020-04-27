final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

final int SOIL_SIZE = 80;
final int GRID = 80;

final int HEALTH_WIDTH = 50;
final int HEALTH_GAP = 20;
int healthOneX = 10;
int healthOneY = 10;

float hogIdleX = GRID*4;
float hogIdleY = 80;

// hog's move
int MoveTime = 250;
int actionFrame = 0;
float lastTime;
float hogLestY, hogLestX;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil0, soil1, soil2, soil3, soil4, soil5, soil6;
PImage health, stone1, stone2;
PImage hogIdle, hogDown, hogLeft, hogRight;

boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

// For debug function; DO NOT edit or remove this!
int playerHealth = 2;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  health = loadImage("img/life.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  hogIdle = loadImage("img/groundhogIdle.png");
  hogDown = loadImage("img/groundhogDown.png");
  hogLeft = loadImage("img/groundhogLeft.png");
  hogRight = loadImage("img/groundhogRight.png");
  
  frameRate(60);
  gameState = GAME_START;
  lastTime = millis();
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	  stroke(255,255,0);
	  strokeWeight(5);
	  fill(253,184,19);
	  ellipse(590,50,120,120);

    //if (hogIdleY > 80){
      pushMatrix();
      if (hogIdleY > GRID*21){
      translate(0, 80-GRID*21);
      } else {
        translate(0, 80-hogIdleY);
      }
    //}

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
		// image(soil8x24, 0, 160);
    for (int i=0; i<=width; i+=SOIL_SIZE){
      for (int j=0; j<=SOIL_SIZE*23; j+=SOIL_SIZE){
        if (j <= SOIL_SIZE*3){
          image(soil0, i, 160+j); 
          if (i == j){
            image(stone1, i, 160+j);
          }
        } else if ( j <= SOIL_SIZE*7){
          image(soil1, i, 160+j);
          if (i == j){
            image(stone1, i, 160+j);
          }
        } else if ( j <= SOIL_SIZE*11){
          image(soil2, i, 160+j);
          if (i == SOIL_SIZE || i == SOIL_SIZE*2 || i == SOIL_SIZE*5 || i == SOIL_SIZE*6){
            if (j == SOIL_SIZE*8 || j == SOIL_SIZE*11){
              image(stone1, i, 160+j);
            } 
          } else {
            if (j == SOIL_SIZE*9 || j == SOIL_SIZE*10){
              image(stone1, i, 160+j);
            }
          }
        } else if ( j <= SOIL_SIZE*15){
          image(soil3, i, 160+j);
          if (i == SOIL_SIZE || i == SOIL_SIZE*2 || i == SOIL_SIZE*5 || i == SOIL_SIZE*6){
            if (j == SOIL_SIZE*12 || j == SOIL_SIZE*15){
              image(stone1, i, 160+j);
            } 
          } else {
            if (j == SOIL_SIZE*13 || j == SOIL_SIZE*14){
              image(stone1, i, 160+j);
            }
          }
        } else if (j <= SOIL_SIZE*19){
          image(soil4, i, 160+j);
          if (i+j != SOIL_SIZE*16 && i+j != SOIL_SIZE*19  && i+j != SOIL_SIZE*22 && i+j != SOIL_SIZE*25 && i+j != SOIL_SIZE*28){
            image(stone1, i, 160+j);
          }
          if (i+j == SOIL_SIZE*18 || i+j == SOIL_SIZE*21  || i+j == SOIL_SIZE*24 || i+j == SOIL_SIZE*27 || i+j == SOIL_SIZE*30){
            image(stone2, i, 160+j);
          }
        } else {
          image(soil5, i, 160+j);
          if (i+j != SOIL_SIZE*16 && i+j != SOIL_SIZE*19  && i+j != SOIL_SIZE*22 && i+j != SOIL_SIZE*25 && i+j != SOIL_SIZE*28){
            image(stone1, i, 160+j);
          }
          if (i+j == SOIL_SIZE*18 || i+j == SOIL_SIZE*21  || i+j == SOIL_SIZE*24 || i+j == SOIL_SIZE*27 || i+j == SOIL_SIZE*30){
            image(stone2, i, 160+j);
          }
        } 
      }
    }

    // decide hog's direction
    if (downPressed == false && leftPressed == false && rightPressed == false) {
      image(hogIdle, hogIdleX, hogIdleY);
    }
    if (downPressed){
      actionFrame++;
      if (actionFrame > 0 && actionFrame < 15){
        hogIdleY += GRID/15.0;
        image(hogDown, hogIdleX, hogIdleY);
      } else{
        hogIdleY = hogLestY + GRID;
        downPressed = false;
      }
    } 
    if (leftPressed){
      actionFrame++;
      if (actionFrame > 0 && actionFrame < 15){
        hogIdleX -= GRID/15.0;
        image(hogLeft, hogIdleX, hogIdleY);
      } else{
        hogIdleX = hogLestX - GRID;
        leftPressed = false;
      }
    } 
    if (rightPressed){
      actionFrame++;
      if (actionFrame > 0 && actionFrame < 15){
        hogIdleX += GRID/15.0;
        image(hogRight, hogIdleX, hogIdleY);
      } else{
        hogIdleX = hogLestX + GRID;
        rightPressed = false;
      }
    }
    
    //groundhog: boundary detection
    if (hogIdleX >= width - GRID) {
      hogIdleX = width - GRID;
    }
    if (hogIdleX <= 0) {
      hogIdleX = 0;
    }
    if (hogIdleY >= GRID*25) {
      hogIdleY = GRID*25;
    }
    if (hogIdleY <= 0) {
      hogIdleY = 0;
    }
    
    
    //if (hogIdleY > 80){
      popMatrix();
    //}

		// Health UI

    if (playerHealth >= 5){
      for (int i=healthOneX; i<=healthOneX+(HEALTH_WIDTH+HEALTH_GAP)*4; i+=(HEALTH_WIDTH+HEALTH_GAP)){
        image(health, i, healthOneY);
      }
    }
    if (playerHealth == 4){
      for (int i=healthOneX; i<=healthOneX+(HEALTH_WIDTH+HEALTH_GAP)*3; i+=(HEALTH_WIDTH+HEALTH_GAP)){
        image(health, i, healthOneY);
      }
    }
    if (playerHealth == 3){
      for (int i=healthOneX; i<=healthOneX+(HEALTH_WIDTH+HEALTH_GAP)*2; i+=(HEALTH_WIDTH+HEALTH_GAP)){
        image(health, i, healthOneY);
      }
    }
    if (playerHealth == 2){
      for (int i=healthOneX; i<=healthOneX+(HEALTH_WIDTH+HEALTH_GAP)*1; i+=(HEALTH_WIDTH+HEALTH_GAP)){
        image(health, i, healthOneY);
      }
    }
    if (playerHealth == 1){
      image(health, healthOneX, healthOneY);
    }

		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
    
}

void keyPressed(){
  float newTime = millis();
  if (key == CODED) {
    switch (keyCode) {
      case DOWN:
        if (newTime - lastTime > 250){
          downPressed = true;
          actionFrame = 0;
          hogLestY = hogIdleY;
          lastTime = newTime;
        }
        break;
      case LEFT:
        if (newTime - lastTime > 250){
          leftPressed = true;
          actionFrame = 0;
          hogLestX = hogIdleX;
          lastTime = newTime;
        }
        break;
      case RIGHT:
        if (newTime - lastTime > 250){
          rightPressed = true;
          actionFrame = 0;
          hogLestX = hogIdleX;
          lastTime = newTime;
        }
      break;
    }
  } 

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}
