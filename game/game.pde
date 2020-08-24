//easy選択で乱数50-200,normal500-1000で問いの数字減り
//hard選択で7000-10000の問いの数字そのまま
//ゲームフロー0(start)->1(wall&human)->2(end)
PFont font;

class EndDisplay {
  int x = width/2;
  int y = height/2;
  int w = 260;
  int h = 90;
  void display() {
    rectMode(CENTER);
    textSize(110);
    fill(0);
    text("SCORE", 100, 150);//ほかクラスで出したスコアをかきたい
    textSize(70);
    strokeWeight(12);
    strokeJoin(ROUND);
    //ほかクラスで書いたスコアをかきたい
    stroke(#CEF5FF);
    fill(#CEF5FF);
    rect(x, y-125, w, h);
    fill(0);
    text("ここにスコア", 230, 295);
    stroke(#6AE0FF);
    fill(#6AE0FF);
    rect(x, y+25, w, h);
    fill(0);
    text("Replay", 200, 450);
    stroke(#27B8FF);
    fill(#27B8FF);
    rect(x, y+175, w, h);
    fill(0);
    text("Home", 205, 600);
    if(mousePressed){
      if(mouseX >= x && mouseX <= x + w){
        if(mouseY >= y+25 && mouseY <= y +25 + h){
          gameflow = 1;
          gameflow++;
          print(1);
        }else if(mouseY >= y+175 && mouseY <= y +175 + h){
          gameflow = 0;
          gameflow++;
          print(1);
        }
      }
    }
  }
}


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
    if(mousePressed){
      if(mouseX >= x && mouseX <= x + w){
        if(mouseY >= y-125 && mouseY <= y -125 + h){
          easy = true;
          gameflow++;
          print(1);
        }else if(mouseY >= y+25 && mouseY <= y +25 + h){
          normal = true;
          gameflow++;
          print(1);
        }else if(mouseY >= y+175 && mouseY <= y +175 + h){
          hard = true;
          gameflow++;
          print(1);
        }
      }
    }
  }
}


class Wall {
  int[] printNumber1,printNumber2,printNumber3;
  int cnt = 0;
  int r;
  int zanki = 3;
  int question;
  int num;
  void calc() {
    //easyの時
    if(easy){
      num = (int)random(50,200);
    }
    if(normal) {
      num = (int)random(500,1000);
    }
    if(hard) {
      num = (int)random(7000,10000);
    }
    //問いは素数にしたくない
    while(isPrime(num) == 0) {
      num = (int)random(50,200);
    }
    question = num;
    println(num);
    //素因数分解の元
    int nums[] = new int[100];
    //素因数分解実行
    for(int i = 2;i <= num;i++) {
      while(num % i == 0) {
        //素因数分解の値を格納
        nums[cnt] = i;
        cnt++;
        num /= i;
      }
    }
    printNumber1 = new int[cnt];
    printNumber2 = new int[cnt];
    printNumber3 = new int[cnt];
    for(int i = 0;i < cnt;i++) {
      //配列printNumber1に正解を格納、printNumber2、printNumber3に間違いを格納。
      printNumber1[i] = nums[i];
      if(easy) {
        printNumber2[i] = int(random(2,15));
        printNumber3[i] = int(random(2,15));
      }
      if(normal){
        printNumber2[i] = int(random(2,100));
        printNumber3[i] = int(random(2,100));
      }
      if(hard){
        printNumber2[i] = int(random(2,500));
        printNumber3[i] = int(random(2,500));
      }
    }
    //間違いである選択肢が正解と被らないようにする。
    for(int i = 0;i < cnt;i++) {  
      for(int j = 0;j < cnt;j++) {
        while(printNumber2[i] == printNumber1[j]|| isPrime(printNumber2[i]) == 1){
          if(easy) {
            printNumber2[i] = int(random(2,15));
          }
          if(normal){
            printNumber2[i] = int(random(2,100));
          }
          if(hard){
            printNumber2[i] = int(random(2,500));
          }
          j=0;
        }
      }
    }
    for(int i = 0;i < cnt;i++) {  
      for(int j = 0;j < cnt;j++) {
        while(printNumber3[i] == printNumber1[j] ||  printNumber3[i] == printNumber2[j] || isPrime(printNumber3[i]) == 1){
          if(easy) {
            printNumber3[i] = int(random(2,15));
          }
          if(normal){
            printNumber3[i] = int(random(2,100));
          }
          if(hard){
            printNumber3[i] = int(random(2,500));
          }
          j=0;
        }
      }
    }
      
    //関数呼び出し、この時kは配列の最右要素の添字
    cnts++;
    drawWall(cnts-1);
  }
  
  private int isPrime(int num){
    for(int i = 2;i < num;i++){
      if(num % i == 0){
        return 1;
      }
    }
    return 0;
  }
  void drawWall(int i) {
    if(cnts == 0){
      //初回のみ素因数分解
      calc();
    }else if(zanki < 0){
      //残機マイナスよりゲームオーバー、ゲーム終了画面へ
      print(2);
      gameflow++;
    }else if(question == 1){
      //これ以上分解する要素がないのでゲームクリア、ゲーム終了画面へ
      print(1);
      gameflow++;
    }else if(i < printNumber1.length){
      fill(255);
      rect(width / 2 - 50,height/4 - 150,100,100);
      fill(0);
      textSize(25);
      
      text(str(question),width/2 - 10,height / 4 - 100);
     
      //3つの壁左->中央->右
      fill(255);
      rect(width/4 - 50,height/4,100,100);
      rect(width / 2 - 50,height/4,100,100);
      rect(width*3/4 - 50,height/4,100,100);
      fill(255,0,0);
      //赤丸残機数表示　
      if(zanki == 3){
        ellipse(200,500,50,50);
        ellipse(300,500,50,50);
        ellipse(400,500,50,50);
      }else if(zanki == 2){
        ellipse(200,500,50,50);
        ellipse(300,500,50,50);
      }else if(zanki == 1){
        ellipse(200,500,50,50);
      }
      r = int(random(3));
      fill(0);
      //壁の中に選択肢がランダムに現れる。
      if(r == 0){
        //左の壁が正解
        text(str(printNumber1[i]),width/4 -10,height / 4 + 50);
        text(str(printNumber2[i]),width/2 -10,height / 4 + 50);
        text(str(printNumber3[i]),width*3/4 -10,height / 4 + 50);
      }else if(r == 1){
        //中央の壁が正解
        text(str(printNumber2[i]),width/4 - 10,height / 4 + 50);
        text(str(printNumber1[i]),width/2 -10 ,height / 4 + 50);
        text(str(printNumber3[i]),width*3/4 -10 ,height / 4 + 50);
      }else {
        //右の壁が正解
        text(str(printNumber2[i]),width/4 - 10,height / 4 + 50);
        text(str(printNumber3[i]),width/2  -10 ,height / 4 + 50);
        text(str(printNumber1[i]),width*3/4 -10,height / 4 + 50);
      }
      noLoop();
    }
  }
  void brokenWall(){
    stroke(50);
    //左壁の判定
      if(mouseX >= width / 4-50 && mouseY >= height / 4 && 
      mouseX <= width / 4 + 50 && mouseY <= height / 4 + 100){
        if(r == 0) {
          //正解の時、上壁に表示する整数questionを選んだ正解の整数で割る
          if(easy || normal) {
            question /= printNumber1[cnts-1];
          }
        }else if(r == 1){
          //間違いの時残機をマイナス、
          zanki--;
          cnts--;
        }else {
          zanki--;
          cnts--;
        }
      }else if(mouseX >= width / 2 -50&& mouseY >= height / 4 && 
      mouseX <= width / 2 + 50 && mouseY <= height / 4 + 100){//中壁の判定
        if(r == 0) {
          zanki--;
         cnts--;
        }else if(r == 1){
          if(easy || normal) {
            question /= printNumber1[cnts-1];
          }
        }else {
          zanki--;
          cnts--;
        }
      }else if(mouseX >= width*3 / 4 -50 && mouseY >= height / 4 && 
      mouseX <= width*3 / 4 + 50 && mouseY <= height / 4 + 100){//右壁の判定
        if(r == 0) {
          zanki--;
         cnts--;
        }else if(r == 1){
          zanki--;
          cnts--;
        }else {
          if(easy || normal) {
           question /= printNumber1[cnts-1];
          }
        }
     }
     cnts++;
  }
      
}

 
class Human {
  int x = width/2;
  int y = height*3/4;
  int size = width/6;
  void display() {
    fill(0);
    ellipse(x, y, size, size);//頭
    stroke(0);
    line(x, y+size/2, x, y+size*3/2);//胴体
    line(x, y+size/2+30, x-50, y+size*3/2-50);//左手
    line(x, y+size/2+30, x+50, y+size*3/2-50);//右手
    line(x, y+size*3/2, x-30, height);//左足
    line(x, y+size*3/2, x+30, height);//右足
    println(x);
  }
  void move() {
    if (keyPressed == true) {
      if ( keyCode == RIGHT) {
        println("right");
        x = x + 50;
        if(x >= 300) {
          x = 300;
        }
        println(x);
      } 
      if ( keyCode == LEFT) {
        println("left");
        x = x - 100;
        if(x <= 100) {
          x = 100;
        }
      }
    }
  }
}  


StartDisplay s;
EndDisplay e;
Wall w;
Human h;

int cnts = 0; //壁に表示数る数字の配列の番号、壁を更新するために必要
int gameflow=0;
boolean easy=false;
boolean normal = false;
boolean hard = false;

void setup() {
  size(600, 800);
  font = loadFont("Arimo-Bold-36.vlw");
  textFont(font);
  e = new EndDisplay();
  s = new StartDisplay();
  w = new Wall();
  h = new Human();
}
void draw() {
  if(gameflow == 0){
    s.display();
  }else if(gameflow == 1){
    background(0,255,255);
    noStroke();
    rectMode(CORNER);
    w.drawWall(cnts-1);
    ellipseMode(CENTER);
    rectMode(CENTER);
     h.display();
     h.move();
  }else if(gameflow == 2){
    background(255);
    e.display();
  }
}

void mouseClicked(){
  if(gameflow==1){
    loop();
    w.brokenWall();
  }
}
