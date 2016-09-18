/* Analog Read to LED
 * ------------------ 
 *
 * turns on and off a light emitting diode(LED) connected to digital  
 * pin 13. The amount of time the LED will be on and off depends on
 * the value obtained by analogRead(). In the easiest case we connect
 * a potentiometer to analog pin 2.
 *
 * Created 1 December 2005
 * copyleft 2005 DojoDave <http://www.0j0.org>
 * http://arduino.berlios.de
 *
 */


/*
#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>

// Set these to run example.
#define FIREBASE_HOST "hackmit-bc42a.firebaseio.com"
#define FIREBASE_AUTH "V73Dt8zTwjtPcp7BEYD8BpRx2XzuQvqKMAMlGpyI"
#define WIFI_SSID "LenhartFamily"
#define WIFI_PASSWORD "correcthorsebatterystaple"


void setup() {
  Serial.begin(9600);

  // connect to wifi.
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("connected: ");
  Serial.println(WiFi.localIP());
  
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
}

*/
//INDICATOR LEDs
int redIndicatorPin = 2;
int greenIndicatorPin = 1;


//POTENTIOMETER STUFF
int potPin = A0;    // select the input pin for the potentiometer
int ledPin = 13;   // select the pin for the LED
double potRead = 0;       // variable to store the value coming from the sensor
double angle = 0;
double potCenterRead = 591;


//HALL EFFECT STUFF
int halfRevs;
float rpm;
unsigned long timeold;
int hallEffectPin = 0;


//SMOOTHING FUNCTION STUFF
const int numReadings = 5;

int readings[numReadings];      // the readings from the analog input
int readIndex = 0;              // the index of the current reading
int total = 0;                  // the running total
int average = 0;                // the average


//This function is called whenever a magnet/interrupt is detected by the arduino
 void magnet_detect()
 {
  //increment the # of half revolutions
   halfRevs++;
 }


void setup() {
  pinMode(ledPin, OUTPUT);  // declare the led pins as OUTPUT
  //pinMode(redIndicatorPin, OUTPUT); 
  //pinMode(greenIndicatorPin, OUTPUT);
  
  Serial.begin(9600);      // open the serial port at 115200 bps:    

  //Initialize the intterrupt pin (Arduino digital pin 2)
   attachInterrupt(hallEffectPin, magnet_detect, RISING);

  for (int thisReading = 0; thisReading < numReadings; thisReading++) {
    readings[thisReading] = 0;
  }
   
   halfRevs = 0;
   rpm = 0;
   timeold = 0;
}

void loop() {
  
  //GET VALUE FROM THE POTENTIOMETER
  potRead = analogRead(potPin);  // read the value from the sensor
  if (potRead >= potCenterRead)  // normalizing the potentiometer value to get the angle 
     {  potRead = potRead - potCenterRead ; 
        angle = potRead/511; 
        angle = angle * 810; //extra factor of 9 to deal with weird non-linearity of potentiometer
     }
  else 
    {
       potRead = potCenterRead - potRead; 
       angle = potRead/511;
       angle = -angle * 110;     
    }

  //CALCULATE RPMs
  if (halfRevs >= 4) { 
    Serial.print("thinks there are rpms");
     rpm = float(halfRevs) * 15000 / (millis()-timeold); //30000 because divide revs by 2
     timeold = millis();
     halfRevs = 0;
  } else if (millis()-timeold > 1000) {
    rpm = 1;
  }

  //INDICATORS
  /*
  //if the bike is not moving, turn off green
  if (rpm == 0) {
    digitalWrite(greenIndicatorPin, LOW);
  } else {
    digitalWrite(greenIndicatorPin, HIGH);
  }

  //if the handlebars are centered, light up the red indicator
  if (abs(angle) <= 1) {
    digitalWrite(redIndicatorPin, HIGH);
  } else {
    digitalWrite(redIndicatorPin, LOW);
  } */

  // subtract the last reading:
  total = total - readings[readIndex];
  // read from the sensor:
  readings[readIndex] = rpm;
  // add the reading to the total:
  total = total + readings[readIndex];
  // advance to the next position in the array:
  readIndex = readIndex + 1;

  // if we're at the end of the array...
  if (readIndex >= numReadings) {
    // ...wrap around to the beginning:
    readIndex = 0;
  }

  // calculate the average:
  average = total / numReadings;
  // send it to the computer as ASCII digits
  //Serial.println(average);
  //delay(1);        // delay in between reads for stability
  

  //DEBUGGING AREA
  Serial.print("(");
  Serial.print(angle);
  Serial.print(",");
  Serial.print(average);
  Serial.print(')');
  Serial.print('\n');

  delay(10);
}

