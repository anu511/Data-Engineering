# public ,private(__) and protected(_) access modifiers
#Protected access modifiers

class Employee:
    #Protected Members
    _name = None
    _department = None

    #Declare a constructor
    def __init__(self,name,department):
        self._name=name
        self._department=department

    #Protected Method
    def _display(self):
        print("Employee Name: ",self._name)
        print("Employee Department: ",self._department)

class EmpDetails(Employee):
    def __init__(self, name, department):
        super().__init__(name, department)

    def displayDetails(self):
        self._display()

empObj = EmpDetails("Uday","IT")
empObj.displayDetails()

# print(type(None))

#Private Access Modifiers
class PEmployee:
    #Private Members
    __name = None
    __department = None

    #Declare a constructor
    def __init__(self,name,department):
        self.__name=name
        self.__department=department

    #Protected Method
    def __display(self):
        print("Employee Name: ",self._name)
        print("Employee Department: ",self._department)

class PEmpDetails(Employee):
    def __init__(self, name, department):
        super().__init__(name, department)

    def displayDetails(self):
        self.__display()

pvtObj = PEmpDetails("Rohit","IT")
#Cannot access __display() from private object as it is not accessible
pvtObj.displayDetails()
