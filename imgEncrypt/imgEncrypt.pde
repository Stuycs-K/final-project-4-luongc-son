import java.util.Scanner;

String keyy = "";
int keyyValuesN[];
int keyyValuesNM[][];
int textValuesN[]; 
int totalValuesN[];
char keyyValuesL[];
String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String text = "";
boolean accepting = true; //determines if user input is being accepted
boolean keyAccepted = false; //determines if key matrix is valid
String answer = "";

void setup(){
  size(400,400);
  println("Enter the file name of the image you want to encrypt. Press ENTER when done.");
}
void draw(){
}

void keyPressed(){
  if (keyPressed && accepting){
    char c = key;
    keyAction(c);
  }
}

void keyAction(char c){
  if (c == ENTER){
    accepting = false;
    PImage img;
    img = loadImage(text); //to stop program if file doesn't work
    image(img,0,0);
    encryptImg(text);
  }
  if (c == BACKSPACE){
    String newtext = "";
    if (text.length() >= 1){
      for (int i = 0; i < text.length() - 1; i++){
        char cc = text.charAt(i);
        newtext = newtext + Character.toString(cc);
        
      }
      text = newtext;
    }
    println("Current input: " + text);
  }
  //ascii A-Z 65-90 a-z 97-122
  if(c != BACKSPACE){
    int nc = ((int) c);
    char addc = char(nc);
    String add = "" + addc;
    text += add;
    println(text);
  }
  int nc = ((int) c);
  if ((c != ENTER) && (c != BACKSPACE) && (c != 46) && (!((nc >= 65) && (nc <= 90))) 
  && (!((nc >= 97) && (nc <= 122)))){
    println("This is not a valid character!");
  }
}

void encryptImg(String filename){
  
}

boolean coprime(int x, int y){
  return (gcd(x, y) == 1);
}

int gcd(int x, int y){
  if (y == 0){
    return x;
  }
  return gcd(y, x % y);
}

void finalize_key(int L, int state, int keyState, int m[][]){
  while (keyAccepted == false){
    genKey(L, keyState);
    double DD = getDeterminant(m, state);
    int D = (int) DD;
    if ((coprime(D, 26) == true) && (D > 0)){
      keyAccepted = true;
    }
  }
}
void genKey(int L, int keyState){
  keyy = "";
  int s = (int) sqrt(keyState);
  for(int i = 0; i < L; i++){
    textValuesN[i] = (int(text.charAt(i))) - 65;
    //println(textValuesN[i]);
  }
  for(int i = 0; i < keyState; i++){
    keyyValuesN[i] = int(random(0, 26));
    keyyValuesL[i] = alphabet.charAt(keyyValuesN[i]);
    keyy += alphabet.charAt(keyyValuesN[i]);
  } //makes the key 
  int KC = 0;
  for (int i = 0; i < s; i++){
    for (int j = 0; j < s; j++){
      keyyValuesNM[i][j] = keyyValuesN[KC];
      //println(keyyValuesNM[i][j]);
      KC++;
    }
  }
}

double getDeterminant(int m[][], int s){
  double D = 0;
  if (s == 1){
    D = m[0][0];
  }
  else if (s == 2){
    D = (m[0][0] * m[1][1]) - (m[1][0] * m[0][1]);
  }
  else{
    for (int j = 0; j < s; j++){
      D += Math.pow(-1.0, 1.0 + j + 1.0) * m[0][j] * getDeterminant(m, s - 1);
    }
  }
  return D;
}
