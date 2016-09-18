
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


//This function is called whenever a magnet/interrupt is detected by the arduino
 void magnet_detect()
 {
  //increment the # of half revolutions
   halfRevs++;
 }


void setup() {
  pinMode(ledPin, OUTPUT);  // declare the led pins as OUTPUT

  pinMode(redIndicatorPin, OUTPUT);
  pinMode(greenIndicatorPin, OUTPUT);

  Serial.begin(9600);      // open the serial port at 115200 bps:

  //Initialize the intterrupt pin (Arduino digital pin 2)
   attachInterrupt(hallEffectPin, magnet_detect, RISING);

   halfRevs = 0;
   rpm = 0;
   timeold = 0;
}

void loop() {
<<<<<<< HEAD

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
  if (halfRevs >= 2) {
     rpm = float(halfRevs) * 30000 / (millis()-timeold); //30000 because divide revs by 2
     timeold = millis();
     halfRevs = 0;
     }

  //INDICATORS

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
  }


  //DEBUGGING AREA
  Serial.print("Angle: ");
  Serial.print(angle);
  Serial.print(" | ");
  Serial.print("RPM: ");
  Serial.print(rpm);
  Serial.print('\n');

  //blink the status LED
  digitalWrite(ledPin, HIGH);  // turn the ledPin on
  delay(10);              // stop the program for some time
  digitalWrite(ledPin, LOW);   // turn the ledPin off
}
