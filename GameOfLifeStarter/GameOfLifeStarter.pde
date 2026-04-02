import java.util.Arrays;

final int SPACING = 5; // each cell's width/height //<>// //<>//
final float DENSITY = 0.1; // how likely each cell is to be alive at the start
int[][] grid; // the 2D array to hold 0's and 1's
//(GLOBALS)
//adjust frameRate
int time = 10;
int g = 0;//changes green value
int b = 0;//changes blue value
int x = 0;//X value of neighbor
int y = 0;//Y value of neighbor
boolean paused = false;//pause
void setup() {
  size(800, 600); // adjust accordingly, make sure it's a multiple of SPACING
  noStroke(); // don't draw the edges of each cell
  frameRate(time); // controls speed of regeneration

  grid = new int[height / SPACING][width / SPACING];
  // STEP 1 - Populate initial grid (you may want to use Arrays.toString to check it)
  for (int i = 0; i<grid.length; i++) {
    for (int j = 0; j<grid[0].length; j++) {
      double r = Math.random();
      if (r<DENSITY) {
        grid[i][j]=1;
      } else {
        grid[i][j]=0;
      }
    }
  }
}

void draw() {
  showGrid(g, b);
  // STEP 2 - Implement this method so you can see your 2D array
  grid = calcNextGrid(); // uncomment this after you get showGrid() working
}

int[][] calcNextGrid() {
  int[][] nextGrid = new int[grid.length][grid[0].length];
  for (int r = 0; r<grid.length; r++) {//- 1 due to where it starting.
    for (int c = 0; c<grid[0].length; c++) {
      int neighbor = countNeighbors(r, c);
      int cell = grid[r][c];

      if (cell == 1&&(neighbor == 2 || neighbor == 3)) {
        //alive and healthy
        nextGrid[r][c] = 1;
      } else if (cell == 1 &&  neighbor ==3) {
        //dyin
        nextGrid[r][c] = 1;
      } else {
        //dead
        nextGrid[r][c] = 0;
      }
    }
  }

  // your code here

  return nextGrid;
}

int countNeighbors(int y, int x) {
  // your code here
  // don't check out-of-bounds cells!
  int n = 0; // don't count yourself!
  for (int rowEdge = -1; rowEdge <=1; rowEdge++ ) {
    for (int colEdge = -1; colEdge<=1; colEdge++) {
      int rowBounds = y+rowEdge;
      int colBounds = x+colEdge;
      if ((rowEdge == 0 && colEdge == 0)) {
      } else {
        if ( rowBounds >= 0 && rowBounds<grid.length && colBounds >= 0 &&  colBounds < grid[0].length) {
          n+=grid[rowBounds][colBounds];
        }
      }
    }
  }

  return n;
}
void keyPressed() {

  if ( keyCode == UP ) {
    g = (int)(Math.random()*256);
    b = (int)(Math.random()*256);
    time++;
    frameRate(time);
  }
  if (keyCode == DOWN) {
    time--;
    if (time < 1) {
      time = 1;
    }
    frameRate(time);
  }
  if (keyCode == ' ') {
    paused = !paused;
    if (paused) {
      noLoop();
    } else {
      loop();
    }
  }
}
void showGrid(int g, int b) {
  // your code here
  // use square() to represent each cell
  for (int r = 0; r<grid.length; r++) {
    for (int c = 0; c<grid[0].length; c++) {
      if (grid[r][c] == 1) {
        fill(255, g, b);
        if (mousePressed == true) {
          fill(255, g+(int)(Math.random()*100), b+(int)(Math.random()*100));
        }
      } else {
        fill(0, 0, 0);
      }
      square(c*SPACING, r*SPACING, SPACING);
    }
  }





  // use fill(r, g, b) to control color: black for empty, red for filled (or alive)
  // each square (cell) has a width and height of SPACING.
  // you will need to calculate the x and y position as you loop through the grid
}

