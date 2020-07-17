PFont font;

class Wall {
}

class Human {
}

//これをどうやってクラスにするかわからない,,,
void setup() {
  size(600, 800);
  background(255);
  font = loadFont("Arimo-Bold-36.vlw");
  textFont(font);
}
void draw() {
  textSize(110);
  fill(0);
  text("GAME", 150, 150);
  textSize(70);
  strokeWeight(12);
  strokeJoin(ROUND);
  stroke(#CEF5FF);
  fill(#CEF5FF);
  rect(180, 230, 260, 90);
  fill(0);
  text("easy", 230, 295);
  stroke(#6AE0FF);
  fill(#6AE0FF);
  rect(175, 380, 260, 90);
  fill(0);
  text("nomal", 200, 450);
  stroke(#00CAFF);
  fill(#00CAFF);
  rect(180, 530, 260, 90);
  fill(0);
  text("hard", 235, 600);
}
