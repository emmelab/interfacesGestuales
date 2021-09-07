//Librerías
import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import gab.opencv.*;
import java.awt.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
OpenCV opencv;
Kinect kinect;
Detector detector;

// NECESITA LA RUTA ABSOLUTA, ASÍ QUE HAY QUE CAMBIARLA POR COMPUTADORA
String rutaCascada = "C:/Users/Julia/Documents/GitHub/InterfacezNoTactiles/detector_openCV/Hand.Cascade.1.xml";
void setup() {
  size(640, 480);

  oscP5 = new OscP5(this, 1000);
  myRemoteLocation = new NetAddress("127.0.0.1", 5000);

  opencv =  new OpenCV(this, 640, 480); 
  detector = new Detector(opencv, rutaCascada);

  kinect = new Kinect(this);
  kinect.initVideo();
  kinect.enableMirror(true);
}

void draw() {
  background(0);
  kinect.enableIR(true);

  // Descomentar cuando se este calibrando o comprobando la detección
  image(kinect.getVideoImage(), 0, 0);

  detector.medicion(kinect.getVideoImage());
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
