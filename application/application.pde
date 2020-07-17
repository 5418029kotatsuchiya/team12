class Human {
  int headX,headY,armX,armY;
  
  
}

class Wall {
  int[] printNumber1,printNumber2,printNumber3;
  void calc() {
  int cnt = 0;
  int num = (int)random(10,100);
  //store  prime factrization
  int nums[] = new int[100];
  //prime factrization
  for(int i = 2;i < num;i++) {
    while(num % i == 0) {
      nums[cnt] = i;
      cnt++;
      num /= i;
    }
  }
  printNumber1 = new int[cnt];
  printNumber2 = new int[cnt];
  printNumber3 = new int[cnt];
  for(int i = 0;i < cnt;i++) {
    printNumber1[i] = nums[i];
    
    //call broken method
    brokenWall();
    
    printNmuber2[i] = random(2,15);
    printNmuber3[i] = random(2,15);
    
    for(int j = 0;j < cnt;j++) {
      while(printNumber2[i] == nums[j] || printNumber3[i] == nums[j]){
        printNumber2[i] = random(2,15);
        printNumber3[i] = random(2,15);
      }
    }
  }
}


void setup() {

}
void draw() {
}
