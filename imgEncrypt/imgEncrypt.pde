import java.util.Scanner;

String keyy = "";
int keyyValuesN[];
int keyyValuesNM[][];
int textValuesN[]; 
int totalValuesN[];
char keyyValuesL[];
String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String text = "";
boolean accepting = true; //determines if user input is being accepted
boolean keyAccepted = false; //determines if key matrix is valid
String answer = "";

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
    PImage img;
    img = loadImage(text);
    image(img,0,0);
    encryptImg(text);
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

void encryptImg(String filename){
  
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
