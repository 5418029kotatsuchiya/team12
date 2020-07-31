PFont font;

class StartDisplay {
  int x = width/2;
  int y = height/2;
  int w = 260;
  int h = 90;

  void display() {
    rectMode(CENTER);
    //game
    textSize(110);
    fill(0);
    text("GAME", 150, 150);
    
    textSize(70);
    strokeWeight(12);//太さ
    strokeJoin(ROUND);//角を丸く
    //easy
    stroke(#CEF5FF);
    fill(#CEF5FF);
    rect(x, y-125, w, h);
    fill(0);
    text("easy", 230, 295);
    //nomal
    stroke(#6AE0FF);
    fill(#6AE0FF);
    rect(x, y+25, w, h);
    fill(0);
    text("nomal", 200, 450);
    //hard
    stroke(#27B8FF);
    fill(#27B8FF);
    rect(x, y+175, w, h);
    fill(0);
    text("hard", 235, 600);
  }
}

class Wall {
}

class Human {
}

StartDisplay s;

void setup() {
  size(600, 800);
  font = loadFont("Arimo-Bold-36.vlw");
  textFont(font);

  s = new StartDisplay();
}
void draw() {
  background(255);
  s.display();
}
