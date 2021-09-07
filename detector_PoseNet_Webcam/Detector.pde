class Detector {
  float x, y = -1;
  float easing = .05;
  float confianza = 0.7;
  String parte = "rightWrist";
  Timer timer;

  Detector() {
    timer = new Timer(2);
  }

  void detectar(Pose[] poses, int nPoses) {
    if (nPoses > 0) {
      // si detecta persona
      HashMap<String, Keypoint> keypoints; 
      try {
        keypoints = poses[0].keypoints; // guarda puntos
      } 
      catch(Exception e) {
        return;
      }
      if (!keypoints.containsKey(parte)) {
        return;
      }
      PVector p1 = keypoints.get(parte).position; //posicion mano
      float score = 0;
      score = keypoints.get(parte).score;   // confianza de deteccion
      if (score >= confianza) { 
        //actualiza solo si tiene confianza en la deteccion
        float ax = p1.x - x;
        float ay = p1.y - y;
        x += ax * easing;
        y += ay * easing;
        timer.guardarTiempo();
      } else if (timer.pasoElTiempo()) {
        x = -1;
        y = -1;
      }
    } else {
      if (timer.pasoElTiempo()) {
        x = -1;
        y = -1;
      }
    }
  }

  ////////
}
