int w = 1280;
int h = 920;
int border = 10;
int margin = 10;
int dimX;
int dimY;

// range des Diagramms
int posX1;
int posX2;
int posY1;
int posY2;
int drawX;
int drawY;

String term1 = "UO";
String term2 = "SWG";

int s1 = 4;
int s2 = 4;

int sb = 1;

ArrayList<String[]> data1 = new ArrayList<String[]>();
ArrayList<String[]> data2 = new ArrayList<String[]>();
int[][] agesCount1 = new int[70][121];
int[][] agesCount2 = new int[70][121];

void setup() {
  dimX = w-2*border;
  dimY = h-2*border;
  posX1 = border + margin;
  posX2 = w - border - margin;
  posY1 = border + margin;
  posY2 = h - border - margin;
  drawX = dimX-2*margin;
  drawY = dimY-2*margin;
  size(w, h);
  background(255);
  fill(255);
  noStroke();
  rect(border, border, dimX, dimY);
  getData();


  drawBalken();



  fill(0, 0, 0, 150);
  for (int i = 0; i< agesCount1.length; i++) {
    for (int j = 0; j < agesCount1[i].length; j++) {
      int x = int(map(i, 0, 70, posX1, posX2));
      int y = int(map(j, 0, 120, posY2, posY1));
      int r = agesCount1[i][j];
      ellipse(x, y, r*s1, r*s1);
    }
  }

  fill(255, 0, 0, 150);
  for (int i = 0; i< agesCount2.length; i++) {
    for (int j = 0; j < agesCount2[i].length; j++) {
      int x = int(map(i, 0, 70, posX1, posX2));
      int y = int(map(j, 0, 120, posY2, posY1));
      int r = agesCount2[i][j];
      ellipse(x, y, r*s2, r*s2);
    }
  }
}

void drawBalken() {

  fill(200, 200, 200, 150);

  int[] sum1 = new int[70];

  for (int i = 0; i< agesCount1.length; i++) {

    for (int j = 0; j < agesCount1[i].length; j++) {

      sum1[i] = sum1[i] + agesCount1[i][j]*j;
    }
  }

  for (int i = 0; i< sum1.length; i++) {
    int x = int(map(i, 0, 70, posX1, posX2));
    rect(x, posY2-sum1[i]/sb, 5, sum1[i]/sb);
  }  

  int[] sum2 = new int[70];

  for (int i = 0; i< agesCount2.length; i++) {

    for (int j = 0; j < agesCount2[i].length; j++) {

      sum2[i] = sum2[i] + agesCount2[i][j]*j;
    }
  }

  fill(100, 0, 0, 100);
  for (int i = 0; i< sum2.length; i++) {
    int x = int(map(i, 0, 70, posX1, posX2));
    rect(x-5, posY2-sum2[i]/sb, 5, sum2[i]/sb);
  }
}

void getData() {
  String[] lines = loadStrings("Data/all.csv");
  for (int i = 0; i < lines.length; i++) {
    String[] line = lines[i].split(",");

    if (line[2].equals(term1)) {
      agesCount1[int(line[1])-12][int(line[4])]++;
    }

    if (line[2].equals(term2)) {
      agesCount2[int(line[1])-12][int(line[4])]++;
    }
  }
}

void draw() {

  fill(140);
  rect(posX1-10, posY1, 5, drawY);
  rect(posX2+10, posY1, 5, drawY);
}

