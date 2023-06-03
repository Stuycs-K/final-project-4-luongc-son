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
PImage img;

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
    img = loadImage(text); //to stop program if file doesn't work
    image(img,0,0);
    encryptImg();
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

void encryptImg(){
  println(img.width,img.height);
  img.loadPixels();
  int state = 3;
  int keyState = 9;
  textValuesN = new int[3];
  totalValuesN = new int[3];
  keyyValuesN = new int [9];
  keyyValuesNM = new int[state][state];
  finalize_key(3,state,keyState,keyyValuesNM);
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
         if(i < 1){
           println(textValuesN[k], keyyValuesN[keyCounter] * textValuesN[k]);
         }
        total += keyyValuesN[keyCounter] * textValuesN[k];
        keyCounter++;
       }//k
       
       total = total % 255;
       if(i < 1){
         println("TOTAL: ", total);
       }
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
  //save("test.jpg");
  img.save("../imgDecrypt/data/dog.jpg");
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
    //println(i);
    keyyValuesN[i] = int(random(0, 26));
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
