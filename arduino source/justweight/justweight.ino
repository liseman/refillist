//refillist 1.0
//initially: send readings over imp every 1 second

//imp 
#include <SoftwareSerial.h>
SoftwareSerial softSerial(14,15); //rx, tx

//rfid
#include <Wire.h>
#include <Adafruit_NFCShield_I2C.h>
#define IRQ   (2)
#define RESET (3)  // Not connected by default on the NFC Shield
Adafruit_NFCShield_I2C nfc(IRQ, RESET);

uint32_t cardidentifier = 0;

int loadPort = 3;
int load = 0;

//array to hold all variables we care about sending to server
String toSend;

void setup()
{

  //serial
  Serial.begin(9600);
  softSerial.begin(2400);

}

void loop()
{
  analogRead(loadPort);
  delay(100);
  load = analogRead(loadPort);
  Serial.println(load);
  sendVals();
  delay(400);
}

void sendVals()
{
  Serial.println(load);
  //softSerial.print(cardidentifier);
  toSend  = String("");
  //Serial.println(sensorValue);
  String shelf = "one";
  toSend = String(load);
  Serial.println(toSend);
  softSerial.print(toSend);
  
}

