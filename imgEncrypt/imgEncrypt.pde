import java.util.Scanner;

String keyy = "";
int keyyValuesN[];
int keyyValuesNM[][];
int textValuesN[]; 
int totalValuesN[];
char keyyValuesL[];
String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String text = "";
String image = "";
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
    image = text;
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
    String RGBs = "RGB";
    for(int j = 0; j < state; ++j){
       for(int k = 0; k < state; ++k){
         if(i < 1){
           println(RGBs.charAt(k), ":", textValuesN[k], "Key:", keyyValuesN[keyCounter], keyyValuesN[keyCounter] * textValuesN[k]);
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
    if(i == 0){
      println(red(c2),green(c2),blue(c2));
    }
    img.pixels[i] = c2;
  } //pixels
  img.updatePixels();
  image(img,0,0);
  println(keyy);
  //save("test.jpg");
<<<<<<< HEAD
  String save = "../imgDecrypt/data/" + image;
  img.save(save);
=======
  img.save("../imgDecrypt/data/dog.jpg");
>>>>>>> c1e31200022f19ab9d5d3271489e427fbf9f6ed5
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
    double DD = getDeterminant_r(m);
    int D = (int) DD;
    println(D);
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
int getDeterminant_r(int subm[][]){
  if (subm.length == 1){
    return subm[0][0];
  }
  int D = 0;
  int sign = 1;
  for (int i = 0; i < subm.length; i++){
    int sub[][] = getSub(subm, 0, i);
    int minor = getDeterminant_r(sub);
    D += subm[0][i] * sign * minor;
    sign *= -1;
    //println(D);
  }
  return D;
}

int[][] getSub(int m[][], int R, int C){
  int sub[][] = new int[m.length - 1][m.length - 1];
  for (int i = 0, r = 0; i < m.length; i++){
    if (i != R){
      for (int j = 0, c = 0; j < m[i].length; j++){
        if (j != C){
          sub[r][c] = m[i][j];
          c++;
        }
      }//j
      r++;
    }
  }
  return sub;
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
