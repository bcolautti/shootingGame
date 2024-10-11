class BackgroundManager
{
  PImage img;
  int imgWidth, imgHeight;
  int yPos1, yPos2;
  int speed = 2;

  BackgroundManager()
  {
    img = loadImage("images/background.jpg"); // Load your image here
    imgWidth = img.width;
    imgHeight = img.height;
    yPos1 = -height;
    yPos2 = -imgHeight; // Start the second image above the canvas
  }

  void draw() {
    background(255);

    // Draw the first image
    image(img, 0, yPos1);
    // Draw the second image just above the first one
    image(img, 0, yPos2);

    // Move both images downwards
    yPos1 += speed;
    yPos2 += speed;

    // If the first image moves beyond the canvas, reset its position above the second image
    if (yPos1 >= height) {
      yPos1 = yPos2 - imgHeight;
    }

    // If the second image moves beyond the canvas, reset its position above the first image
    if (yPos2 >= height) {
      yPos2 = yPos1 - imgHeight;
    }
  }
}
