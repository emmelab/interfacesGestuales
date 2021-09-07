class Timer {
  float espera;
  int time;

  Timer(float espera_) {
    espera = espera_*1000;
  }

  void guardarTiempo() {
    time = millis();
  }

  boolean pasoElTiempo() {
    if (millis() - time >= espera) {
      return true;
    }
    return false;
  }

  ////
}
