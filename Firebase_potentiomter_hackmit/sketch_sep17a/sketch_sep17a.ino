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

int potPin = 2;    // select the input pin for the potentiometer
int ledPin = 13;   // select the pin for the LED
double val = 0;       // variable to store the value coming from the sensor
double angle = 0;

void setup() {
  pinMode(ledPin, OUTPUT);  // declare the ledPin as an OUTPUT
  Serial.begin(9600);      // open the serial port at 9600 bps:    
}

void loop() {
  val = analogRead(potPin);    // read the value from the sensor
  Serial.print("Potentiomter value: ");
  Serial.print(val);
  Serial.print("\n");
  
  if( val >= 512)              // normalizing the potentiometer value to get the angle 
     {  val = val - 512 ; 
        angle = val/511; 
        angle = angle * 90 ;
        Serial.print("angle: ");
        Serial.print(angle);     
      }
  else 
    {
       val = 512 - val; 
       angle = val/512;
       angle = - angle;
       angle = angle * 90; 
       Serial.print("angle: ");
       Serial.print(angle);      
    }
  digitalWrite(ledPin, HIGH);  // turn the ledPin on
  delay(1000);                  // stop the program for some time

  digitalWrite(ledPin, LOW);   // turn the ledPin off
  delay(1000);                  // stop the program for some time
  Serial.print("\n");
}
