import java.util.Scanner;

String keyy = "";
int keyyValuesN[];
int textValuesN[]; 
int totalValuesN[];
char keyyValuesL[];
String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
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
      println("ENCRYPTED: " + answer);
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
  textValuesN = new int[L];
  totalValuesN = new int[L];
  for(int i = 0; i < L; i++){
    textValuesN[i] = (int(text.charAt(i))) - 65;
    println(textValuesN[i]);
  }
  for(int i = 0; i < keyState; i++){
    keyyValuesN[i] = int(random(0, 26));
    keyyValuesL[i] = alphabet.charAt(keyyValuesN[i]);
    keyy += alphabet.charAt(keyyValuesN[i]);
  } //makes the key
  println("Key: " + keyy);
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
  // START OF ENCRYPTION - VERSION 1
  //for(int i = 0; i < NM; ++i){
  //  for(int j = 0; j < state; ++j){
  //      char add;
  //      int total = 0;
  //      for(int k = 0; k < state; ++k){
  //          println("Multiplying: ", keyyValuesN[j * state + k], textValuesN[k]);
  //         total += keyyValuesN[j * state +k] * textValuesN[k]; 
  //      }
  //      println(total);
  //      total = total % 26;
  //      println(total);
  //      add = char(total + 65);
  //      println(add);
  //      encrypted += add;
  //  }
  //}
  
  return encrypted;
}
