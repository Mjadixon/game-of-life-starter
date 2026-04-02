import java.util.Arrays;

final int SPACING = 5; // each cell's width/height //<>// //<>//
final float DENSITY = .1; // how likely each cell is to be alive at the start
int[][] grid; // the 2D array to hold 0's and 1's
//(GLOBALS)
int age = 0;
int t = 10;//controls frameRate
int red = 255;//changes red values
int green = 0;//changes green value
int blue = 0;//changes blue value
int x = 0;//X value of neighbor
int y = 0;//Y value of neighbor
boolean paused = false;//pause

void setup() {
  // STEP 1 - Populate initial grid (you may want to use Arrays.toString to check it)
  size(800, 600); // adjust accordingly, make sure it's a multiple of SPACING
  noStroke(); // don't draw the edges of each cell
  frameRate(t); // controls speed of regeneration
  grid = new int[height / SPACING][width / SPACING];
  //sets 1 or 0 dependsing on density
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
  // STEP 2 - Implement this method so you can see your 2D array
  showGrid(green, blue);
  grid = calcNextGrid();
  fill(255);
  textSize(14);
  text("Age: " + age, 40, 20);
  age++; // uncomment this after you get showGrid() working
}

int[][] calcNextGrid() {
  int[][] nextGrid = new int[grid.length][grid[0].length];
  for (int r = 0; r<grid.length; r++) {//- 1 due to where it starting.
    for (int c = 0; c<grid[0].length; c++) {
      int neighbor = countNeighbors(r, c);//uses count neighbor
      int cell = grid[r][c];
      //if cell is at 1 and neighbor 2 or 3 is on edge
      if (cell == 1 && (neighbor == 2 || neighbor == 3)) {
        nextGrid[r][c] = 1;//alive and healthy
      } else if (cell == 0 &&   neighbor == 3) { // if cell is at 0 and neighbor is 3
        nextGrid[r][c] = 1; // birth
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
  for (int rowEdge = -1; rowEdge <=1; rowEdge++ ) { // calculates edge on left and right not including itself
    for (int colEdge = -1; colEdge<=1; colEdge++) { // calculates edge up and down
      int rowBounds = y+rowEdge; //sets Bounds for row
      int colBounds = x+colEdge; // sets bounds for columns
      if ((rowEdge == 0 && colEdge == 0)) { //excludes self (used for testing when needed)
      } else {
        //if Bounds was greater than or 0 and rowbounds was less than the edge same with column, then it added to neighbors
        if ( rowBounds >= 0 && rowBounds<grid.length && colBounds >= 0 &&  colBounds < grid[0].length) {
          n+=grid[rowBounds][colBounds];
        }
      }
    }
  }

  return n;
}//draws more squares (found out you can draw when pasued, but you cant see it drawing)
void mouseDragged() {
  //grabs x and y values
  int mouseLx = mouseX /SPACING;
  int mouseLy = mouseY / SPACING;
  //adds mousex and mousey values to grid and checks bounds (I made it so you can only add cells. make it just equal then it deletes too)
  if ( mouseLy >= 0 && mouseLy<grid.length && mouseLx >= 0 &&  mouseLx < grid[0].length) {
    grid[mouseLy][mouseLx] += 1-grid[mouseLy][mouseLx];//adds to grid new cell
  }
}//key presses
void keyPressed() {
  //speeds up
  if ( keyCode == UP ) {
    t++;
    frameRate(t);
  }

  //slows down
  if (keyCode == DOWN) {
    t--;
    if (t<1) {
      t=1;
    }
    frameRate(t);
  }

  //pauses
  if (keyCode == ' ') {
    paused = !paused;
    if (paused) {
      noLoop();
    } else {
      loop();
    }
  }
}

void showGrid(int green, int blue) {
  // your code here
  // use square() to represent each cell
  for (int r = 0; r<grid.length; r++) {
    for (int c = 0; c<grid[0].length; c++) {
      if (grid[r][c] == 1) {
        fill(red, green, blue);
        if(mousePressed == true && mouseButton == RIGHT){
        fill((int)(Math.random()*255),(int)(Math.random()*255),(int)(Math.random()*255));
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

