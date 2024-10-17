#Use datetime Library 
import datetime
print("Display Today's Date: ",datetime.date.today())
print(datetime.datetime.now())

today = datetime.date.today()
print("Day:",today.day," Month:",today.month," Year:",today.year)

#Usage of datetime in example

class Person:
    def __init__(self,name,surname,birthdate,address,contact,email):
        self.name=name
        self.surname=surname 
        self.birthdate=birthdate
        self.address=address
        self.contact=contact
        self.email=email

    def age(self):
        today=datetime.date.today()
        age = today.year-self.birthdate.year
        if today< datetime.date(today.year,self.birthdate.month,self.birthdate.day):
            age-=1
        if age<0:
            print("Person is not born yet")
        return age
    
person = Person("Anu","xyz",datetime.date(2003,1,24),"UST,Trivandrum","7736482398","anu@ust.com")
print(person.age())

#Files Handling
# w for new file
# a for appending
# r+ read first then write
#w+ write then read
fileObj = open('newFile.txt')
print(fileObj.read())

fileobj = open('newFile.txt','r')

#Open file in write mode
fileObj = open('newtextFile.txt',"w")
#Do write the input content in an empty file
fileObj.write("This is new content added to the new file. ")
fileObj.close()

print()
#r+ Open file in read and write mode
fileobj1 = open('newtextfile.txt','r+')
print(fileobj1.read())
print("Read again")
#seek(0) position the file cursor at the first position

fileobj1.seek(0)
print(fileobj1.read())

fileobj1.write("\nThis is another content appended in the EOF.")
fileobj1.seek(0)
print(fileobj1.read())

#w+ Open file in write and then read mode
fileobj2 = open("filename.txt",'w+')
print(fileobj2.read())
print("Read again")
fileobj2.write("Write content in the new file.")
fileobj2.seek(0)
print(fileobj2.read())
fileobj2.close()

#Usage of with in file 

with open("newtextfile.txt","r+") as fileObj:
    data = fileObj.readlines()
    for line in data:
        word=line.split()
        print(word)

# List comprehension
list_2 =[]
for x in range(1,11):
    if x%2==0:
        list_2.append(x)

list_1= [x**2 for x in range(1,11) if x%2 ==0]
print(list_1)
print(list_2)

marks = [50, 62, 15, 76, 57, 97, 82]
result = lambda mark: ('F' if mark < 40 else 'D' if mark <= 50 else 'C' if mark<=60
                        else 'B' if mark<=70 else 'A'  )
grades = [result(mark) for mark in marks]
print(grades)



