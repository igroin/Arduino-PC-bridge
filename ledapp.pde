
int speed = 115200;
int dim = 0;
import processing.serial.*;
Serial serial;
import controlP5.*;
ControlP5 cp5;
String portName;    
boolean skip = true;

void setup() {
  size(400, 400);   
  setupGUI();        
}

void draw() {
  background(120);   
  parsing();         

  
}



void sendPacket(int key, String data) {
  if (serial != null) serial.write(str(key) + ',' + data + ';');
  //"key,data;"
}



void parsing() {
  
  if (serial != null && serial.available() > 0) {
    String str = serial.readStringUntil('\n').trim(); 
    String data[] = str.split(",");                  
    //int[] data = int(split(str, ',')); 
    if (skip) {
      skip = false;
      return; 
    }


    switch (int(data[0])) {  
    case 0:
      break;
    case 1:
      break;
    case 2:
      break;
    }
  }
}


void setupGUI() {
  cp5 = new ControlP5(this);
  cp5.setFont(createFont("Calibri", 16));  

  // выпадающий список
  cp5.addScrollableList("com")
    .setPosition(10, 10)
    .setSize(80, 100)
    .setBarHeight(30)
    .setItemHeight(30)
    .close()
    .addItems(Serial.list());    
  ;

 
  cp5.addButton("open").setPosition(90, 10).setSize(80, 30);
  cp5.addButton("close").setPosition(170, 10).setSize(80, 30);
  cp5.addToggle("led").setPosition(170, 50).setSize(80, 30).linebreak();
 
  cp5.addSlider("dimmer").setRange(50,255);
}



void com(int n) {
  portName = Serial.list()[n];  
}


void open() {
  if (portName != null && serial == null) {     
    serial = new Serial(this, portName, speed); 
    skip = true;    
  }
}


void close() {
  if (serial != null) { 
    serial.stop();      
    serial = null;      
  }
}
void led (int tog){
  
  sendPacket(0,str(tog));

 
}

void dimmer (float val)
{
sendPacket(1,str(val));

}
