import netP5.*;
import oscP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

float x, y;
float easing = 0.5;

Blob[] blobs = new Blob[0];
Timer timer = new Timer(2);
int nBlobs = 0;


void setup() {
  size(640, 480);

  oscP5 = new OscP5(this, 1000);
  myRemoteLocation = new NetAddress("127.0.0.1", 5000);
}

void draw() {

  background(0);
  ellipse(x, y, 30, 30);
  mandarMensaje(x/width, y/height);
}

void mandarMensaje(float x, float y) {
  // el tag le indica que vaya directo al método del mismo nombre
  OscMessage myMessage = new OscMessage("/posicionMano");
  // valores que se mandan
  myMessage.add(x);
  myMessage.add(y); 
  oscP5.send(myMessage, myRemoteLocation);
}


//==== Funcion de recibir data de TSPS ====
void oscEvent(OscMessage theOscMessage) {
  if ( theOscMessage.checkAddrPattern("/TSPS/scene")) {
    nBlobs = theOscMessage.get(1).intValue(); // cantidad de blobs en escena
    if (nBlobs > 0 ) {
      Blob max = new Blob();
      for (int i = 0; i < nBlobs; i++) {
        if (blobs[i].age >= max.age && blobs[i].depth > max.depth) { 
          // se guarda la posición del blob más antiguo
          max = blobs[i];
        }
      }
      float ax = max.x*width - x;
      float ay = max.y*height - y;
      x += ax* easing;
      y += ay* easing;
      timer.guardarTiempo();
    } else if (timer.pasoElTiempo()) {
      x = -1;
      y = -1;
    }
  }
  blobs = new Blob[nBlobs];
  if (theOscMessage.checkAddrPattern("/TSPS/personUpdated/")) {
    // Guarda todos los blobs en la escena
    for (int i = 0; i < nBlobs; i++) {
      blobs[i] = new Blob();
      blobs[i].id = theOscMessage.get(0).intValue();
      blobs[i].age = theOscMessage.get(2).intValue();
      blobs[i].x = theOscMessage.get(3).floatValue();
      blobs[i].y = theOscMessage.get(4).floatValue();
      blobs[i].depth = theOscMessage.get(7).floatValue();
    }
  }
}

public class Blob {
  int id = -1;
  int age = -1;
  float x = -1;
  float y = -1;
  float depth = -1;
  String toString() {
    return "id: "+id+" age: "+age+" x: "+x+" y: "+y+" depth: "+depth;
  }
}
