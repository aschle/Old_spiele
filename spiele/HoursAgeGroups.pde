// Schrift
PFont font;

// Gesamtgröße des Fensters
int w = 1200;
int h = 800;

// Äußerer Abstand
int border = 10;

// Textabstand (Abstand Text zum Diagramm
int marginLeft = 20;
int marginTop = 120;

// Größe des gesamten Diagrammbereiches mit Text
int dimX;
int dimY;

// Startpositionen des Diagramms
// wo gezeichnet wird ohne Text
int posX1;
int posX2;
int posY1;
int posY2;

// Grenze zwischen links und rechts
int splitX;
int splitR;
int splitL;

// Mittlerer Abstand (hälfte)
int splitSpace = 30;

// Schriftgröße
int sizeT = 26;

// Dimension des Zeichenbereiches
int drawX;
int drawY;

// zum Zwischenpeichern der Werte
int[] ages = new int[25];
int[] hours = new int[19];

// Gesamtanzahl
int num = 0;

// Summe der Werte
int sumAge = 0;
int sumHour =0;


// Größe der Rechtecke
int recX = 20;
int recY = 30;

// Spielelabel
String[] games = {
  "WOW", "SWG", "COH"
};

boolean setLabel = false;

void setup() {
  noLoop();
  smooth();

  // Font laden
  font = loadFont("data/DejaVuSans-40.vlw");
  textFont(font, sizeT);

  border = recX;

  // Berechnen der einzelnen Bereiche
  dimX = w-2*border;
  dimY = h-2*border;
  posX1 = border + marginLeft;
  posX2 = w - border - marginLeft;
  posY1 = border + marginTop;
  posY2 = h - border - marginTop;
  drawX = dimX-2*marginLeft;
  drawY = dimY-2*marginTop;

  // Zeichenbereich soll eine fixe Höhe haben
  drawY = 380;

  splitX = posX1 + (hours.length * drawX)/(hours.length + ages.length);
  splitL = splitX - posX1;
  splitR = posX2 - splitX;

  size(w, h);
  background(220, 220, 220);

  // Diagrammbereich mit Text
  fill(255);
  noStroke();
  rect(border, border, dimX, dimY);

  // Diagrammbereich ohne Text
  fill(255);
  rect(posX1, posY1, drawX, drawY);
}

// läd die jeweiligen Daten aus der Datei
void getData(String game, String gender) {

  String[] lines = loadStrings("gruppen.csv");

  for (int i = 0; i < lines.length; i++) {

    String[] line = lines[i].split(",");

    // falls Spielname enthalten
    if (line[2].equals(game) && line[0].equals(gender)) {

      // Stundengruppe speichern
      hours[int(line[3])]++;

      // Altersgruppe speichern
      String[] age = line[1].split("-");
      ages[(int(age[0])-12)/2]++;

      // incrementieren der Gesamtanzahl
      num++;
      sumAge = int(sumAge + int(age[0]) + 0.5);
      sumHour = sumHour + int(line[3])*5;
    }
  }
}

void drawGame(String game, String gender, int offset, int index) {

  getData(game, gender);

  // Falls das Label noch nicht gemalt wurde:
  if (!setLabel) {

    // Malen des Labels
    fill(0); 
    for (int i = 1; i <= games[index].length(); i++) {
      textAlign(CENTER);
      text(games[index].substring(i-1, i), splitX, i *sizeT + posY1 + offset);
    }
    setLabel = true;
  }

  // Malen der Spielstunden
  int[] alpha = new int[19];
  int max = 0;
  int min = 100000;
  int gesamt = 0;

  for (int i = 0; i< hours.length; i++) {
    alpha[i] = hours[i]*255/num;
    if ( alpha[i] > max) {
      max = alpha[i];
    }
    if ((alpha[i]!= 0) && (alpha[i]  < min)) {
      min = alpha[i];
    }
  }

  for (int i = 0; i < alpha.length; i++) {
    int x = int(round(map(i, 0, 18, splitX - splitSpace -recX, posX1)));
    int y = posY1 + offset;
    int a = int(map(alpha[i], min, max, 25, 255));
    fill(0, 0, 0, a);
    rect(x, y, recX, recY);
  }
  
  // Durchschnitt der Spielstunden
  fill(255, 5, 5);
  int dH = (sumHour/num)/5;

  int xH = int(round(map((dH), 0, 18, splitX - splitSpace -recX, posX1)));
  int yH = posY1 + offset;
  ellipse(xH + recX/2 ,yH + recY/2,6,6);

  // Malen der Altersgruppen
  alpha = new int[25];
  max = 0;
  min = 100000;

  for (int i = 0; i < ages.length; i++) {
    alpha[i] = ages[i]*255/num;
    if ( alpha[i] > max) {
      max = alpha[i];
    }

    if ((alpha[i]!= 0) && (alpha[i]  < min)) {
      min = alpha[i];
    }
  }

  for (int i = 0; i < alpha.length; i++) {
    int x = int(round(map(i, 0, 24, splitX + splitSpace, posX2 - recX)));
    int y = posY1 + offset;
    int a = int(map(alpha[i], min, max, 25, 255));

    fill(0, 0, 0, a);
    // x-recX-6 -> damit kein Abstand entsteht (6px)
    rect(x, y, recX, recY);
  }
  
    // Durchschnitt des Alters
  fill(255, 5, 5);
  int dA = ((sumAge/num)-12)/2;
  println(dA);

  int xA = int(round(map(dA, 0, 24, splitX + splitSpace, posX2 - recX)));
  int yA = posY1 + offset;
  ellipse(xA + recX/2 ,yA + recY/2,6,6);

  ages = new int[25];
  hours = new int[19];
  num = 0;
  sumAge = 0;
  sumHour = 0;
}

void draw() {

  axis();

  fill(0);
  int offset = (drawY+recY+35)/6;



  // die einzelnen Zeieln malen (-20) damit female/male eines Spiels näher aneinander rücken
  drawGame("WoW", "male", 0, 0);
  drawGame("WoW", "female", offset-20, 0);
  setLabel = false;
  drawGame("SWG", "male", offset*2, 1);
  drawGame("SWG", "female", offset*3-20, 1);
  setLabel = false;
  drawGame("CoH", "male", offset*4, 2);
  drawGame("CoH", "female", offset*5-20, 2);
  setLabel = false;
}

void axis() {

  fill(50);
  int posAchseYu = posY2 - 115;
  int posAchseYo = posY1 - 25;
  int weigthAchseY = 3;
  String[] achseRLbl = {
    "12", "14", "16", "18", "20", "22", "24", "26", "28", "30", "32", "34", "36", "38", "40", "42", "44", "46", "48", "50", "52", "54", "56", "58", "60+"
  };
  String[] achseLLbl = {
    "<2", "5", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55", "60", "65", "70", "75", "80", "85", "+"
  };
  textFont(font, 12);
  textMode(CENTER);
  int grid = posAchseYu-posAchseYo -2;


  // mittlere Balken
  fill(220, 220, 220);
  rect(splitX - splitSpace + 12, posAchseYo, 2*splitSpace - 24, posAchseYu-posAchseYo);

  fill(0);

  // Rechte Achse (-5 damit Platz für den Pfeil ist)
  rect(splitX, posAchseYu, splitR - 5, weigthAchseY);
  rect(splitX, posAchseYo, splitR - 5, weigthAchseY);

  // Ticks an der rechten Achse (die letzten weglassen)
  for (int i = 0; i < ages.length - 2; i++) {

    int x = int(round(map(i, 0, 24, splitX + splitSpace, posX2 - recX)));
    fill(220);
    rect(x+recX/2, posAchseYo+2, 2, grid);
    fill(50);
    rect(x+recX/2, posAchseYu-weigthAchseY, 2, 4);
    rect(x+recX/2, posAchseYo+weigthAchseY, 2, 4);
    if (i%2 == 0) {
      text(achseRLbl[i], x+recX/4, posAchseYu + 20);
      text(achseRLbl[i], x+recX/4, posAchseYo - 10);
    }
  }
  triangle(posX2-20, posAchseYu + 7, posX2-20, posAchseYu - 5, posX2, posAchseYu+1);
  triangle(posX2-20, posAchseYo + 7, posX2-20, posAchseYo - 5, posX2, posAchseYo+1);


  // Linke Achse
  rect(posX1 + 5, posAchseYu, splitX, weigthAchseY);
  rect(posX1 + 5, posAchseYo, splitX, weigthAchseY);

  // Ticks an der linken Achse (die letzten weglassen)
  for (int i = 0; i < hours.length-2; i++) {

    int x = int(round(map(i, 0, 18, splitX - splitSpace - recX, posX1)));
    fill(220);
    rect(x+recX/2, posAchseYo+2, 2, grid);
    fill(50);
    rect(x+recX/2, posAchseYu-weigthAchseY, 2, 4);
    rect(x+recX/2, posAchseYo-weigthAchseY, 2, 4);
    if (i%2 == 0) {
      text(achseLLbl[i], x, posAchseYu + 20);
      text(achseLLbl[i], x, posAchseYo - 10);
    }
  }
  triangle(posX1, posAchseYu+1, posX1+20, posAchseYu - 5, posX1+20, posAchseYu+7);
  triangle(posX1, posAchseYo+1, posX1+20, posAchseYo - 5, posX1+20, posAchseYo+7);

  textFont(font, sizeT);
}

