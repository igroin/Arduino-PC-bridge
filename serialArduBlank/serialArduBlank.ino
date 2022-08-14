
#include "Parser.h"       
#include "AsyncStream.h"  
AsyncStream<50> serial(&Serial, ';');   
int toggle = 0 ;
int dimmer = 50 ;
void setup() {
  Serial.begin(115200);
  pinMode(3,1);
}

void loop() {
  parsing();
if(toggle == 1)
{
  analogWrite(3,dimmer);
  }
  else
  {
    digitalWrite(3,0);
    }
 
}


void sendPacket(int key, int* data, int amount) {
  Serial.print(key);
  Serial.print(',');
  for (int i = 0; i < amount; i++) {
    Serial.print(data[i]);
    if (i != amount - 1) Serial.print(',');
  }
  Serial.print('\n');
}


void parsing() {
  if (serial.available()) {
    Parser data(serial.buf, ',');  
    int ints[10];           
    data.parseInts(ints);   

    switch (ints[0]) {      
      case 0:
     toggle = ints[1];
        break;
      case 1:
      dimmer = ints[1];
        break;
      default: 
        break;
    }
  }
}
