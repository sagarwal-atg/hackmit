from firebase import firebase
firebase = firebase.FirebaseApplication('https://hackmit-bc42a.firebaseio.com/angle.json', None)
new_user = 'Ozgur Vatansever'

i = 0
while True:
    result_angle = firebase.post('/angle', data={"angle":i * 10 } , params={'print': 'pretty'})
    result_angle = firebase.post('/rpm', data={ "rpm":i * 20} , params={'print': 'pretty'})
    i+=1
    print result_angle

#print result_rpm
print "Success"
