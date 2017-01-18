void TitleScreen() {
  //instruction text
  textAlign(CENTER);
  fill(0);
  text("STOP the serial killer gopher!", width/2, height/2 - 80);
  text("Don't accidentally get friendly gophers!", width/2, height/2 - 40);
  text("Gophers die if the murderer touches them", width/2, height/2 + 40);
  text("Click to capture", width/2, height/2 + 80);
  text("Press SPACE to start", width/2, height/2 + 120);
  //press space to start
  if (keyCode == ' ') { 
    GameState = "GameStart";
    murderer.readyToKill = false;
    murderer.killTimer = millis();
  }
}

void NormalGame() {
  //draws gophers
  for (int i = gopherCitizens.size () - 1; i >= 0; i--) {
    Gopher theGopher = gopherCitizens.get(i);
    theGopher.display();
    
    //checks if murderer can kill
    if (murderer.readyToKill == true) {
      if (theGopher.collision(murderer)) {
        //removes gopher
        gopherCitizens.remove(theGopher);

        //resets murderer kill boolean
        murderer.readyToKill = false;
        murderer.killTimer = millis();
        
        //goes to red screen
        deathTimer = millis();
        gopherDied = true;
      }
    }
  }
  
  if(gopherCitizens.size() == 0){
    GameState = "GameOver";
  }

  //player functions
  player.display();
  player.move();

  if (murderer.readyToKill == true){
    if (player.collision(murderer)) {
      GameState = "GameOver";
    }
  }
  
  //murderer functions
  murderer.display();
  murderer.kill();

  //draws sniper
  image(sniperScope, mouseX, mouseY);
  
}

void SomeoneDied() {
  background(255, 0, 0);
}

void GameOver(){
 text("GAMEOVER!", width/2, height/2);
}

void WinScreen() {
 text("YOU WIN!", width/2, height/2);
}