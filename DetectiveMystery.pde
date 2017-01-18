//Richard Cao
//Computer Science 30 - Mr. Schellenberg
//"Gopher Game"
//draws a gopher centered at the coordinate (x,y)

//global variables
PImage mascotRight, mascotLeft, sniperScope;
ArrayList <Gopher> gopherCitizens = new ArrayList <Gopher> ();

DetectiveGopher player;
MurdererGopher murderer;

boolean gopherDied;
float deathTimer;

String GameState = "Title";



void setup() {
  //creates window
  size(800, 800);

  //loads image and create settings
  mascotRight = loadImage("rocking-gopher-r.png");
  mascotLeft = loadImage("rocking-gopher-l.png");
  sniperScope = loadImage("sniper_scope.png");
  sniperScope.resize(50, 50);
  imageMode(CENTER);

  //creates gophers
  for (int i = 0; i < 10; i++) {
    Gopher someGopher = new Gopher(random(width), random(height - 200));
    gopherCitizens.add(someGopher);
  }

  //create the player detective and the murderer
  player = new DetectiveGopher(width/2, height - 50);
  murderer = new MurdererGopher(random(width), random(height - 200));

  //sets up font
  PFont someFont = createFont("Calibri.vlw", 42);
  textFont(someFont);
}

void draw() {  
  background(180);

  //switches between game states
  if (GameState == "Title") {
    TitleScreen();
  } else if (GameState == "GameStart") {
    if(gopherDied == false){
      NormalGame();
    }
    else{
      //if a gopher died, the screen goes red and everything pauses
      SomeoneDied();
      if(millis() - deathTimer >= 1500){
        gopherDied = false;
        murderer.killTimer = millis();
      }
    }
  }
  else if(GameState == "GameOver"){
    GameOver();
  }
  else if(GameState == "Win"){
    WinScreen();
  }
}

void keyPressed(){
  if (GameState == "GameStart"){
    player.pressButton();
  }
}

void keyReleased(){
  if (GameState == "GameStart"){
    player.releaseButton();
  }
}

void mousePressed(){
  //shot a friendly!
  for (int i = gopherCitizens.size () - 1; i >= 0; i--) {
    Gopher aGopher = gopherCitizens.get(i);
    //checks if mouse is clicked on the gopher
    if(mouseX < (aGopher.x + aGopher.size/2) && mouseX > (aGopher.x - aGopher.size/2) && mouseY < (aGopher.y + aGopher.size/2) && mouseY > (aGopher.y - aGopher.size/2)){
      //killed friendly = game over
      GameState = "GameOver";
    }
  }
  
  //shot the murderer  
  if(mouseX < (murderer.x + murderer.size/2) && mouseX > (murderer.x - murderer.size/2) && mouseY < (murderer.y + murderer.size/2) && mouseY > (murderer.y - murderer.size/2)){
    //shooting murderer = win
    GameState = "Win";
  }
}