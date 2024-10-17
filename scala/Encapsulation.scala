class Employee(private var empName:String,private var salary:Int){
  //Set Method
  //Data
  def setName(newEmpName:String):Unit = {
    if(newEmpName.nonEmpty) empName = newEmpName
  }
    
  def setSalary(newSalary:Int):Unit = {
    if(newSalary>0) salary = newSalary
  }
  
  //Get Method
  def getName:String = empName
  
  def getSalary:Int = salary
}

object Encapsulation extends App{
  val emp1 = new Employee("Tom",30000)
  emp1.setName("Jerry")
  emp1.setSalary(50000)
  println(emp1.getName)
  println(emp1.getSalary) 
}