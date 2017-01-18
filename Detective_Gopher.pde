class DetectiveGopher extends Gopher {
  //class vars
  boolean up, down, left, right;
  int velX, velY;

  //constructor
  DetectiveGopher(float _x, float _y) {
    super(_x, _y);
    
    //sets movement variables
    up = false;
    down = false;
    left = false;
    right = false;
    
    velX = 0;
    velY = 0;
  }

  void display() {
    tint(0, 100, 255);
    image(sprite_left, x, y);
  }

  //moves the gopher
  void move() {
    x += velX;
    x = constrain(x, size/2, width - size/2);
    
    y += velY;
    y = constrain(y, size/2, height - size/2);
  }

  //does movement using booleans and keypressed/keyreleased
  void pressButton(){
    if (keyCode == UP) {
      velY = -5;
      up = true;
    }
    if (keyCode == DOWN) {
      velY = 5;
      down = true;
    }
    if (keyCode == LEFT) {
      velX = -5;
      left = true;
    }
    if (keyCode == RIGHT) {
      velX = 5;
      right = true;
    }
  }

  void releaseButton() {
    if (keyCode == UP) {
      up = false;
      if(down == false){
        velY = 0;
      }
    }
    if (keyCode == DOWN) {
      down = false;
      if(up == false){
        velY = 0;
      }
    }
    if (keyCode == LEFT) {
      left = false;
      if(right == false){
        velX = 0;
      }
    }
    if (keyCode == RIGHT) {
      right = false;
      if(left == false){
        velX = 0;
      }
    }
  }
}
