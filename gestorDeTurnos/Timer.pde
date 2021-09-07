class Timer {
  int espera;
  int time;
  int ancho= 0;
  int alto = 30;

  Timer(int espera_) {
    espera = espera_*1000;
  }

  void guardarTiempo() {
    time = millis();
  }

  boolean pasoElTiempo() {
    //println(millis()-time, " ", espera);
    if (millis() - time >= espera) {
      return true;
    }
    return false;
  }
  
  void dibujar(int x, int y){
    fill(#7AD1EE);
    noStroke();
    rectMode(CENTER);
    ancho = int(map(millis()-time,0,espera,0,width));
    rect(x,y,ancho,alto);
    
  }

  ////
}
