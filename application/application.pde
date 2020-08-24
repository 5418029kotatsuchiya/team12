
class Wall {
  int[] printNumber1,printNumber2,printNumber3;
  int cnt = 0;
  int r;
  int zanki = 3;
  int question;
  void calc() {
    //easyの時
    int num = (int)random(50,200);
    /*normal
    int num = (int)random(500,1000);
    hard
    int num = (int)random(7000,10000);
    */
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
      printNumber2[i] = int(random(2,15));
      printNumber3[i] = int(random(2,15));
    }
    //間違いである選択肢が正解と被らないようにする。
    for(int i = 0;i < cnt;i++) {  
      for(int j = 0;j < cnt;j++) {
        while(printNumber2[i] == printNumber1[j]|| isPrime(printNumber2[i]) == 1){
          printNumber2[i] = int(random(2,20));
          j=0;
        }
      }
    }
    for(int i = 0;i < cnt;i++) {  
      for(int j = 0;j < cnt;j++) {
        while(printNumber3[i] == printNumber1[j] ||  printNumber3[i] == printNumber2[i] || isPrime(printNumber3[i]) == 1){
          printNumber3[i] = int(random(2,20));
          j=0;
        }
      }
      println(printNumber1[i] + " " + printNumber2[i]+" " +printNumber3[i]);
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
      noLoop();
    }else if(question == 1){
      //これ以上分解する要素がないのでゲームクリア、ゲーム終了画面へ
      noLoop();
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
          question /= printNumber1[cnts-1];
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
          question /= printNumber1[cnts-1];
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
           question /= printNumber1[cnts-1];
        }
     }
     cnts++;
  }
      
}
  


Wall w;

int cnts = 0; //壁に表示数る数字の配列の番号、壁を更新するために必要

void setup() {
  size(600,800);
  w = new Wall();
}
void draw() {
  
  background(0);
  w.drawWall(cnts-1);
}
void mouseClicked(){
  loop();
  w.brokenWall();
}
