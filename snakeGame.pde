ArrayList <Integer> xposList, yposList;
int xpos, ypos;
int snakeLength;
int randomx, randomy;
int score;
boolean snakeHitSelf = false;
boolean snakeHitBorder = false;
boolean scoreRun = true;
boolean gameEnd = false;
snake snakePart1 = new snake();
fruit randomFruit = new fruit();
endGame endTheGame = new endGame();
scored scoreKeep = new scored();
void setup() {
  size(600, 600);
  frameRate(10);
}

void draw() {
  background(255);
  int lineV = 10;
  int lineH = 20;
  while (lineV <= width) {
    line(lineV, 20, lineV, height);
    lineV = lineV + 10;
  }
  while (lineH <= height) {
    line(0, lineH, width, lineH);
    lineH = lineH + 10;
  }
  if (xpos == randomx && ypos == randomy) {
    randomx = round(random(3, (width/10)-1))*10;
    randomy = round(random(3, (height/10)-1))*10; 
    snakeLength = snakeLength+ 1;
  } else { 
    randomFruit.updateFruit();
  } 
  if (gameEnd == true) {
    textSize(20);
    text("Game Over Please Press Space" , 160, 295);
    dirH = 0;
    dirV = 0;
    xpos = 300;
    ypos = 300;
    snakeLength = 0;
    xposList.clear();
    yposList.clear();
  }
  snakePart1.update();
  snakePart1.bodyPart();
  snakePart1.tail();
  endTheGame.endGameUpdate();
  scoreKeep.scoreUpdate();
  
  
  if (xpos < 0 | xpos >= width) {
      snakeHitBorder = true;
    }
  if (ypos < 20 | ypos >= height) {
      snakeHitBorder = true;
    }
  textSize(20);
  text("Score:", 260, 18);
  text(score, 320, 18);
}

int dirV = 0;
int dirH = 0;
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if (dirV == 10) {
        gameEnd = true;
      }
      dirV = -10;
      dirH = 0;
    } else if (keyCode == DOWN) {
      if (dirV == -10) {
        gameEnd = true;
      }
      dirV = 10;
      dirH = 0;
    } else if (keyCode == LEFT) {
      if (dirH == 10) {
        gameEnd = true;
      }
      dirH = -10;
      dirV = 0;
    } else if (keyCode == RIGHT) {
      if (dirH == -10) {
        gameEnd = true;
      }
      dirH = 10;
      dirV = 0;
    }
  } else if (keyPressed) {
     if (key == ' ') {
       gameEnd = false;
       score = 0;
     }
  }
}

class snake {
  snake() {
    snakeLength = 0;
    xposList = new ArrayList(xpos);
    yposList = new ArrayList(ypos);
    xpos = 300;
    ypos = 300;
  }
  void update() {
  if(gameEnd == false) {
    xpos += 0+dirH;
    ypos += 0+dirV;
    }
    
    xposList.add(0, xpos);
    yposList.add(0, ypos);
    
    fill(0);
    push();
    stroke(150);
    rect(xpos, ypos, 10, 10);
    pop();  
    for(int x = 0; x<snakeLength; x++) {
      if (xpos == xposList.get(x+1) && ypos == yposList.get(x+1)) {
      snakeHitSelf = true;
      }
    }
  }
  
  void bodyPart() {
    for(int x = 0; x<snakeLength; x++) {
      push();
      stroke(150);
      rect(xposList.get(x), yposList.get(x), 10, 10);
      pop();
    }
  }
  
  void tail() {
    push();
    stroke(150);
    rect(xposList.get(0+snakeLength), yposList.get(0+snakeLength), 10, 10);
    pop();
  }
}

class fruit {
  fruit() {
    randomx = round(random(3, (width/10)-1))*10;
    randomy = round(random(3, (height/10)-1))*10;
  }
  void updateFruit() {
    push();
    noStroke();
    fill(255, 0, 0);
    rect(randomx, randomy, 10, 10);
    pop();
  }
}

class endGame {
  endGame() {
  }
  void endGameUpdate() {
    if (snakeHitSelf == true) {
    gameEnd = true;
    snakeHitSelf = false;
  } else if(snakeHitBorder == true) {
    gameEnd = true;
    snakeHitBorder = false;
  }
  }
}

class scored {
  scored() {
  }
  void scoreUpdate() {
    if (snakeHitSelf == false && snakeLength >= 1) {
      score = snakeLength;
    }
  }
}
