#Condition Controlled Loop
condition = 0
while condition<=12:
    print(2*condition)
    condition+=1

#Counter Controlled Loop

for num in range(10,21):
    print(num)

#Collection Controlled Loop
list1=[10,20,30,40,50,60,70,80,90]
for value in list1:
    print(value)

import keyword
print(keyword.kwlist)

print(len(keyword.kwlist))

print(type(list1))

#Delete a Python object

del(list1)

list_val=[]
statement = "Break Time"
for words in statement:
    list_val.append(words)

print(list_val)

#conditional statements
bro_age=int(input("Enter brothers Age: "))
sis_age=int(input("enter sisters Age: "))

if bro_age>sis_age:
    print("Brother is elder")
elif bro_age<sis_age:
    print("Sister is elder")
else:
    print("Both are twins")


#Create a login access using loop and condition statements.
while True:
    choice=input("Choose an option: ")
    if choice=='login':
        user = input("Enter Username: ")
        password = input("Enter User password: ")
        if user == 'admin' and password== 'pass@word':
            print("Login successfull.Welcome Onboard")
        else:
            print("Incorrect Username or Password: ")
    
    elif choice=='quit':
        print("Exiting from the program.Good Bye")
        break
    else:
        print("Invalid Choice.Choose Login or Quit")


