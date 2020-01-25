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

//Can tell a loop to run a certain amount of times --> ..< omits upper value ... includes both values
//Can use _ for a blank variable
var total = 0

for _ in 0..<4 {
    total += 1
}

print(total)

func food(food: String, price: Float, dayOfTheWeek: String) -> String {
    return "Today is \(dayOfTheWeek). We are serving \(food). In costs \(price)"
}

print(food(food: "Pizza", price: 12.50, dayOfTheWeek: "Saturday"))

func test(_ person: String) {
    return print(person)
}

test("Robbie")

//Func can return multiple values by using a tuple

func returnMulti(firstNumber val1: Int, secondNumber val2: Int) -> (firstNum: Int, secondNum: Int) {
    return (val1, val2)
}

print(returnMulti(firstNumber: 4, secondNumber: 8).firstNum)
print(returnMulti(firstNumber: 4, secondNumber: 8).secondNum)

//Func are first-class type, meaning that they can return a func

func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)

var numbers = [0, 1, 4, 8 ,12, 14, 15, 16, 17]

numbers.map({ (number: Int) -> Int in
    let result = 3 * number
    return result
})

print(numbers.map({ number in 3 * number }))

//In classes, the initalizer (init) lets you use passed in parameters
//Use the initalizer for values that need defining from the start
//Other values can be assigned later -> square.sides = 4

//You can use deinit to do some cleanup when the object is deallocated
class shapes {
    var numberOfSides = 0
    var name: String
    
    init(sides: Int, type: String) {
        self.name = type
        self.numberOfSides = sides
    }
    
    func simpleDescription() {
        print("I am a \(name), I have \(numberOfSides) sides!")
    }
}

let square = shapes(sides: 4, type: "square")

square.simpleDescription()

//You can create a new class, from a parent class by nameing your class : superclass
//You can override func from the parent -> override func
//NOT over riding a func will result in an error, overriding an non-existant func also results in an error
class squareShape : shapes {
    
    init() {
        super.init(sides: 4, type: "Square")
    }
    
    override func simpleDescription() {
        print("I am a square, I have \(numberOfSides) sides!")
    }
}

let sqTest = squareShape()

sqTest.simpleDescription()

//Properties in a class can have getters and setters. A getter does something when the property is accessed
//A setter does something when the property is set

class triangle {
    var sideLength: Double
    var perimeter: Double {
        get {
            return sideLength * 3
        }
        set {
            sideLength = newValue / 3
        }
    }
    
    init(sideLength: Double) {
        self.sideLength = sideLength
    }
    
    func sentence() {
        print("The triangle has side lengths of \(sideLength) and a perimeter of \(perimeter)")
    }
}

//Getters and setters allow you to adjust other paremetes when one is set. Pretty useful
//set {} also has a value newValue, representing what the parameter is set to
//You can also use willSet and didGet to insert code to run anytime the parmeter is set or get

let trTest = triangle(sideLength: 3)

trTest.sentence()

trTest.perimeter = 30

trTest.sentence()

enum drinks: String {
    case water
    case beer, wine, liquor
    case soda
    
    func simpleDescription() -> String {
        switch self {
        case .water:
            return "Water"
        case .soda:
            return "Soda"
        default:
            return String(self.rawValue)
        }
    }
}

let myDrink = drinks.beer
print(myDrink.simpleDescription())

protocol exampleProto {
    var simpleVar: String { get }
    mutating func simpleDescription()
}

class testFunc: exampleProto {
    var simpleVar: String = "My simple variable"
    func simpleDescription() {
        print("A simple description")
    }
}
