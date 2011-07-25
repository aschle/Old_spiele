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

int scale;

ArrayList<String[]> data = new ArrayList<String[]>();

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
}

void getData() {
  String[] lines = loadStrings("Data/WoW.csv");
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
