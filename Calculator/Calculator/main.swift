//
//  main.swift
//  Calculator
//
//  Created by Alex Paul on 10/25/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation
//given functions
func mathStuffFactory(opString: String) -> (Double, Double) -> Double {
switch opString {
  case "+":
    return {x, y in x + y }
  case "-":
    return {x, y in x - y }
  case "*":
    return {x, y in x * y }
  case "/":
    return {x, y in x / y }
  default:
    return {x, y in x + y }
  }
}

func myFilter(inputArray: [Int], filter: (Int) -> Bool) -> [Int] {
    return [0] // remove
}

var calculate = true
var firstChoice = true
var optionOne = false
var optionTwo = false
var mathLoop = false
var solveLoop = false
var loopGuess = false
var symbols = "+-*/?"
var number1: Double = 0
var number2: Double = 0
var operation = ""
var saveTerm = ""
var saveArray = [0]
var saveByOp = ""
var saveNum = 0



func test(string: String) -> Bool {
    let arrayTest = string.components(separatedBy: " ")
    if arrayTest.count == 3 {
        if let num1 = Double(arrayTest[0]), let num2 = Double(arrayTest[2]) {
            let oper = arrayTest[1]
            if oper.count == 1 && symbols.contains(oper) {
                number1 = num1
                number2 = num2
                operation = oper
                return true
            }
        }
    }
    return false
}

//func filterTest(string: String) -> Bool {
//    let arrayFilterTest = string.components(separatedBy: " ")
//    if arrayFilterTest.count == 5 {
//        let term = arrayFilterTest[0]
//        let byOperation = arrayFilterTest[3]
//        if let num = Int(arrayFilterTest[4]), let arrayNums = Array<Int>(arrayFilterTest[1]) {
//            if byOperation.count == 1 && symbols.contains(byOperation) {
//                saveTerm = term
//                saveArray = arrayNums
//                saveByOp = byOperation
//                saveNum = num
//                return true
//            }
//        }
//
//
//    }
//    return false
//}

func tryAgain() {
    
    print("calculate something else? yes or no")
    if let anotherTry = readLine()?.lowercased() {
        switch anotherTry {
        case "yes":
            firstChoice = true
        case "no":
            calculate = false
        default:
            print("invalid response")
            tryAgain()
        }
    }
}
func checkDevZero(op: String, num: Double) -> Bool {
    if op == "/" && num == 0 {
        return true
    }
    return false
}

repeat {
    //check that number is in min/max range
    while firstChoice {
        print("Would you like to Option 1 or Option 2?")
        if let choice = readLine()?.lowercased() {
            switch choice {
            case "1":
                firstChoice = false
                optionOne = true
            case "2":
                firstChoice = false
                optionTwo = true
            default:
                print("Invalid choice")
            }
        }
    }
    
    while optionOne {
        print("write your equation. number (operation symbol) number")
        if let equation = readLine() {
            if test(string: equation) == true && operation != "?" {
                optionOne = false
                mathLoop = true
            } else if test(string: equation) == true && operation == "?" {
                optionOne = false
                solveLoop = true
            } else {
                print("that is not a valid equation")
            }
        }
    }
    while optionTwo {
        print("enter your operation. choose from filter, map, and reduce, list some numbers, ")
        optionTwo = false // so it doesn't crash
    }
    while mathLoop {
        let mathFunction = mathStuffFactory(opString: operation)
        if checkDevZero(op: operation, num: number2) {
            print("sorry you can't devide by 0")
            mathLoop = false
            optionOne = true
        } else {
            print("\(Int(number1)) \(operation) \(Int(number2)) = \(Int(mathFunction(number1, number2)))")
            mathLoop = false
            tryAgain()
        }
    }
    
    while solveLoop {
        if let char = symbols.randomElement() {
            operation = String(char)
        }
        if operation != "?" {
            if !checkDevZero(op: operation, num: number2) {
                solveLoop = false
                loopGuess = true
                let solveFunction = mathStuffFactory(opString: operation)
                print("\(Int(solveFunction(number1, number2)))")
                while loopGuess {
                    print("Guess the operator used?")
                    if let guess = readLine() {
                        if guess.count == 1 && symbols.contains(guess) && guess != "?" {
                            // do we need to account for multi possible operators 9*0 == 0/9
                            if operation == guess {
                                print("Correct")
                                loopGuess = false
                                tryAgain()
                            } else {
                                print("Incorrect, guess again.")
                            }
                        } else {
                            print("this is not a valid operator")
                        }
                    }
                }
            }
        }
    }
} while calculate
print("goodbye!")




