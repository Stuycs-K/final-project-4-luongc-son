import java.util.Scanner;
import pallav.Matrix.*;

String keyy = "";
String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String text = ""; //ciphertext
String answer = "";
int length_checker = 0;
boolean acceptingText = true;
boolean acceptingKey = false;
int keyyValuesN[];
int keyyValuesNM[][];
char keyyValuesL[];
int textValuesN[];
int totalValuesN[];
float keyyValuesF[];
float keyyValuesFM[][];
float invkeyyValuesFM[][];
int invkeyyValuesNM[][];
int invkeyyValuesN[];

void setup(){
  println("Enter the ciphertext you want to decrypt. Press ENTER when done.");
}

void draw(){
}

void keyPressed(){
  if (keyPressed && acceptingText == true){
    char c = key;
    keyAction(c, -1);
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
      if ((text.length() % 2 != 0) && (text.length() % 3 != 0)
      && ((text.length() % 5 != 0)) && ((text.length() % 7 != 0))){
        println("The length of all secret messages must be a multiple of 2, 3, 5, or 7!");
        acceptingText = true;
      }
      else{
        acceptingText = false;
        acceptingKey = true;
        if (text.length() % 2 == 0){
          length_checker = 2;
        }
        else if (text.length() % 3 == 0){
          length_checker = 3;
        }
        else if (text.length() % 5 == 0){
          length_checker = 5;
        }
        else if (text.length() % 7 == 0){
          length_checker = 7;
        }
        println("Enter the key for the ciphertext. Press \"1\" when done." );
        //println("TEXT: " + text);
      }
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
      println("Current ciphertext input: " + text);
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
      text += add;
      println(text);
    }
    if ((c != ENTER) && (c != BACKSPACE) && (!((nc >= 65) && (nc <= 90))) 
    && (!((nc >= 97) && (nc <= 122)))){
      println("This is not a valid character!");
    }
  }
  else { //for key input
    if (c == '1'){
      if ((keyy.length()) != (length_checker * length_checker)){
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
              keyyValuesN[i] = alphabet.charAt(ii);
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
        answer = decrypt(text);
        println("DECRYPTED: " + answer);
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

String decrypt(String text){
  String decrypted = "";
  makeInverseKeyMatrix();
  int keyCounter = 0; //keeps track of key's indicies
  int messageCounter = 0; //keeps track of message's component's indicies
  int MCD = 0; //number of matrix components done
  int total = 0;
  int totalCounter = 0;
  int NM = textValuesN.length / length_checker;
  for (int i = 0; i < NM; i++){ //break up message into manageable components
    for (int j = 0; j < length_checker; j++){ //runs through the key's matrix
      for (int k = 0; k < length_checker; k++){ //runs through the message's components
        total += invkeyyValuesN[keyCounter] * textValuesN[(MCD * length_checker) + messageCounter];
        keyCounter++;
        messageCounter++;
      } //k
      total = total % 26;
      totalValuesN[totalCounter] = total;
      total = 0;
      messageCounter = messageCounter - length_checker;
      totalCounter++;
    } //j
    keyCounter = 0;
    MCD++;
  } //i
  for (int i = 0; i < keyyValuesN.length; i++){
    char R = alphabet.charAt(totalValuesN[i]);
    String r = Character.toString(R);
    decrypted += r;
  }
  return decrypted;
}

void makeInverseKeyMatrix(){
  keyyValuesF = new float[keyyValuesN.length];
  for (int i = 0; i < keyyValuesN.length; i++){
    keyyValuesF[i] = (float) keyyValuesN[i];
  }
  int fm = (int) sqrt(keyyValuesN.length);
  int cf = 0;
  keyyValuesFM = new float[fm][fm];
  invkeyyValuesFM = new float[fm][fm];
  for (int ii = 0; ii < fm; ii++){
    for (int iii = 0; iii < fm; iii++){
      keyyValuesFM[ii][iii] = keyyValuesF[cf];
      cf++;
    }
  }
  cf = 0;
  invkeyyValuesNM = new int[fm][fm];
  invkeyyValuesN = new int[fm * fm];
  invkeyyValuesFM = Matrix.inverse(keyyValuesFM);
  for (int r = 0; r < fm; r++){
    for (int c = 0; c < fm; c++){
      invkeyyValuesFM[r][c] = invkeyyValuesFM[r][c] % 26;
      invkeyyValuesNM[r][c] = (int) invkeyyValuesFM[r][c];
      invkeyyValuesN[cf] = invkeyyValuesNM[r][c];
      cf++;
    }
  }
}

int multiplicative_inverse_of_determinant(int m[][], int s){
  int D = ((int) getDeterminant(m, s)) % 26;
  boolean Z = true;
  int z = 0;
  while (Z == true){
    z++;
    if (((D * z) % 26) == 1){
      Z = false;
    }
  }
  return z;
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
