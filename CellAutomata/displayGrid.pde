
// Determines the color that each unique civilization will use
color determineCivColor (int civID) {
  switch (civID) {
    case 0:
      return color(0); // Black
    case 1:
      return color(255, 0, 0); // Red
    case 2:
      return color(255, 0, 255); // Pink
    case 3:
      return color(0, 0, 255); // Blue
    case 4:
      return color(0, 255, 255); // Cyan
    case 5:
      return color(0, 255, 0); // Green
    case 6:
      return color(255, 255, 0); // Yellow
    case 7:
      return color(127, 0, 0); // Dark red
    case 8:
      return color(127, 0, 127); // Purple
    case 9:
      return color(0, 0, 127); // Dark blue
    case 10:
      return color(0, 127, 127); // Dirty blue
    default:
      logEvent("Unable to determine color for civID " + civID + "; returning white", 'w');
      return color(255); // White (error)
  }
}

void displayGrid () {

}
