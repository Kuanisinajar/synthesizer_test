class TextInput {

  String title;
  float posX, posY;
  float w, h;
  Boolean focusing = false;
  String input = "";
  Float value;

  TextInput(String t, float x, float y) {
    title = t;
    w = 100;
    h = 50;
    posX = x;
    posY = y;
    value = 440.0;
  }


  void drawInput() {


    pushMatrix();
    translate(-w / 2, -h / 2);
    translate(posX, posY);
    if (focusing) {
      stroke(255, 0, 0);
    } else {
      stroke(255);
    }

    noFill();
    rect(0, 0, w, h);
    text(title + " \n \n" + input, 10, 15);
    popMatrix();
  }


  void detectFocus() {
    if (abs(mouseX - posX) < w/2 && abs(mouseY - posY) < h/2) {
      focusing = true;
    } else {
      focusing = false;
    }
  }

  void receiving() {
    if (focusing) {
      if (key==ENTER||key==RETURN) {
        if (input != "") {
          value = float(input);
          input = "";
          print("value now: ", value + "\n");
        } else {
          value = 440.0;
        }
      } else {
        input = input + key;
      }
    }
  }
}
