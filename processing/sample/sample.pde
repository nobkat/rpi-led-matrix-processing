
void setup() {
  size(64, 64);
  background(255);
  
  setupSocket();
}



void draw() {
  fill(random(255), random(255), random(255));
  ellipse(random(width), random(height), 10, 10);
  sendImage();
}



void stop() {
  stopSocket();
}
