class Wall {
}

class Human {
  int x = 500;
  int y = 300;
  
  void display() {
    stroke(0);
    fill(150);
    rect(x, y, 20, 100);
    fill(255);
    ellipse(x, y-30, 60, 60);
    fill(0);
    stroke(0);
    line(x-10, y+50, x-20, y+60);
    line(x+10, y+50, x+20, y+60);
  }
}

Human h;

void setup() {
size(600,800);
background(255);
}
void draw() {
  
}
