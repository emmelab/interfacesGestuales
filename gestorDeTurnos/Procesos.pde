public void posicionMano(float x_, float y_) {
  //Recibe por osc la posición de la mano
  //Acomoda la posición de la mano a el tamaño de la pantalla de la interfaz
  //x = x_*width;
  //y = y_*height;
  float pad = 0.7;
  x = constrain(map(x_,0,1,-pad,1+pad),0,1)*width;
  y = constrain(map(y_,0,1,-pad,1+pad),0,1)*height;
}


void inicializarBotones() {
  bInicio = new Boton(0, width/2, (height/3*2), "0");
  int x1 = (width/7)*2;
  int x2 = (width/7)*5;
  int y1 = (height/10)*3;
  int y2 = (height/10)*7;
  botones[0] = new Boton(1, x1, y1, "1"); 
  botones[1] = new Boton(2, x2, y1, "2");
  botones[2] = new Boton(3, x1, y2, "3");
  botones[3] = new Boton(4, x2, y2, "4");
}

void inicializarImagenes() {
  fondo = loadImage("data/fondo.png");
  fondo.resize(width, height);
  inicio = loadImage("data/inicio.png");
  inicio.resize(width, height);
  cursor = loadImage("data/cursor.png");
  cursor.resize(0, height/6);
  for (int i= 0; i<4; i++) {
    opcion[i] = loadImage("data/opcion"+str(i+1)+".png");
    opcion[i].resize(width, height);
  }
}
