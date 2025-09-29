"""
# File for loop examples:
    * for
"""
fruitList = ["apple", "banana", "cherry", "orange", "strawberry"]
newList = [] # New list for use list comprehension

"""
# Itinerate the array 'fruitList' using for
for x in fruitList:
    print(x)
"""

"""
# Itinerate the array 'fruitList' using while
i = 0
while i < len(fruitList):
    print(fruitList[i])
    i += 1
"""

# Using the list comprehesion, this offers a shorter
# syntax when you want to create a new list based on
# the values of an existing list
for x in fruitList:
    if "a" in x:
        newList.append(x)

print(newList)
