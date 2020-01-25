import UIKit

//print("Hello World!")

let defineConstant = 50
var defineVariable = 10

defineVariable = 15

//Swift can infer the variable type at the time of declaration
//You can also declar the variable's type

var stringVar: String = "I'm a string"

print(defineConstant + defineVariable)
print("Hi.\nTrying out a newline char!")

let quotation = """
This is a quote:
"Hi, I'm being quoted"
And each of these is on a new line!
"""

print(quotation)

var testArray = [String]()
var testDictAge = [String:Int]()

testArray.append("Item 0")

testDictAge["Robbie"] = 26

print(testArray)
print("They are \(testDictAge["Robbie"]!) years old")

let individualScores = [10, 52, 15, 71, 1, 12]
var teamScore = 0

for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}

print(teamScore)

var optionalString: Any? = "hi"
optionalString = nil

print(optionalString)

var canItChange: Any = 10
canItChange = "10"

print("It can change! --> \(canItChange)")

var nickname: String? = nil
var firstName: String? = "Robbie"
var lastName: String = "Gay"

firstName = nil

print("His name is \(nickname ?? firstName ?? lastName)")

let twoDimArray = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]

var largest = 0
var kindOfNumber = ""

for (kind, numbers) in twoDimArray {
    for number in numbers {
        if number > largest {
            largest = number
            kindOfNumber = kind
        }
    }
}

print("The largest number is \(largest), it is a \(kindOfNumber)")

var n = 2

repeat {
    n *= 2
} while n < 3

print(n)

//Can tell a loop to run a certain amount of times
//Can use _ for a blank variable
var total = 0

for _ in 0..<4 {
    total += 1
}

print(total)

