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
        invkeyyValuesN = new int[keyy.length()];
        int Y = (int)sqrt(keyy.length());
        keyyValuesNM = new int[Y][Y];
        invkeyyValuesNM = new int[Y][Y];
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
  if (makeInverseKeyMatrix(keyyValuesNM)){
    int keyCounter = 0; //keeps track of key's indicies //<>//
    int messageCounter = 0; //keeps track of message's component's indicies //<>//
    int MCD = 0; //number of matrix components done //<>//
    int total = 0;
    int totalCounter = 0;
    int NM = textValuesN.length / length_checker; //<>//
    println("==============================");
    for (int i = 0; i < NM; i++){ //break up message into manageable components //<>//
      for (int j = 0; j < length_checker; j++){ //runs through the key's matrix //<>//
        for (int k = 0; k < length_checker; k++){ //runs through the message's components
          total += invkeyyValuesN[keyCounter] * textValuesN[(MCD * length_checker) + messageCounter];
          println(invkeyyValuesN[keyCounter], textValuesN[(MCD * length_checker) + messageCounter]);
          keyCounter++;
          messageCounter++;
        } //k
        println("TOTAL: ", total);
        total = total % 26;
        totalValuesN[totalCounter] = total;
        total = 0;
        messageCounter = messageCounter - length_checker;
        totalCounter++;
      } //j
      keyCounter = 0;
      MCD++;
    } //i
     //println("=========================");
    for (int i = 0; i < text.length(); i++){
      while (totalValuesN[i] < 0){
        totalValuesN[i] += 26;
      }
      //println(totalValuesN[i]);
      char R = alphabet.charAt(totalValuesN[i]);
      String r = Character.toString(R);
      //String r = "  x  " + totalValuesN[i];
      decrypted += r;
    }
    return decrypted;
  }
  else{
    String err = "Try a different key.";
    return err;
  }
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
  int D = ((int) getDeterminant(m, s)) % 26;
  for (int z = 1; z <= 999999999; z++){
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
  //println(D);
  return D;
}
