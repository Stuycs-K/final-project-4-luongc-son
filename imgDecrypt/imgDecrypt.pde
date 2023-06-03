import java.util.Scanner;

String keyy = "";
int keyyValuesN[];
int keyyValuesNM[][];
int textValuesN[]; 
int totalValuesN[];
char keyyValuesL[];
int invkeyyValuesNM[][];
int invkeyyValuesN[];
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
  println("Enter the file name of the image you want to decrypt. Press ENTER when done.");
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
        invkeyyValuesN = new int[keyy.length()];
        int Y = (int)sqrt(keyy.length());
        keyyValuesNM = new int[Y][Y];
        invkeyyValuesNM = new int [Y][Y];
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
         decryptImg();
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
    if ((c != '1') && (c != ENTER) && (c != BACKSPACE) && (!((nc >= 65) && (nc <= 90))) 
    && (!((nc >= 97) && (nc <= 122)))){
      println("This is not a valid character!");
    }
  }
}
void decryptImg(){
  println(img.width,img.height);
  img.loadPixels();
  int state = 3;
  textValuesN = new int[3];
  totalValuesN = new int[3];
  if (makeInverseKeyMatrix(keyyValuesNM)){
    int keyCounter = 0; //keeps track of key's indicies
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
              println(RGBs.charAt(k), ": ",textValuesN[k]);
            }
            total+= invkeyyValuesN[keyCounter] * textValuesN[k];
            keyCounter++;
          }//k
          if(i < 1){
            println(total, total % 255);
          }
          total = total % 255;
          colorValues[j] = total;
          total = 0;
        }//j
        keyCounter = 0;
        color c2 = color(colorValues[0],colorValues[1],colorValues[2]);
        img.pixels[i] = c2;
      }//pixels
      img.updatePixels();
      image(img,0,0);
   }
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

boolean makeInverseKeyMatrix(int m[][]){
  int D = (int) getDeterminant(m, m[0].length);
  if (D == 0){
    println("Key matrix is invalid, cannot find inverse!");
    return false;
  }
  int minorMatrix[][] = new int [m[0].length][m[0].length];
  for (int i = 0; i < m[0].length; i++){
    for (int j = 0; j < m[0].length; j++){
      minorMatrix[i][j] = getMinorMatrix(m, i, j);
    }
  }
  int coFact0rs[][] = getCoFact0rMatrix(minorMatrix);
  int adj[][] = transposeV2(coFact0rs);
  
  int MID = multiplicative_inverse_of_determinant(m, m[0].length);
  println("MID: ", MID);
  for (int i = 0; i < m[0].length; i++){
    for (int j = 0; j < m[0].length; j++){
      int temp = (adj[i][j] * MID) % 26;
      if(temp < 0){
        temp += 26;
      }
      invkeyyValuesNM[i][j] = temp;
    }
  }
  int cf = 0;

  for (int r = 0; r < invkeyyValuesNM[0].length; r++){
    for (int c = 0; c < invkeyyValuesNM[0].length; c++){
      invkeyyValuesN[cf] = invkeyyValuesNM[r][c];
      println(invkeyyValuesN[cf]);
      cf++;
    }
  }
  println("===========");
  return true;
}

int[][] getCoFact0rMatrix(int m[][]){
  int cofactors[][] = new int[m.length][m.length];
  for (int i = 0; i < m.length; i++){
    for (int j = 0; j < m.length; j++){
      int CF = (int) ((Math.pow(-1, i + j) * m[i][j]));
      cofactors[i][j] = CF;
    }
  }
  return cofactors;
}

int getMinorMatrix(int m[][], int R, int C){
  int submatrix[][] = new int[m.length - 1][m[0].length - 1];
  for (int i = 0, r = 0; i < m.length; i++){
    if (i != R){
      for (int j = 0, c = 0; j < m[0].length; j++){
        if (j != C){
          submatrix[r][c] = m[i][j];
          c++;
        }
      }
      r++;
    }
  }
  return getDeterminant_r(submatrix);
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

void getCoFact0r(int m[][], int temp[][], int P, int Q, int N){
  int i = 0;
  int j = 0;
  for (int r = 0; r < N; r++){
    for (int c = 0; c < N; c++){
      if (r != P && c != Q){
        temp[i][j++] = m[r][c];
        if (j == N - 1){
          j = 0;
          i++;
        }
      }
    }
  }
}

int[][] adjoint(int m[][]){
  int adj[][] = new int[m[0].length][m[0].length];
  if (m[0].length == 1){
    adj[0][0] = 1;
    return adj;
  }
  int sign = 1;
  int N = m[0].length;
  int temp[][] = new int[N][N];
  for (int i = 0; i < N; i++){
    for (int j = 0; j < N; j++){
      getCoFact0r(m, temp, i, j, N);
      sign = ((i + j) % 2 == 0)? 1 : -1;
      adj[j][i] = (sign * (determinant(temp, N - 1)));
      while (adj[j][i] < 0){
        adj[j][i] += 26;
      }
      adj[j][i] = adj[j][i] % 26;
    }
  }
  return adj;
}
int[][] transposeV2(int m[][]){
  int t[][] = new int[m[0].length][m[0].length];
  for (int i = 0; i < m[0].length; i++){
    for (int ii = 0; ii < m[0].length; ii++){
      t[ii][i] = m[i][ii];
    }
  }
  return t;
}

void display(int m[][]){
  int counter = 0;
  for (int r = 0; r < m[0].length; r++){
    for (int c = 0; c < m[0].length; c++){
      println("COUNTER: " + counter + " / " + m[r][c]);
      counter++;
    }
  }
}

int determinant(int m[][], int n){
  int D = 0;
  if (n == 1){
    return m[0][0];
  }
  int [][] tmp = new int[m[0].length][m[0].length];
  int sign = 1;
  for (int fr = 0; fr < n; fr++){
    getCoFact0r(m, tmp, 0, fr, n);
    D += sign * m[0][fr] * determinant(tmp, n - 1);
    sign *= -1;
  }
  return D;
}

int multiplicative_inverse_of_determinant(int m[][], int s){
  int D = ((int) getDeterminant_r(m)) % 26;
  if(D < 0){
    D += 26;
  }
  println("Determinant: ",D);
  for (int z = 1; z <= 999999999; z++){
    //println(z);
    if (((D * z) % 26) == 1){
      return z;
    }
  }
  return -1;
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
