/*
  This file contains methods like checkNeighbors, timer, etc.
*/

class CivStart {
  /**
    Stores the X and Y coordinates, and the ID for new civilizations
  */
  int x, y, civilizationID;
  CivStart (int x, int y, int civilizationID) {
    this.x = x;
    this.y = y;
    this.civilizationID = civilizationID;
  }

  void draw () {
    noFill();
    stroke(determineCivColor(civilizationID));
    ellipse(x, y, 15, 15);
    fill(determineCivColor(civilizationID));
    textAlign(LEFT, CENTER);
    text("CIV " + civilizationID, x + 15, y - 2);
    text("civilization " + civilizationID + " stats:", 920, (80 * civilizationID) / 2 + 20);
    textAlign(CORNERS);
  }
}

static class Defaults {
  /**
    Contains default values for new civilization entities
  */
  static int health = 35; // 0/50
  static int strength = 25; // 0/50
  static float degenerationRate = 0.1; // The rate at which an individual's strength decreases
  static int intellect = 20; // 0/50
  static int happiness = 30; // 0/50
  static int researchPoints = 5;
  static int reproductionThreshold = 75;
}

int tickTimer = 0;
void worldTimer () {

  if ((tickTimer % 10) == 0) // Every 10 times tickTimer is called, this is called
  {
    yearsPassed ++; // Adding a year to the game time
  }
  tickTimer ++; // Every time draw is called, this adds one to tickTimer
}

void createEmptyWorld () {
  for (int x = 0; x < worldSize; x ++) {
    for (int y = 0; y < worldSize; y ++) {
      health[x][y] = 0; // Affects the degenerationRate of each individual
      strength[x][y] = 0; // This determines how the individual performs in battle, if it reaches 0 either due to degeneration or battle, the individual dies
      degenerationRate[x][y] = 0; // The rate at which an individual's strength decreases, if their strength reaches 0, they die.
      intellect[x][y] = 0; // Increases overall researchPoints for a civilization
      happiness[x][y] = 0; // Affects health of each individual
      reproduction[x][y] = 0; // Individual value, if it reaches reproductionThreshold, a new individual is created.
    }
  }
}

int civID = 0;
void createCivs (int numberToCreate) {

  for (int i = 0; i < numberToCreate; i ++) {
    int x = round(random(0, worldSize - 1));
    int y = round(random(0, worldSize - 1));

    health[x][y] = Defaults.health; // Affects the degenerationRate of each individual
    strength[x][y] = Defaults.strength; // This determines how the individual performs in battle, if it reaches 0 either due to degeneration or battle, the individual dies
    degenerationRate[x][y] = Defaults.degenerationRate; // The rate at which an individual's strength decreases, if their strength reaches 0, they die.
    intellect[x][y] = Defaults.intellect; // Increases overall researchPoints for a civilization
    happiness[x][y] = Defaults.happiness; // Affects health of each individual
    reproduction[x][y] = 0; // Individual value, if it reaches reproductionThreshold, a new individual is created.
    civID ++;
    // researchPoints[]
    civStartLocations[i] = new CivStart(x, y, civID);
    civilizations[i] = civID; // Assigns a civID to each of the new civs
    civEntity[x][y] = civID; // Assigns x and y values to a certain civilization ID
    println("[SUCESS] created civ at " + x + ", " + y + " with ID " + civID);
    println("[INFO] person of civ " + civID + " has variables: health - " + health[x][y] + "; strength - " + strength[x][y] + "; degenerationRate - " + degenerationRate[x][y] + "; intellect - " + intellect[x][y] + "; happiness - " + happiness[x][y] + "; reproduction - " + reproduction[x][y] + "; \n");
  }
}
