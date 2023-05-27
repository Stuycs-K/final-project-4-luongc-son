import java.util.Scanner;

String keyy = "";
String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String text = ""; //ciphertext
String answer = "";
boolean acceptingText = true;
boolean acceptingKey = false;

void setup(){
  println("Enter the ciphertext you want to decrypt: ");
}

void draw(){
}

void keyPressed(){
  if (keyPressed && acceptingText == true && acceptingKey == false){
    char c = key;
    keyAction(c, -1);
  }
  if (keyPressed && acceptingKey == true && acceptingText == false){
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
    if (c == ENTER){
      acceptingKey = false;
      answer = decrypt(text);
      println("DECRYPTED: " + answer);
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
      println("Current key input: " + text);
    }
  }
}

String decrypt(String text){
  String decrypted = "";
  return decrypted;
}
