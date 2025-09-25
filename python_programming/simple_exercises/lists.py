"""
# Basic Python lists
# Source: https://www.w3schools.com/python/python_lists.asp
"""

# 8th elements.
myList = ["apple", "banana", "cherry", "orange", 
          "strawberry", "kiwi", "melon", "mango"]

print(myList)
# The str() function convert the integer to a string.
print("The lenght of the array is: " + str(len(myList)))

#list1 = ["abc", 34, True, 40, "banana"]
#print(list1)

# Access the items of the array.
print("The first element of the array is: " + str(myList[0]))

# Negative indexing means start from the end.
print("The last element of the array is: " + str(myList[-1]))

# Range of indexes
# The search will start at index 1 (included)
# and end at index 3 (not included).
print("The second and third element: " + str(myList[1:3]))

# This example returns the items from the beginning
# to, but NOT including the fifh element.
print("The first element to fourth element: " + str(myList[:4]))

# This example returns the items from third
# (inclunding this element) to the end.
# This can be done the same way with the negative numbers.
print("The first element until third element: " + str(myList[2:]))