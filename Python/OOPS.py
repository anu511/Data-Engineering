var_1=10
#var1 is an object of class integer
print(type(var_1))

import datetime
#Declare an object
class Person:
    def __init__(self,*args):
        if len(args)>=4:
            self.name=args[0]
            self.age=args[1]
            self.email=args[2]
            self.dob=args[3]
        else:
            raise ValueError("Not enough arguements passed.Expected exactly 4")
    
    def display(self):
        print("Person Details")
        print(f"Name= {self.name}\nAge= {self.age}\nEmail= {self.email} \nDOB= {self.dob}")

#Declare an object
p1=Person('Anu','20','anu.s@ust.com','24/01/03')
p1.display()

#Inheritance
# Single level Inheritance

class Vehicle:
    def __init__(self,brand,model,mileage):
        self.brand=brand
        self.model=model
        self.mileage=mileage
    
    
class Car(Vehicle):
    def __init__(self,brand,model,mileage,speed,color):
        super().__init__(brand,model,mileage)
        self.speed=speed
        self.color=color

    def display(self):
        print(f"Brand ={self.brand}\nModel= {self.model}\nMileage= {self.mileage}")
        print(f"Speed = {self.speed}\nColor= {self.color}")

car1=Car('Honda',2024,50,50,'Black')
car1.display()

#Multilevel inheritance

class Entity:
    def __init__(self,name):
        self.name=name

class User(Entity):
    def __init__(self, name,email):
        super().__init__(name)
        self.email=email

class Admin(User):
    def __init__(self, name, email,permissions):
        super().__init__(name, email)
        self.permissions=permissions
    
    def display(self):
        return f"{self.name} has the  following permissions {','.join(self.permissions)} "
    
firstObj = Admin("Admin","admin@example.com",['read','write','execute'])
print(firstObj.display())   

#Hierarchical Inheritance

class phone:
    def __init__(self,brand,model,color):
        self.brand=brand
        self.model=model
        self.color=color

class android(phone):
    def __init__(self,brand,model,color,os,version,processing):
        super().__init__(brand,model,color)
        self.os=os
        self.version=version
        self.processing=processing

    def androiddisplay(self):
        print("Android Phone description:")
        print(f"Brand: {self.brand}, Model: {self.model}, Color: {self.color} ")
        print(f"OS: {self.os}, Version: {self.version}, Processing: {self.processing}")

class iphone(phone):
    def __init__(self,brand,model,color,os,version,processing):
        super.__init__(brand,model,color)
        self.os=os
        self.version=version
        self.processing=processing

    def iphonedisplay(self):
        print("iPhone description:")
        print(f"Brand: {self.brand}, Model: {self.model}, Color: {self.color} ")
        print(f"OS: {self.os}, Version: {self.version}, Processing: {self.processing}")

androidObj=android("Samsung","S23","Blue","Android","14","Exynos")
androidObj.androiddisplay()

#Multiple Inheritance
class arts:
    def __init__(self,category):
        self.category=category

class sports:
    def __init__(self,sport):
        self.sport=sport

class student(arts,sports):
    def __init__(self, category,sport,sname):
        arts.__init__(self,category)
        sports.__init__(self,sport)
        self.sname=sname

    def display(self):
        print(f"{self.sname} likes {self.category} and {self.sport}")

obj1=student("Dance","Football","Anu")
obj1.display()

#Abstraction
# import abstract class package
from abc import ABC,abstractmethod
class Bill(ABC):
    def print_slip(self,amount):
        print("Purchase Amount: ",amount)

    @abstractmethod
    def bill(self,amount):
        pass

class DebitCardPayment(Bill):
    # Method Overriding
    def bill(self,amount):
        print("Debit card payment of: ",amount)

absObj = DebitCardPayment()
absObj.print_slip(10000)
absObj.bill(10000)




        




