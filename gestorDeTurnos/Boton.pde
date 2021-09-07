class Boton {
  int tag;
  float x, y;
  int unidadX = (width/6)*2;
  int unidadY = height/4;
  int elegido = -1;
  boolean enZona, prevEnZona = false;
  PImage img, imgSel;
  //timer
  Timer timer = new Timer(4);

  Boton(int tag_, float x_, float y_, String num) {
    tag = tag_;
    x = x_;
    y = y_;
    img = loadImage("data/op"+num+".png");
    imgSel = loadImage("data/opS"+num+".png");
    img.resize(unidadX, unidadY);
    imgSel.resize(unidadX, unidadY);
  }

  void dibujar(float posX, float posY) {
    prevEnZona = enZona;
    pushStyle();
    imageMode(CENTER);
    if (posX >= x-unidadX/2 && posX <= x+unidadX/2 && posY >= y-unidadY/2 && posY <= y+unidadY/2) {
      enZona = true;
      // guardar tiempo cuando entre a una zona
      if (!prevEnZona && enZona) {
        println("entre en un area");
        timer.guardarTiempo();
      }
      if (timer.pasoElTiempo()) {
        elegido = tag;
      }


      image(imgSel, x, y);
      timer.dibujar(width/2, (height/10)*9);
    } else {
      image(img, x, y);
      elegido = -1;
      enZona = false;
    }
    popStyle();
  }

  int cualTag() {
    return elegido;
  }

  void reseteoValores() {
    elegido = -1;
    enZona = false;
    prevEnZona = false;
  }


  ///
}
