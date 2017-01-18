class MurdererGopher extends Gopher {
  //class vars
  float killTimer;  
  boolean readyToKill;
  
  //constructor
  MurdererGopher(float _x, float _y){
    super(_x, _y);
    killTimer = millis();
    readyToKill = false;
  }
  
  
  void display(){
    super.display();
  }
  
  //after a given time, allows murderer to kill
  void kill() {
     if(millis() - killTimer >= 4000){
       readyToKill = true;
     } 
  }
}