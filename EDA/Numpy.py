import numpy as np
arr1=np.array([10,20,30,40,50,60,70,80,90],dtype='int8')
print(arr1)

#Numpy array in-built methods and properties
print(arr1.shape)

print(type(arr1))
print(arr1.dtype)   # returns data type
print(arr1.itemsize)  
print(arr1.size)   #size() - Returns total size of array
print(arr1.ndim)   #Dimentionality - 1D
print(arr1.nbytes) #nbytes = Total size of Numpy Array

# Types of numpy array
#Create 1D array
arr2= np.array([10,20,24,40,53,4])

#Create 2D array
arr3=np.array([[18,11,13,15],
               [33,75,10,39],
               [41,54,47,25]])
print(arr3.shape) # shape return (rows,columns)
print(arr3.itemsize)  
print(arr3.ndim)   #Dimentionality - 1D
print(arr3.nbytes)

#three dimension (3-D) array
arr4=np.array([[[18,11,15,2,15],
               [28,41,5,29,39],
               [1,2,65,2,22]],

               [[1,91,85,87,15],
               [7,4,199,59,61],
               [1,2,65,67,2]]])
print(arr4.shape)
print(arr4.ndim)

#Slicing and indexing in numpy array
print(arr3[0])      #SLicing for first row elements
print(arr3[:,:])    #All rows and all columns
print(arr3[:,0])    #Slicing elements from all rows and first column index
print(arr3[:,0:2])   #Slicing first two columns
print(arr3[1:-1,1:-1])     # start index = 1,stop index = last index position

#Slicing 3-D numpy array
print(arr4[1,1,2])      #[matrix,row,col]

#Create numpy array using functions
arr5 = np.arange(1,51)  #Create 1-D Array
print(arr5)

arr6 = np.arange(1,51).reshape(10,5)
print(arr6)

#zero matrix : np.zero(shape)
arr7=np.zeros((4,7),dtype = 'int16')
print(arr7)

print(arr7.astype('float16'))   #type casting from int to float

#ones matrix
arr8=np.ones((5,5))
print(arr8)

#identity matrix
arr9=np.identity(7)
print(arr9)

#empty matrix
arr10=np.empty((6,1))
print(arr10)

#fill all position with 2.0 float value
arr10.fill(2.0)
print(arr10)

#full
print(np.full(10,6.1))

#linspace - to create N evenly spaced array (start,stop,element)
print(np.linspace(10,100,10))

#logspace - N evenly spaced array elements on a log scale between start and stop
arr12 = np.logspace(0,1,10,base=2)
print(arr12)

#Excercise
arr13=np.full((10,10),1)
arr13[1:-1,1:-1].fill(0)
print(arr13)
print()

#Excerxise 2 
arr14= np.full((10,10),1)
arr14[::2,::2].fill(0)
arr14[1::2,1::2].fill(0)
print(arr14)

#Mathematical operations
arr15= np.array([[[1,3,5],
          [4,8,7],
          [9,11,13]],
          [[2,4,7],
           [3,1,5],
           [5,2,8]]])
print(arr15.sum())
print(arr15.sum(axis=0))    #rowise
print(arr15.sum(axis=1))    #columnwise addition
print(arr15.min())
print(arr15.max())

#where() - returns index position for condition  = True
arr16 = np.arange(1,21).reshape(5,4)
print(np.where(arr16>8))

#statistical methods
arr17 = np.arange(1,37).reshape(6,6)
print(arr17.mean())         #mean
print(arr17.mean(axis=0))   #mean -rowwise
print(arr17.mean(axis=1))   #mean - columnwise

print(np.std(arr17))    #standard deviation
print(np.var(arr17))    #variance

#reverse an array
array_3 = np.arange(50)
print(array_3)
print(array_3[::-1])
print(np.flip(arr6))
print()
print(np.flipud(arr6))
print()
print(np.fliplr(arr6))

#Flatten - to convert n-d Array into 1D Array
array_4 = np.random.randint(10,50,size=(5,3))
print(array_4)

#2D to 1D
print(array_4.flatten())

#Ravel - flattens n-d array to 1-d array
print(array_4.ravel())

#np.argmax() -  returns index position of maximum value along the axis
print(np.argmax(array_4))
