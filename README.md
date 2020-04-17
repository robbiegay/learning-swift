# Learning Swift

This repo contains several projects that I have built as part of my process to learn and better understand Swift, Xcode, and mobile app development.

Two app that I have completed as part of this process are a calculator app, and a close of the Instagram app.

You can watch a video demo of the Calculator app here: [Calculator – YouTube](https://www.youtube.com/watch?v=koZmsJvPW5k)<br/>
You can watch a video demo of the Instagram clone here: [Instagram Clone – YouTube](https://www.youtube.com/watch?v=BcsI42rxDQs)

## Calculator

Testing the various combinations of keyboard inputs was the hardest aspect of this project. I tested the following 
combination of keys:

#### Key:
* [] --> number
* \+ --> represents any operand
* = --> equals key

#### Testing Cases:
* [] + [] = --> Basic math function
* [] + [] + []... = --> Should allow a string of inputs and operands
* [] + [] =, [] + [] = --> Should reset after an equal sign directly followed by a number
* [] + [] =, + [] = --> An equal sign followed by an operand should add, multiply, etc a new number to the previous sum
* [] + = = =... --> Should keep adding the first number to the running sum
* [] + [] = = =... --> Should continue to add to the running sum

#### Things that shouldn't be allowed:
* Leading zeros (ex. 00003)
* Multiple decimal points (ex. 4.423.34)
* Pressing an operand BEFORE a number (ex. * 34 - 12 --> * 34 will reset to zero)
* Pressing multiple operands in a row (ex. 4 + - / 2 --> will ignore + - and calculate 4 / 2)
* Pressing an unlimited amount of numbers --> I capped input at 10 digits

#### Certain situation resulted in NaN:
* 0 / 0 --> This now returns "Undefined". From my research, this is the correct mathematical result of 0 / 0
* . + . --> Trying to perform a calculation on a decimal point will return "Invalid Use of Decimal"
* num / 0 --> Returns Infinity

Both 0 / 0 and . + . resets the calculator's internal memory.

#### Calculator Easter Egg

Since most phone already have a fully featured calculator app, I wanted to add a small "easter egg" to make mine unique! When you type in my birthday: 32193 (March 21st, 1993), a purple button appears. This purple button toggles "party mode" on and off. Party mode causes the display to flash through a rainbow of colors. You can continue to use the calculator in party mode. To turn it off again, type in 32193 and toggle party mode off.


## Built With

* [Swift](https://swift.org/) - Programing Language used
* [Firebase](https://firebase.google.com/) - User Authentication and Backend Data

## Contributing

If you've found a bug in my code, please feel free to send me an Issue!

## Authors

* **Robbie Gay** - [Robbie's Website](https://www.robbiegay.art/)

## Acknowledgments

* I have been watching several of Brian Voong's "Let's Build That App" tutorials: [Let's Build That App](https://www.letsbuildthatapp.com/)
* [Tommy Warner](https://github.com/trwarner44) has really helped mentor me in the field of iOS development.
