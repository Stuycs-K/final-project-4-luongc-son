import java.util.Scanner;

import java.util.Scanner;

String keyy = "";
int keyyValuesN[];
int keyyValuesNM[][];
int textValuesN[]; 
int totalValuesN[];
char keyyValuesL[];
String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String text = "";
boolean acceptingText = true; //determines if user input is being accepted
boolean acceptingKey = false;
boolean keyAccepted = false; //determines if key matrix is valid
String answer = "";
int length_checker = 3;
PImage img;

void setup(){
  size(400,400);
  println("Enter the file name of the image you want to encrypt. Press ENTER when done.");
}

void draw(){
}

void keyPressed(){
  if (keyPressed && acceptingText == true){
    char c = key;
    keyAction(c,-1);
  }
   if (keyPressed && acceptingKey == true){
    char c = key;
    keyAction(c, 1);
  }
}

void keyAction(char c, int KT){
  if (KT < 0){ //for ciphertext input
    if (c == ENTER){
      acceptingText = false;
      acceptingKey = true;
      img = loadImage(text); //to stop program if file doesn't work
      image(img,0,0);
      println("Now enter a nine letter long key and press \"1\" when done");
      //encryptImg();
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
      println("Current filename input: " + text);
    }
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
  else { //for key input
    if (c == '1'){
      if ((keyy.length()) != 9){
        println("Key length is invalid! Try again. Press \"1\" when done.");
        acceptingKey = true;
      }
      else{
        acceptingKey = false;
        keyyValuesN = new int[keyy.length()];
        keyyValuesL = new char[keyy.length()];
        int Y = (int)sqrt(keyy.length());
        keyyValuesNM = new int[Y][Y];
        for (int i = 0; i < keyy.length(); i++){
          keyyValuesL[i] = keyy.charAt(i);
          String temp = Character.toString(keyy.charAt(i));
          for (int ii = 0; ii < 26; ii++){
            char y = alphabet.charAt(ii);
            String temptemp = Character.toString(y);
            if (temptemp.equals(temp) == true){
              keyyValuesN[i] = alphabet.charAt(ii) - 65;
            }
          }
        }
        int xyz = 0;
        for (int j = 0; j < length_checker; j++){
          for (int jj = 0; jj < length_checker; jj++){
            keyyValuesNM[j][jj] = keyyValuesN[xyz];
            xyz++;
          }
        }
         encryptImg();
      }
    }
    if (c == BACKSPACE){
      String newkeyy = "";
      if (keyy.length() >= 1){
        for (int i = 0; i < keyy.length() - 1; i++){
          char cc = keyy.charAt(i);
          newkeyy = newkeyy + Character.toString(cc);
        }
        keyy = newkeyy;
      }
      println("Current key input: " + keyy);
    }
    int nc = ((int) c);
    if ((nc >= 97) && (nc <= 122)){
      String s = Character.toString(c);
      s = s.toUpperCase();
      nc = nc - 32;
    }
    if ((nc >= 65) && (nc <= 90)){
      char addc = char(nc);
      String add = "" + addc;
      keyy += add;
      println(keyy);
    }
    if ((c != '1') && (c != BACKSPACE) && (!((nc >= 65) && (nc <= 90))) 
    && (!((nc >= 97) && (nc <= 122)))){
      println("This is not a valid character!");
    }
  }
}

void encryptImg(){
  println(img.width,img.height);
  img.loadPixels();
  int state = 3;
  int keyState = 9;
  textValuesN = new int[3];
  totalValuesN = new int[3];
  keyyValuesN = new int [9];
  keyyValuesNM = new int[state][state];
  genKey(3,9);
  int keyCounter = 0;
  int total = 0;
  for(int i = 0; i < img.pixels.length; ++i){
    color c = img.pixels[i];
    textValuesN[0] = int(red(c));
    textValuesN[1] = int(green(c));
    textValuesN[2] = int(blue(c));
    int colorValues[];
    colorValues = new int[3];
    for(int j = 0; j < state; ++j){
       for(int k = 0; k < state; ++k){
        total += keyyValuesN[keyCounter] * textValuesN[k];
        keyCounter++;
       }//k
       total = total % 255;
       colorValues[j] = total;
       total = 0;
    }//j
    keyCounter = 0;
    color c2 = color(colorValues[0],colorValues[1],colorValues[2]);
    img.pixels[i] = c2;
  } //pixels
  img.updatePixels();
  image(img,0,0);
  println(keyy);
  img.save("encryptedImg.jpg");
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

void genKey(int L, int keyState){
  int s = (int) sqrt(keyState);
  for(int i = 0; i < L; i++){
    textValuesN[i] = (int(text.charAt(i))) - 65;
    //println(textValuesN[i]);
  }
  for(int i = 0; i < keyState; i++){
    println(i);
    keyyValuesN[i] = (int(keyy.charAt(i))) - 65;
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
