// Color codes
String ANSI_RESET = "\u001B[0m"; // Resets to white
String ANSI_RED = "\u001B[31m";
String ANSI_GREEN = "\u001B[32m";
String ANSI_YELLOW = "\u001B[33m";
String ANSI_BLUE = "\u001B[34m";
String ANSI_PURPLE = "\u001B[35m";
String ANSI_WHITE = "\u001B[37m";

// logEvent is called instead of println to add color
void logEvent (String log, char type) {
    String ANSI_COLOR = ANSI_WHITE;
    String logType = "[INFO]";
    switch (type) {
        case 's':
            ANSI_COLOR = ANSI_GREEN;
            logType = "[SUCCESS]"; // Prints green for success
        break;
        case 'i':
            ANSI_COLOR = ANSI_BLUE;
            logType = "[INFO]"; // Prints blue for info
        break;
        case 'w':
            ANSI_COLOR = ANSI_YELLOW;
            logType = "[WARNING]"; // Prints yellow for warning
        break;
        case 'e':
            ANSI_COLOR = ANSI_RED;
            logType = "[ERROR]"; // Prints red for error
        break;
        case 'f':
            ANSI_COLOR = ANSI_RED;
            logType = "[FATAL]"; // Prints red for fatal
        break;
        case 'd':
            ANSI_COLOR = ANSI_PURPLE;
            logType = "[DEBUG]"; // Prints purple for debugging
        break;
    }
    // Actually printing the text with color
    println(ANSI_COLOR + logType + " " + log + ANSI_RESET);
}

float getCivMapCoverage (int id) {
  return (civPopulations[id] * 0.0001234568);
}

int tickTimer = 0;
void worldTimer () {

  // Slower speed (and safe): 10 calls
  if ((tickTimer % 1) == 0) {
    // Every 10 times tickTimer is called, this is called
    yearsPassed ++; // Adding a year to the game time
  }
  tickTimer ++; // Every time draw is called, this adds one to tickTimer
}
