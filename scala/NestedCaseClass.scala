object NestedCaseClass{
  def main(args: Array[String]):Unit = {
    //Define a case class for an Employee
    case class Employee(name:String,id:Int)

    //Define a case class for an Department,which contains a list employees
    case class Department(deptName: String, employees:List[Employee])
    
    //Create an Instance of Employee
    val emp1=Employee("Reshma",123456)
    val emp2=Employee("Maria",654321)
    val emp3=Employee("Vigneshwar",123456)
    
    //Create an instance of Department
    val dept1 = Department("HR",List(emp1,emp2))
    val dept2 = Department("IT",List(emp1,emp2,emp3))
    
    //Pattern matching with another case class
    dept1 match{
      case Department(deptName,employees) =>
        println(s"Department: $deptName")
        employees.foreach{
          case Employee(name,id) =>
            println(s"Employee: $name, Id: $id")
        }
    }
    println()

    dept2 match {
      case Department(deptName, employees) =>
        println(s"Department: $deptName")
        employees.foreach {
          case Employee(name, id) =>
            println(s"Employee: $name, Id: $id")
        }
    }
    
  }
}
