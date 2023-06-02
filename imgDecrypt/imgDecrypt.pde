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
int length_checker = 3;
PImage img;

void setup(){
  size(400,400);
  println("Enter the file name of the image you want to decrypt. Press ENTER when done.");
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
