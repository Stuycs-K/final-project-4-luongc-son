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
int length_checker = 0;

void setup(){
  println("Enter the secret message you want to encrypt. Press ENTER when done.");
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
        textValuesN = new int[text.length()];
        totalValuesN = new int[text.length()];
        for (int i = 0; i < text.length(); i++){
          char w = text.charAt(i);
          int NL = ((int) w);
          NL = NL - 65;
          textValuesN[i] = NL;
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
        answer = encrypt(text);
        println("ENCRYPTED: " + answer);
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

String encrypt(String text){
  String encrypted = "";
  int state = 0; //state is supposed to represent the size of the 
  int keyState = 1;
  int L = text.length();
  if ((L % 2) == 0){
    state = 2;
    keyState = 4;
  } 
  else if((L % 3) == 0){
    state = 3;
    keyState = 9;
  } 
  else if((L % 5) == 0){
    state = 5;
    keyState = 25;
  } 
  else if((L % 7) == 0){
    state = 7;
    keyState = 49;
  }
  int NM = L / state; //represents the number of matrices the secret message is split into
  //println(NM);
  keyyValuesN = new int[keyState];
  keyyValuesL = new char[keyState];
  keyyValuesNM = new int[state][state];
  textValuesN = new int[L];
  totalValuesN = new int[L];
//KEY
  println("Key: " + keyy);
    genKey(L,keyState);
  int keyCounter = 0; //keeps track of key's indicies
  int messageCounter = 0; //keeps track of message's component's indicies
  int MCD = 0; //number of matrix components done
  int total = 0;
  int totalCounter = 0;
  for (int i = 0; i < NM; i++){ //break up message into manageable components
    for (int j = 0; j < state; j++){ //runs through the key's matrix
      for (int k = 0; k < state; k++){ //runs through the message's components
        total += keyyValuesN[keyCounter] * textValuesN[(MCD * state) + messageCounter];
        keyCounter++;
        messageCounter++;
      } //k
      total = total % 26;
      totalValuesN[totalCounter] = total;
      total = 0;
      messageCounter = messageCounter - state;
      totalCounter++;
    } //j
    keyCounter = 0;
    MCD++;
  } //i
  for (int i = 0; i < L; i++){
    char Q = alphabet.charAt(totalValuesN[i]);
    String q = Character.toString(Q);
    encrypted += q;
  }
  return encrypted;
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
    keyyValuesN[i] = (int(keyy.charAt(i))) - 65;
    keyyValuesL[i] = alphabet.charAt(keyyValuesN[i]);
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
  //else if (s == 2){
  //  D = (m[0][0] * m[1][1]) - (m[1][0] * m[0][1]);
  //}
  else{
    for (int j = 0; j < s; j++){
      D += Math.pow(-1.0, 1.0 + j + 1.0) * m[0][j] * getDeterminant(m, s - 1);
    }
  }
  return D;
}
