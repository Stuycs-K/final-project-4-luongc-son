import java.util.Scanner;

String keyy = "ACT";
String alphabet = "ABCDEFGHIIJKLMNOPQRSTUVWXYZ";
String text = "";
boolean accepting = true; //determines if user input is being accepted

void setup(){
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
      encrypt(text);
    }
  }
  if (c == BACKSPACE){
    if (text.length() >= 1){
      for (int i = 0; i < text.length() - 1; i++){
        char cc = text.charAt(i);
        String newtext = Character.toString(cc);
        text = newtext;
      }
    }
    println("Current input: " + text);
  }
}

void encrypt(String text){
}
