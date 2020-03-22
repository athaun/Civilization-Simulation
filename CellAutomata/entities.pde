int dummyTimer2 = 0;
class Entity {

  int health; // Affects the degenerationRate of each individual
  float strength; // This determines how the individual performs in battle, if it reaches 0 either due to degeneration or battle, the individual dies
  float degenerationRate; // The rate at which an individual's strength decreases, if their strength reaches 0, they die.
  int intellect; // Increases overall researchPoints for a civilization
  int happiness; // Affects health of each individual
  int reproduction; // Individual value, if it reaches reproductionThreshold, a new individual is created.
  int x, y, civID; // The X position, Y position, and the civilization ID for the entity.
  int reproductionRadius;
  boolean onBirth;

  Entity (int x, int y, int civID) {
    this.health = round(random(20, 30)); // 0/50
    this.strength = random(20, 30); // 0/50
    this.degenerationRate = random(0.1, 0.05);
    this.intellect = round(random(20, 30)); // 0/50
    this.happiness = round(random(20, 30)); // 0/50
    this.reproduction = 2;
    this.reproductionRadius = 2;
    this.x = x;
    this.y = y;
    this.civID = civID;
    this.onBirth = true;
  }

  void update () {
    // Update is called once per year for all entities
    if (civID != 0) {
      // println("this ID " + civID);
      if (yearsPassed % 1 == 0) {
        // If 2 years have passed
        // reproductionRadius = reproduction + round(random(reproduction - 1, reproduction + 3));
        this.reproduce();
      }
    }
  }

  void reproduce () {
      reproduceWithinRadius(x, y, 1, civID);
  }

};
