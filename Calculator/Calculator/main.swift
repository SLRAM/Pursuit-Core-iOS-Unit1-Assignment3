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
var arrayFail = 0


func minMax(num1: String, num2: String) -> Bool {
    
    if let _ = Int(num1), let _ = Int(num2) {
        return true
    }
    return false
}

func test(string: String) -> Bool {
    let arrayTest = string.components(separatedBy: " ")
    if arrayTest.count == 3 && minMax(num1: arrayTest[0], num2: arrayTest[2]){
        //before I convert the string to a Double check if == to min.max string
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


func intDouble(num1: Double, num2: Double) -> Bool{
    //if value doesn't have numbers after decimal point
    let intDoub = num1.truncatingRemainder(dividingBy: 1) == 0
    let intDoub2 = num2.truncatingRemainder(dividingBy: 1) == 0
    
    if intDoub && intDoub2 {
        return true
    }
    return false
}

func intArray(string: String) -> [Int]? {
    //still accepts letters in array
    let convert = string.components(separatedBy: ",")
    var arrayOfInts = [Int]()
    for index in 0..<convert.count {
        if let int = Int(convert[index]) {
            arrayOfInts.append(int)
        } else {
            return nil
        }
    }
    return arrayOfInts
}
func testTwo(string: String) -> Bool {
    let arrayTest2 = string.components(separatedBy: " ")
    if arrayTest2.count == 5 && arrayTest2[2] == "by" {
        let term = arrayTest2[0]
        let byOperation = arrayTest2[3]
        switch term {
        case "filter":
            if byOperation == ">" || byOperation == "<" || byOperation == "=" {
                if let num = Int(arrayTest2[4]), let arrayNums = intArray(string: arrayTest2[1]) {
                    saveTerm = term
                    saveArray = arrayNums
                    saveByOp = byOperation
                    saveNum = num
                    return true
                } else {
                    print("Invalid response")
                    return false
                }
            }else {
                print("Invalid response")
                return false
            }
        case "map":
            if byOperation == "*" || byOperation == "/" {
                if let num = Int(arrayTest2[4]), let arrayNums = intArray(string: arrayTest2[1]) {
                    saveTerm = term
                    saveArray = arrayNums
                    saveByOp = byOperation
                    saveNum = num
                    return true
                } else {
                    print("Invalid response")
                    return false
                }
            }else {
                print("Invalid response")
                return false
            }
        case "reduce":
            if byOperation == "+" || byOperation == "*" {
                if let num = Int(arrayTest2[4]), let arrayNums = intArray(string: arrayTest2[1]) {
                    saveTerm = term
                    saveArray = arrayNums
                    saveByOp = byOperation
                    saveNum = num
                    return true
                } else {
                    print("Invalid response")
                    return false
                }
            }else {
                print("Invalid response")
                return false
            }
        default:
            print("Invalid response")
            return false
        }
    }
    print("Invalid response")
    return false
}

func myReduce(arrOfNum: [Int], byNumber: Int, byOperator: String) -> Int{
    var tempResult = byNumber
    switch byOperator {
    case "+":
        for num in arrOfNum{
            tempResult += num
        }
        return tempResult
    case "*":
        for num in arrOfNum{
            tempResult *= num
        }
        return tempResult
    default:
        print("You should never see this!")
    }
    return -1
}

func myFilter() {
    
}
func myMap() {
    
}
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
    //check that number is in min/max range and result does not go over
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
        if let equationTwo = readLine()?.lowercased() {
            if testTwo(string: equationTwo) {
                switch saveTerm {
                case "filter":
                    optionTwo = false
                    print("you chose filter")
                    print("The results are: \(myFilter())")
                case "map":
                    optionTwo = false
                    print("you chose map")
                    print("The results are: \(myMap())")
                case "reduce":
                    optionTwo = false
                    print("you chose reduce")
                    print("the results are: \(myReduce(arrOfNum: saveArray, byNumber: saveNum, byOperator: saveByOp))")
                    tryAgain()
                default:
                    print("YOU SHOULD NEVER SEE THIS!")
                }
            }
        }
    }
    
    
    while mathLoop {
        let mathFunction = mathStuffFactory(opString: operation)
        if checkDevZero(op: operation, num: number2) {
            print("sorry you can't divide by 0")
            mathLoop = false
            optionOne = true
        } else {
            if intDouble(num1: number1, num2: number2) {
                print("\(Int(number1)) \(operation) \(Int(number2)) = \(Int(mathFunction(number1, number2)))")
            } else {
                print("\(number1) \(operation) \(number2) = \(mathFunction(number1, number2))")
            }
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
                if intDouble(num1: number1, num2: number2) {
                    print("\(Int(solveFunction(number1, number2)))")
                } else {
                    print("\(solveFunction(number1, number2))")
                }
                while loopGuess {
                    print("Guess the operator used?")
                    if let guess = readLine() {
                        if guess.count == 1 && symbols.contains(guess) && guess != "?" {
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




