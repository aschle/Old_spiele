//int w = 800;
//int h = 600;
//int border = 20;
//int margin = 80;
//int dimX;
//int dimY;
//
//// range des Diagramms
//int posX1;
//int posX2;
//int posY1;
//int posY2;
//int drawX;
//int drawY;
//
//String[][] data = {
//  {
//    "Ever Quest", "184", "57"
//  }
//  , {
//    "Star Wars Galaxies", "98", "10"
//  }
//  , {
//    "Ultima Online", "56", "22"
//  }
//};
//
//void setup() {
//  dimX = w-2*border;
//  dimY = h-2*border;
//  posX1 = border + margin;
//  posX2 = w - border - margin;
//  posY1 = border + margin;
//  posY2 = h - border - margin;
//  drawX = dimX-2*margin;
//  drawY = dimY-2*margin;
//  size(w, h);
//  background(255);
//  fill(225);
//  noStroke();
//  rect(border, border, dimX, dimY);
//}
//
//void draw() {
//  fill(140);
//  rect(posX1-10, posY1, 5, drawY);
//
//  for (int i = 0; i< data.length; i++) {
//
//    int m = int(data[i][1]);
//    int f = int(data[i][2]);
//
//    int lm = (m*drawX)/(m+f);
//    int lf = (f*drawX)/(m+f);
//
//    fill(50);
//    rect (posX1, posY1+(i*70), lm, 50);
//    fill(200);
//    rect(posX1 + lm, posY1+(i*70), lf, 50);
//  }
//}


