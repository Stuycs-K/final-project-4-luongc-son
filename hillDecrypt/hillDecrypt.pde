import java.util.Scanner;

String keyy = "";
String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String text = ""; //ciphertext
String answer = "";
int length_checker = 0;
boolean acceptingText = true;
boolean acceptingKey = false;

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
    if ((c != ESC) && (c != BACKSPACE) && (!((nc >= 65) && (nc <= 90))) 
    && (!((nc >= 97) && (nc <= 122)))){
      println("This is not a valid character!");
    }
  }
}

String decrypt(String text){
  String decrypted = "";
  return decrypted;
}
