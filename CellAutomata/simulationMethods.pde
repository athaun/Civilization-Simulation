/*
  This file contains methods like checkNeighbors, timer, etc.
*/



class CivStart {
  /**
    Stores the X and Y coordinates, and the ID for new civilizations, also draws a circle around the first entity of each civilization
  */
  int x, y, civilizationID;
  CivStart (int x, int y, int civilizationID) {
    this.x = x;
    this.y = y;
    this.civilizationID = civilizationID;
  }

  void draw () {
    //logEvent("civilizationID: " + civilizationID, 'd');
    noFill();
    stroke(determineCivColor(civilizationID));
    ellipse(x, y, 15, 15); // Drawing a circle at the spawn of each civilization
    fill(determineCivColor(civilizationID));

    textAlign(LEFT, CENTER);
    text("CIV " + civilizationID, x + 15, y - 2);
    // Displaying the true population (does NOT support battles/death)
    text("civilization " + civilizationID + " population: " + civPopulations[civilizationID - 1], 920, (80 * civilizationID) / 2 + 20);
    // civilizationID - 1 is due to the black civilization
     text("civilization " + civilizationID + " map control: " + getCivMapCoverage(civilizationID - 1) + "%", 920, (80 * civilizationID) / 2 + 40); // second
    textAlign(CORNERS);

  }
}

//TODO finish this
int childX; // Declare the new X and Y positions of the child to be created
int childY;
void reproduceWithinRadius (int parentX, int parentY, int radius, int childID) {
    childX = round(random(parentX - radius, parentX + radius)); // Initialize the new X and Y positions with random values that are withing a certain radius
    childY = round(random(parentY - radius, parentY + radius));
    while (childX <= 0 || childX >= worldSize || childY <= 0 || childY >= worldSize) {
      childX = round(random(parentX - radius, parentX + radius));
      childY = round(random(parentY - radius, parentY + radius));
    }
    if (entities[childX][childY].civID == 0/* && terrain[childX][childY].type != 'v'*/) {
        // Check if the new X and Y positions are within the world, and not already occupied by a civilization.
        entities[childX][childY] = new Entity(childX, childY, childID); // Create a child
        civPopulations[childID - 1] ++;
    }
}










// civPopulations[childID - 1] -= 810000;

int emptyPop = 0;

void updateEntities () {

  // Only run once per year
  if (yearsPassed != lastYearsPassed) {

    // Call once per draw call
    noStroke();
    loadPixels();

    for (int x = 0; x < worldSize; x ++) {
      for (int y = 0; y < worldSize; y ++) {
          entities[x][y].update();
          pixels[x + y * width] = color(determineCivColor(entities[x][y].civID));

          if (entities[x][y].civID == 0) {
            emptyPop ++;
            // println(x + ", " + y);
          }
      }
    }
    updatePixels();
    lastYearsPassed = yearsPassed;
  }
  for (int i = 0; i < civilizations.length; i ++) {
    civStartLocations[i].draw(); // Displays circles around the start locations of each civilization
  }

}

void createEmptyWorld () {
  // create a 2D array of blank people, only run once
  for (int x = 0; x < entities.length; x ++) {
    for (int y = 0; y < entities[x].length; y ++) {
      entities[x][y] = new Entity(x, y, 0);
    }
  }

  // for (int x = 100; x < 600; x ++) {
  //   for (int y = 400; y < 800; y ++) {
  //     terrain[x][y] = new Terrain(x, y, 'v');
  //   }
  // }

}

int civID = 0;
void createCivs (int numberToCreate) {

  for (int i = 0; i < numberToCreate; i ++) {
    int x = round(random(15, worldSize - 15));
    int y = round(random(15, worldSize - 15));

    civID ++;
    civStartLocations[i] = new CivStart(x, y, civID); // Storing the coordinates and the civilization ID for the starting people
    civilizations[i] = civID; // Assigns a civID to each of the new civs

    if (civID > 1) {
      // Check if this isn't the first civilization to be created
      for (int j = 1; j < civID; j ++) {
        while (civStartLocations[j - 1].x == x && civStartLocations[j - 1].y == y) {
          // This civilization's spawn is on top of another civilization's spawn
          x = round(random(15, worldSize - 15));
          y = round(random(15, worldSize - 15));

          int newX = round(random(x - 2, x + 2));
          int newY = round(random(y - 2, y + 2));
          civStartLocations[i].x = x;
          civStartLocations[i].y = y;

          logEvent("Civilization " + civID + " spawned on top of civilization " + j + ", we are moving spawn of civilization " + civID + " to X: " + x + ", Y: " + y + ".", 'w');
          logEvent("Years after move: " + yearsPassed, 'd');
        }
      }
    }

    entities[x][y] = new Entity(x, y, civID);

    logEvent("Created civ at " + x + ", " + y + " with ID " + civID, 's');
  }
}
