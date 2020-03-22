 /*
 Created by Ethan Grandin and Asher Haun
 licensed under the MIT license

 * RULES:
 * No two people can occupy the same tile.
 * No population can populate a void tile.
 * When a person from one civ wants to enter a tile from another civ, they must fight
 * The rules of combat are determined by the persons strength, as well as military research of that civ
 *
 * RESEARCH:
 * Farming - Increases health of that civ
 * Military - Increases strength of that civ
 * Schools - Increases intellect of that civ
 * Amenities - Increases happiness of that civ
 *
 * POPULATION VARIABLES:
 * Health - Incraeses how long they live; Minorly increases reproduction rate - 0/50
 * Strength - Increases how well they fight - 0/50
 * Intellect - Increases how fast research is done - 0/50
 * Happiness - Increases health - 0/50
 * Research Points - Increases the civilizations research time - 0/ininity
 *
 * BOOST:
 * In the case of reproductionValue reaching the reproductionThreshold
 * If all nearby tiles are occupied, then give the person a random stat boost of Strength or Intellect (ranging from an int of 1-2 points)
 *
 * DONE:
 * 2020/1/5
 * - Changed entity variables from arrays to objects (class is implemented).
 *
 * 2020/1/6
 * - Fully implemented the change from arrays to objects
 * - Implemented basic reproduction at every 1 year (few checks where added)
 *
 * 2020/1/11
 * - Added more checks for reproduction (though as of yet, they are not as clean as they could be)
 * - Added a true population ticker (though it will need to be modified for combat)
 * - Added a basic mouse over display
 *
 * TODO:
 * Clean up/divide simulation methods
 *
 * IDEA 1:
 * Each province has a development level that:
 * Boosts the current focus/research of the player
 * Minor boost to all stats of that person
 *
 * IDEA 2:
 * To have multiple tile types, some good, some bad, some unique, and some impassablei
 *
 * NOTE:
 * - Found the source of most of the low FPS: The for loop that is called to draw the 900x900 pixels
 * (this is not heavily tested)
 *
 * - Rework "reproduceWithinRadius"... not a good system currently
 *
 * - Having large scale trouble with civPopulation, possible trouble causers are the raduis range and reproductionRate... NEED TO LOOK INTO
 *
 *
 *
 *
 */

void setup () {
  size(1600, 900);
  background(20);
  frameRate(15);
  noSmooth();
}

// SIMULATION CONSTANTS
int yearsPassed = 0; // Simulated years
int lastYearsPassed = -1; // Used in updateEntities
int worldSize = 900; // The width and height of the world array

boolean firstPass = false; // A flag that makes sure some code is only run once

/*
  All of these arrays hold the values of health, strength, intellect, and happiness for each index of the 2D world.
  Each X and Y position represents a person.
*/

Entity[][] entities = new Entity[worldSize][worldSize];
Terrain[][] terrain = new Terrain[worldSize][worldSize];
int[] civilizations = {0, 0, 0, 0, 0}; // This array contains the civID's for each new civilization, each 0 represents a civilization to be (maximum of 10 civilizations).
int[] civPopulations = new int[civilizations.length];

CivStart[] civStartLocations = new CivStart[civilizations.length]; // The location that a civilization starts at [FUTURE: Can be used as a capital, with special GUIs attached].
int[] researchPoints = new int[civilizations.length];

void draw () {
  println("civ length: " + civilizations.length);
  background(10);
  if (!firstPass) {
    // NOTE: This is only run once
    for (int i = 0; i < civPopulations.length; i ++) {
      civPopulations[i] = 1;
    }
    createEmptyWorld();
    createCivs(civilizations.length);
    firstPass = true;
  }
  displayGrid();
  worldTimer(); // Keep at the bottom of the draw()
  updateEntities();

  gui();

  // println(emptyPop);
  emptyPop = 0;
}
