#User Defined Functions(UDF)
def greeting():
    return "Hello,How are you doing today?"

print(greeting())


#In build functions or methods
#Map
print(list(map(lambda x:x*2,[10,20,30,40,50])))
#Filter
print(list(filter(lambda x:x%2==0,[10,25,30,45,50])))
#Reduce
from  functools import reduce

print(reduce(lambda x,y:x+y,[1,2,3,4,5]))



#Lambda functions Annonymous Functions-One line functions
multiplier = lambda x:x*2
print(multiplier(20)) #declare a function with an arguement

#Break and Continue
city = ['Kochi','Trivandrum',None,'Banglore',None,'Thrissur','Hyderabad']

for c in city:
    if c==None:
        continue
    print(c)

#Create a function and apply it in reduce() method to return aggregate sales data

sales=[{'product':'Laptop','amount':50000},
       {'product':'iPhone','amount':150000},
       {'product':'Smart TV','amount':75000},
       {'product':'Gaming Console','amount':35000},
       {'product':'Laptop','amount':90000},
       {'product':'iPhone','amount':70000},
       {'product':'Mouse','amount':500}]

#Accumulate total sales revenue for each product
def accumulate(accumulator,transaction):
    product=transaction["product"]
    amount = transaction["amount"]
    accumulator[product]+=amount
    return accumulator

from functools import reduce
from collections import defaultdict

total_sales = reduce(accumulate,sales,defaultdict(int))

for key,value in total_sales.items():
    print(f"{key}: ₹{value}")

#find top selling product and top-selling revenue
max(total_sales,key=total_sales.get)
print(f"Top selling product: {max(total_sales)}")
print(f"Top selling Revenue: {total_sales[max(total_sales)]}")


# reduce(function,iterable,initializer(optional)); 
# Initializer -A starting value used to initialize 
# defaultdict() - subset of dictionary  - to avoid KeyError

#*args
def add(*args):
    total_sum=sum(args)
    return total_sum

l1=[1,2,3,4,5]
print(add(2,4,5))
print(add(*l1))

#**kwargs
def employee_details(**kwargs):
    for key,values in kwargs.items():
        print(f"{key}:{values}")

employee_details(name="Anu",age="20",city="Kochi",job="Data engineer")
anu_details = {'name':"Anu",'age':'20','city':'Kochi','job':'Data engineer'}
employee_details(**anu_details)




        
        










