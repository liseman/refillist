//refillist 1.0
//initially: send readings over imp every 1 second

//imp 
#include <SoftwareSerial.h>
SoftwareSerial softSerial(14,15); //rx, tx

//timers
#include <Time.h>
#include <TimeAlarms.h>

//rfid
#include <Wire.h>
#include <Adafruit_NFCShield_I2C.h>
#define IRQ   (2)
#define RESET (3)  // Not connected by default on the NFC Shield
Adafruit_NFCShield_I2C nfc(IRQ, RESET);

uint32_t cardidentifier = 0;


String card;
//array to hold all variables we care about sending to server
String toSend;

int sensorValue = 0;

void setup()
{

  
  //send data to server every 1 second
  //Alarm.timerRepeat(1, sendData);
  
  //Alarm.timerRepeat(1, sendVals);
  
  //serial
  Serial.begin(9600);
  softSerial.begin(2400);
  
  Serial.println("Hello!");

  nfc.begin();

  uint32_t versiondata = nfc.getFirmwareVersion();
  if (! versiondata) {
    Serial.print("Didn't find PN53x board");
    while (1); // halt
  }
  // Got ok data, print it out!
  Serial.print("Found chip PN5"); Serial.println((versiondata>>24) & 0xFF, HEX); 
  Serial.print("Firmware ver. "); Serial.print((versiondata>>16) & 0xFF, DEC); 
  Serial.print('.'); Serial.println((versiondata>>8) & 0xFF, DEC);
  
  // configure board to read RFID tags
  nfc.SAMConfig();
  
  Serial.println("Waiting for an ISO14443A Card ...");
  
}

void loop()
{
  //checks state of scheduled events, as per http://answers.oreilly.com/topic/2704-how-to-create-an-arduino-alarm-that-calls-a-function/ 
  //Alarm.delay(1);
  delay(1000);
  analogRead(A2);
  delay(1000);
  sensorValue = analogRead(A2);
  delay(1000);
  Serial.println(sensorValue);
  delay(1000);
  rfidRead();
  Serial.println("loopy");
  sendVals();
  //delay(1000);
}

void rfidRead()
{
  uint8_t success;
  uint8_t uid[] = { 0, 0, 0, 0, 0, 0, 0 };  // Buffer to store the returned UID
  uint8_t uidLength;                        // Length of the UID (4 or 7 bytes depending on ISO14443A card type)
    
  // Wait for an ISO14443A type cards (Mifare, etc.).  When one is found
  // 'uid' will be populated with the UID, and uidLength will indicate
  // if the uid is 4 bytes (Mifare Classic) or 7 bytes (Mifare Ultralight)
  success = nfc.readPassiveTargetID(PN532_MIFARE_ISO14443A, uid, &uidLength);
  
  if (success) 
  {
    cardidentifier = uid[3];
    cardidentifier <<= 8; cardidentifier |= uid[2];
    cardidentifier <<= 8; cardidentifier |= uid[1];
    cardidentifier <<= 8; cardidentifier |= uid[0];
    //Serial.println(cardidentifier);
    if (cardidentifier == 3574322123) Serial.println("a1");
    if (cardidentifier == 3574523259) Serial.println("b2");
    if (cardidentifier == 3574526203) Serial.println("c3");
    if (cardidentifier == 3574725643) Serial.println("d4");
    if (cardidentifier == 3574322123) card = "a1";
    if (cardidentifier == 3574523259) card = "b2";
    if (cardidentifier == 3574526203) card = "c3";
    if (cardidentifier == 3574725643) card = "d4";
    //sendVals();
  }
}


void sendVals()
{
  Serial.println(cardidentifier);
  //softSerial.print(cardidentifier);
  toSend  = String("");
  delay(1000);
  Serial.println(sensorValue);
  toSend = String("R" + card + "R" + "W" + sensorValue + "W");
  Serial.println(toSend);
  softSerial.print(toSend);
  
  /*
  char temp[10];
  dtostrf(tempNew,1,2,temp);
  char hum[10];
  dtostrf(humidNew,1,2,hum);
  toSend = String(toSend + "L" + luxNew + "L" + "M" + moistNew + "M" + "T" + temp + "T" + "H" + hum + "H");
  //Serial.println(toSend);
  */
  //Serial.print("sending");
  //Serial.println(toSend);
  //softSerial.print(toSend);
}

