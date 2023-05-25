import java.util.Scanner;

String keyy = "";
int keyyValuesN[];
int textValuesN[]; 
char keyyValuesL[];
String alphabet = "ABCDEFGHIIJKLMNOPQRSTUVWXYZ";
String text = "";
boolean accepting = true; //determines if user input is being accepted
String answer = "";

void setup(){
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
    if ((text.length() % 2 != 0) && (text.length() % 3 != 0)
    && ((text.length() % 5 != 0)) && ((text.length() % 7 != 0))){
      println("The length of all secret messages must be a multiple of 2, 3, 5, or 7!");
      accepting = true;
    }
    else{
      answer = encrypt(text);
      //println(text);
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
    println("Current input: " + text);
  }
  //ascii A-Z 65-90 a-z 97-122
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
  String keyL = "";
  textValuesN = new int[L];
  for(int i = 0; i < L; ++i){
    textValuesN[i] = (int(text.charAt(i))) - 65;
    //println(textValuesN[i]);
  }
  for(int i = 0; i < keyState; i++){
    keyyValuesN[i] = int(random(0, 26));
    keyyValuesL[i] = alphabet.charAt(keyyValuesN[i]);
    keyL += alphabet.charAt(keyyValuesN[i]);
  } //makes the key
   println("Key: " + keyL);
  //for(int i = 0; i < NM; ++i){
  //  for(int j = 0; j < state; ++j){
  //      char add;
  //      int total = 0;
  //      for(int k = 0; k < state; ++k){
  //         total += keyyValuesN[j] * textValuesN[k]; 
  //      }
  //      //println(total);
  //      total = total % 26;
  //      println(total);
  //  }
  //}
  return encrypted;
}
