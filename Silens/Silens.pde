Eye left, right;
float rad, dist, startW, startH;
int strokeWeight;

void setup() {
  size(1200, 1200);
  frameRate(144);
  smooth(4);
  background(255);
  stroke(0);

  strokeWeight=16;
  rad=height*0.25;
  //dist=rad*0.1;
  startW=width*0.2;
  startH=height*0.2;

  left = new Eye( width*0.5+rad*0.5+dist, height*0.5, rad);
  right = new Eye( width*0.5-rad*0.5-dist, height*0.5, rad);

  setfont();
}

void draw() {
  strokeWeight(strokeWeight);

  left.update(mouseX, mouseY);
  right.update(mouseX, mouseY);
  line(width*0.5-startW*2, height*0.5+startH, width*0.5, height*0.5-startH);
  line(width*0.5+startW*2, height*0.5+startH, width*0.5, height*0.5-startH);

  left.display();
  right.display();

  drawlogo();
}

void setfont() {
  printArray(PFont.list());
  PFont f;
  f=createFont("Barlow-MediumItalic.ttf", 96);
  //f=createFont("Zilla Slab", 96);
  textFont(f);
}

void drawlogo() {
  fill(0);
  textAlign(CENTER);
  text("SiLens", width*0.5, height*0.51+startH);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT && left.size<height*0.4) {
      left.size+=height*0.025;
      right.size-=height*0.025;
      background(255);
    } else if (keyCode == LEFT && right.size<height*0.4) {
      left.size-=height*0.025;
      right.size+=height*0.025;
      background(255);
    } else if (keyCode == DOWN && strokeWeight>6) {
      strokeWeight-=2.5;
      background(255);
    } else if (keyCode == UP && strokeWeight<36) {
      strokeWeight+=2.5;
      background(255);
    }
  }
}

class Eye {
  float x, y;
  float size;
  float angle = 0.0;

  Eye(float tx, float ty, float ts) {
    x = tx;
    y = ty;
    size = ts;
  }

  void update(float mx, float my) {
    angle = atan2(my-y, mx-x);
  }

  void display() {
    pushMatrix();
    translate(x, y);
    fill(255);
    ellipse(0, 0, size, size);
    rotate(angle);
    fill(153, 204, 0);
    ellipse(size/4, 0, size/2, size/2);
    popMatrix();
  }
}
