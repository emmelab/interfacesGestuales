class Detector {
  OpenCV opencv;
  Timer timer;
  float x, y= -1;
  float easing = .08;

  Detector(OpenCV opencv_, String ruta) {
    opencv = opencv_;
    opencv.loadCascade(ruta, true);
    timer = new Timer(2);
  }

  void medicion(PImage feed) {
    opencv.loadImage(feed);  
    // ScaleFactor, MinNeighbour, flags, minSize, maxSize
    Rectangle [] manos = opencv.detect(1.05, 50, 0, 20, 250);
    if (manos.length > 0) {
      int max = -1;
      int max_tam = -1;
      for (int i= 0; i<manos.length; i++) {
        if (manos[i].width > max_tam) {
          max = i;
          max_tam = manos[i].width;
        }
      }
      float ax = (manos[max].x + manos[max].width/2) - x;
      float ay = (manos[max].y + manos[max].height/2 + 20) - y;
      x += ax * easing;
      y += ay * easing;
      timer.guardarTiempo();
    } else {
      if (timer.pasoElTiempo()) {
        x = -1;
        y = -1;
      }
    }
    // Descomentar cuando se este calibrando o comprobando la detección 
   _mostrarAreaDeteccion(manos);
    _mostrarPuntoDeteccion(x, y);
  }

  private void _mostrarAreaDeteccion(Rectangle[] manos) {
    //Muestra rectangulo con la mano detectada
    for (int i=0; i < manos.length; i++) {
      noFill();
      strokeWeight(3);
      stroke(0, 255, 0);
      rect(manos[i].x, manos[i].y, manos[i].width, manos[i].height);
    }
  }

  private void _mostrarPuntoDeteccion(float x, float y) {
    //Ver el punto
    pushStyle();
    noStroke();
    fill(255, 0, 0);
    ellipse(x, y, 15, 15);
    popStyle();
  }


  // fin de clase
}
