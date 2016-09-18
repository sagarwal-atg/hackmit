int halfRevs;
float rpm;
unsigned long timeold;
 
 void setup()
 {
   Serial.begin(115200);

   //Initialize the intterrupt pin (Arduino digital pin 2)
   attachInterrupt(0, magnet_detect, RISING);
   
   halfRevs = 0;
   rpm = 0;
   timeold = 0;
 }
 
 void loop() 
 {
   if (halfRevs >= 2) { 
     rpm = float(halfRevs) * 30000 / (millis()-timeold); //30000 because divide revs by 2
     timeold = millis();
     halfRevs = 0;
     if (rpm > 0) { //don't print out rpms if bike is stationary
      Serial.println(rpm);
     }
     
   }
 }

 //This function is called whenever a magnet/interrupt is detected by the arduino
 void magnet_detect()
 {
  `//increment the # of half revolutions
   halfRevs++;
 }
