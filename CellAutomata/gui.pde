ArrayList<Points> graphPoints = new ArrayList();

// void keyPressed() {
//   float t = random(0, height-20);
//   Points P = new Points(width, t );
//   poop.add(P);
// }

class Points {
  float x, y;
  Points(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

void gui () {

  // Information panel
  fill(255);
  text(yearsPassed + " Years Passed", 920, 20); // Displays the simulates years that have passed in the information panel
  text("mouseX: " + round(mouseX) + " | mouseY " + round(mouseY) + " | FPS: " + frameCount/(millis()/1000 + 1) + " Empty Population: " + emptyPop, 920, 40); // Displays the mouse coordinates in the information panel
  if (mouseX < worldSize) {
    fill(0);
    stroke(255);
    rect(mouseX + 10, mouseY - 15, 150, 30);
    fill(determineCivColor(entities[mouseX][mouseY].civID));
    text("Civilization " + entities[mouseX][mouseY].civID, mouseX + 15, mouseY);
  }
}
