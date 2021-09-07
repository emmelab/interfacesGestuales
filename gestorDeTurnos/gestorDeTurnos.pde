// Librerías
import oscP5.*;
import netP5.*;

// Objetos y Variables
OscP5 oscP5;
NetAddress myRemoteLocation;
Boton botones[] = new Boton[4];
Boton bInicio;
PImage fondo, inicio, cursor;
PImage opcion[] = new PImage[4];

float x, y = 0;
String estado = "inicio";
Timer timer = new Timer(3);

void setup() {
  //size(400, 225);
  size(1000, 562);

  oscP5 = new OscP5(this, 5000);
  myRemoteLocation = new NetAddress("127.0.0.1", 1000);
  // Manda el mensaje directo al método con el mismo nombre
  oscP5.plug(this, "posicionMano", "/posicionMano");


  inicializarBotones();
  inicializarImagenes();
}

void draw() {
  background(0, 0, 0);
  if (estado == "inicio") {
    image(inicio, 0, 0);
    if (bInicio.cualTag() != -1) {
      timer.guardarTiempo();
      bInicio.reseteoValores();
      transicion();
      estado = "menu";
    }
    bInicio.dibujar(x, y);
  } else if (estado == "menu") {
    image(fondo, 0, 0);
    for (int i= 0; i<4; i++) {
      //chequear que botón fue seleccionado
      if (botones[i].cualTag() != -1) {
        timer.guardarTiempo();
        botones[i].reseteoValores();
        transicion();
        estado = "opcion"+(i+1);
      }
      botones[i].dibujar(x, y);
    }
  } else {
    //opciones de estados
    if (estado.equals("opcion1")) {
      image(opcion[0], 0, 0);
    } else if (estado.equals("opcion2")) {
      image(opcion[1], 0, 0);
    } else if (estado.equals("opcion3")) {
      image(opcion[2], 0, 0);
    } else {
      image(opcion[3], 0, 0);
    }
    //volver al inicio cuando pase X tiempo
    if (timer.pasoElTiempo()) {
      estado = "inicio";
    }
  }
  pushStyle();
  imageMode(CENTER);
  image(cursor, x, y);
  popStyle();
}

void transicion(){
 // se asegura de que no aparezcan botones seleccionados cuando se cambia de estado
 x = -1;
 y = -1;
}
