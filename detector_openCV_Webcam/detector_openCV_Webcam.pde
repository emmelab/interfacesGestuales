//Librerías
import gab.opencv.*;
import java.awt.*;
import oscP5.*;
import netP5.*;
import processing.video.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
OpenCV opencv;
Detector detector;
Capture cam;

// NECESITA LA RUTA ABSOLUTA, ASÍ QUE HAY QUE CAMBIARLA POR COMPUTADORA
String rutaCascada = "C:/Users/Julia/Documents/GitHub/InterfacezNoTactiles/detector_openCV/Hand.Cascade.1.xml";
void setup() {
  size(640, 480);

  oscP5 = new OscP5(this, 1000);
  myRemoteLocation = new NetAddress("127.0.0.1", 5000);

  opencv =  new OpenCV(this, 640, 480); 
  detector = new Detector(opencv, rutaCascada);

  //inicializo camara elegida
  cam = new Capture(this, "pipeline:autovideosrc");
  cam.start();
}

void draw() {
  background(0);
  
  if (cam.available() == true) {
    cam.read();
  }
  // DIFERENTES VISTAS
  //cam.filter(GRAY);
  //cam.filter(THRESHOLD, 0.7);
  
  image(cam, 0, 0);
  
  // enviar imagen al detector
  detector.medicion(cam);
  
  // enviar posición por OSC a otro programa
  mandarMensaje(detector.x/width, detector.y/height);
}

void mandarMensaje(float x, float y) {
  // el tag le indica que vaya directo al método del mismo nombre
  OscMessage myMessage = new OscMessage("/posicionMano");
  // valores que se mandan
  myMessage.add(x);
  myMessage.add(y); 
  oscP5.send(myMessage, myRemoteLocation);
}
