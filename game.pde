//Classes
// PowerUp

int points;
PImage img;
PImage life;
PImage back;
class PowerUp {
  boolean active;
  PowerUp(boolean x) {
    active = x;
  }

  void usePower() {
    //stop time
  }
}
//Player
class Player {
  PowerUp pwrup;
  Player () {
    life = loadImage("life.gif");
    life.resize(75,75);
    pwrup = new PowerUp(false);
  }

  void display() {
    image(life, mouseX, mouseY);
  }

  void move () {
  }
}
//Timer object
class Timer{

  Timer(){}
  
  void display (int seconds, float x , float y){
    fill(255);
    textSize(40);
    String seond = nf(seconds, 1);
    text("Time: " + seond, x, y);
    text("Points: " + points, x, y + 40);
  }
  
}
//Objects
class Item {
  float dirX;
  float dirY; 
  float speedx;
  float speedy;
  Item () {
    dirY = (height/2);
    dirX = 51;
    speedx = speedy = random(7);
    img = loadImage("cell.gif");
    img.resize(70, 70);
  }
  void display () {
    image(img, dirX,dirY);
  }
  void move () {
    if ((dirX + 25) > width || (dirX - 25) < 0) {
      points += 1;
      speedx *= -1;
    }
    if ((dirY + 25) > height || (dirY - 25) < 0) {
      points += 1;
      speedy *= -1; 
    }
    dirX += speedx;
    dirY += speedy;
  }
}
int max = 10;
ArrayList <Item> item = new ArrayList<Item>(max);
//The game is set up by time so we'll add a chechTime fucntion that returns the time that has elapsed
Player ply1;
Timer timer;
float start;
float count;
boolean gameOver;
void setup () {

  size(800,600);
  
  back = loadImage("back.jpg");
  back.resize(800,600);
  background(back);
  //create the obejct
  ply1 = new Player();
  start = count  = millis();
  item.add(new Item());
  gameOver = false;
  timer = new Timer();
}

void draw () {
  if (!gameOver) {
    background(back);
    for (int i = 0; i < item.size(); i++) {
      Item x = item.get(i);
      x.display();
      x.move();
    }
    print(start + "\n");
    //Everytime checkTime is called, the start time is reset
    if (millis() - count > 10000) {
      count = millis();
      if (item.size() != max) {
        item.add(new Item());
      }
    }
    // check for game over
    ply1.display();
    int time = (int)(millis()- start)/1000;
    timer.display(time, 10, 40);
    for (int i = 0; i < item.size(); i++) {
      Item x = item.get(i);
      if ((mouseX + 30) > x.dirX && (mouseY + 40) > x.dirY && (mouseX - 30) < x.dirX && (mouseY - 30) < x.dirY) {
        gameOver = true;
      }
    }
  } else {
    background(0);
    fill(255);
    textSize(40);
    text("GAME OVER", 300, 300);
    text("Press spacebar to restart", 180, 350);
    text("Score: " + points, 350, 400);
    if (keyPressed) {
      points = 0;
      start = count = millis();
      gameOver = false;
      item.clear();
      item.add(new Item());
    }
  }
}