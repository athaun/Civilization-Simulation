 /*
 Created by Ethan Grandin and Asher Haun
 licensed under the MIT license

 * RULES:
 * No two people can occupy the same tile.
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
 *
 *
 *
 *
 *
 */

void setup () {
  size(1600, 900);
  background(0);
  frameRate(30);
}

// SIMULATION CONSTANTS
int yearsPassed = 0; // Simulated years
int worldSize = 900; // The width and height of the world array

boolean firstPass = false; // A flag that makes sure some code is only run once

/*
  All of these arrays hold the values of health, strength, intellect, and happiness for each index of the 2D world.
  Each X and Y position represents a person.
*/
int[] civilizations = {0, 0, 0, 0, 0}; // This array contains the civID's for each new civilization, each 0 represents a civilization to be (maximum of 10 civilizations).

int[][] health = new int[worldSize][worldSize]; // Affects the degenerationRate of each individual
float[][] strength = new float[worldSize][worldSize]; // This determines how the individual performs in battle, if it reaches 0 either due to degeneration or battle, the individual dies
float[][] degenerationRate = new float[worldSize][worldSize]; // The rate at which an individual's strength decreases, if their strength reaches 0, they die.
int[][] intellect = new int[worldSize][worldSize]; // Increases overall researchPoints for a civilization
int[][] happiness = new int[worldSize][worldSize]; // Affects health of each individual
int[][] reproduction = new int[worldSize][worldSize]; // Individual value, if it reaches reproductionThreshold, a new individual is created.
int[][] civEntity = new int[worldSize][worldSize]; // Individual value, stores the civilization for that index
CivStart[] civStartLocations = new CivStart[civilizations.length]; // The location that a civilization starts at [FUTURE: Can be used as a capital, with special GUIs attached].
int[] researchPoints = new int[civilizations.length];

void draw () {
  background(10);
  if (!firstPass) {
    // NOTE: This is only run once
    createEmptyWorld();
    createCivs(civilizations.length);
    println("Initial civilization slots:");
    for (int i = 0; i < civilizations.length; i ++) {
      println(civilizations[i]);
    }
    firstPass = true;
  }
  displayGrid();
  worldTimer(); // Keep at the bottom of the draw()
  gui();
}
