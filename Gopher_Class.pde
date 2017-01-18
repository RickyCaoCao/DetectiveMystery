class Gopher {
  //class vars
  PImage sprite_left, sprite_right;
  float x, y;
  int speed, size;

  //for bounce
  float angle;

  //for walking
  float walkTimer;
  int direction;

  //for display
  int redTint, greenTint;
  int behaviour;

  //for game
  String state;

  //constructor
  Gopher(float _x, float _y) {
    //sets variables
    x = _x;
    y = _y;
    size = 100;
    speed = 4;
    state = "Alive";

    //sets variables based on behavior that was randomly chosen
    behaviour = int(random(1, 3));
    if (behaviour == 1) {
      angle = radians(random(0, 360));
    } else if (behaviour == 2) {
      walkTimer = millis();
      direction = int(random(1, 5));
    }

    //loads images and resizes them
    sprite_left = mascotLeft;
    sprite_left.resize(size, size);

    sprite_right = mascotRight;
    sprite_right.resize(size, size);
  }

  void display() {
    if (state == "Alive") {
      if (behaviour == 1) {
        bounce();
      } else if (behaviour == 2) {
        walk();
      }

      //draws the gopher
      colorChange();
      image(sprite_right, x, y);
      noTint();
    }
  }

  void colorChange() {
    //changes tint based on distance from mouse
    float distance = calculateDistance();

    //changes red closer the mouse gets
    if (distance <= 200) {
      redTint = 255;
      greenTint = int(255 * distance/200);
      greenTint = constrain(greenTint, 0, 255);
    }
    //goes to green the further the mouse is from the gopher
    else if (distance <= 400) {
      greenTint = 255;
      redTint = int(255 * (400-distance)/200);
      redTint = constrain(redTint, 0, 255);
    }
    //stays green after a while
    else {
      redTint = 0;
      greenTint = 255;
    }

    tint(redTint, greenTint, 0);
  }

  void walk() {
    boolean hitWall = collisionWithWall();
    if (millis() - walkTimer > 1000 || hitWall) {
      direction = int(random(1, 5));
      walkTimer = millis();
    }

    //move up
    if (direction == 1) {
      y += speed;
      y = constrain(y, size/2, height - size/2);
    }
    //move left
    else if (direction == 2) {
      x -= speed;
      x = constrain(x, size/2, width - size/2);
    }

    //move down
    else if (direction == 3) {
      y -= speed;
      y = constrain(y, size/2, height - size/2);
    }

    //move right
    else if (direction == 4) {
      x += speed;
      x = constrain(x, size/2, width - size/2);
    }
  }

  void bounce() {
    //moves based on angle and speed
    x += speed * cos(angle);
    x = constrain(x, size/2, width - size/2);

    y += speed * sin(angle);
    y = constrain(y, size/2, height - size/2);

    if (x < size/2 + 10|| x > width - size/2 - 10) {
      angle = PI - angle;
    } else if (y < size/2 + 10 || y > height - size/2 - 10) {
      angle = -angle;
    }
  }

  //checks if the gopher hit the wall
  //this is for walk() as bounce() requires more specific check to determin change in the angle
  boolean collisionWithWall() {
    if (x < size/2 + 10|| x > width - size/2 - 10 || y < size/2 + 10 || y > height - size/2 - 10) {
      return true;
    }
    return false;
  }

  //checks distance for color change
  float calculateDistance() {
    return sqrt(sq(mouseX - x) + sq(mouseY - y));
  }
  
  //checks collision
  boolean collision(Gopher aGopher){
    if((x - size/2) < (aGopher.x + aGopher.size/2) && (x + size/2) > (aGopher.x - aGopher.size/2) && (y-size/2) < (aGopher.y + aGopher.size/2) && (y+size/2) > (aGopher.y - aGopher.size/2)){
      return true;
    }
    return false;
  }
}