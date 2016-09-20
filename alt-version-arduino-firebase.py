# alternate version of arduino firebase readline

# pyserial read from arduino sensor values
import serial
import serial.tools.list_ports
from firebase import firebase
import pyrebase
import time

#GLOBAL VARIABLES
angle = 0
rpm = 0
prevRPM = rpm
prevAngle = angle
port_to_use = ''

#FIREBASE SETUP
config = {
  "apiKey": "muOCqVoInSt9XOIoT5tHoDzHfxbLJwosXbfaldHU",
  "authDomain": "hackmitproject-78bca.firebaseapp.com",
  "databaseURL": "https://hackmitproject-78bca.firebaseio.com/",
  "storageBucket": "hackmitproject-78bca.appspot.com"
}
firebase = pyrebase.initialize_app(config)
# ADD YOUR FIREBASE SETUP HERE

#sensorValStorage = firebase('https://hackmitproject-78bca.firebaseio.com/sensor')

def parseSerial(line):
    global angle, rpm
    line = str(line)[1:-2]
    vals = line.split(',')

    #in the case of a bad packet, just pass so that the script doesn't crash
    try:
        angle = float(vals[0])
        rpm = float(vals[1])
        return True
    except:
        return False

#print out the available ports for debugging purposes
ports = [i.device for i in list(serial.tools.list_ports.comports())]
port_to_use = ports[-1] #default
print "Available ports:"

#find the port with usbmodem in the name, and make that the active port
for i in  ports:
    print i
    if 'usbmodem' in i:
        port_to_use = i
        print "Using port:", port_to_use
        print ""

#create the serial device, and open the port
ser = serial.Serial(port_to_use, 9600)
print "Setup serial."

#result_angle = firebase.post('/rpm', data={"angle":angle, "rpm":rpm} , params={'print': 'pretty'})

db = firebase.database()
counter = 0
while True:
	counter += 1
	#parse the line, storing it to global variables
	parseSerial(ser.readline())

    if rpm==0 or rpm==0:
        rpm=0.01
    if angle==0.0 or angle==0:
        angle==0.01
    if abs(angle-prevAngle)>2:
        print "A:", angle
        db.child("angle").update({"angle": angle})
        prevAngle = angle
    if counter > 10 or (abs(rpm-prevRPM)>8):
        print "R:", rpm
        prevRPM = rpm
        counter = 0
        db.child("rpm").update({"rpm": rpm})


ser.close()
