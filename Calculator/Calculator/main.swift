//
//  main.swift
//  Calculator
//
//  Created by Alex Paul on 10/25/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

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
var saveEquation = ""

func checkStringTrue(string: String) -> Bool {
    let arrayTest = string.components(separatedBy: " ")
    if arrayTest.count == 3 {
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

func checkStringTrue2(string: String) -> Bool {
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
            if byOperation == "*" || byOperation == "/" || byOperation == "+" || byOperation == "-" {
                if let num = Int(arrayTest2[4]), let arrayNums = intArray(string: arrayTest2[1]) {
                    if !ifDivideByZero(op: byOperation, num: Double(num)) {
                        saveTerm = term
                        saveArray = arrayNums
                        saveByOp = byOperation
                        saveNum = num
                        return true
                    } else {
                        return false
                    }
                } else {
                    print("Invalid response")
                    return false
                }
            }else {
                print("Invalid response")
                return false
            }
        case "reduce":
            if byOperation == "+" || byOperation == "-" || byOperation == "*" || byOperation == "/"{
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
func ifDivideByZero(op: String, num: Double) -> Bool {
    if op == "/" && num == 0 {
        print("Sorry you can't divide by 0")
        return true
    }
    return false
}

func intArray(string: String) -> [Int]? {
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

func intDouble(num1: Double, num2: Double) -> Bool{
    //if value doesn't have numbers after decimal point
    let intDoub = num1.truncatingRemainder(dividingBy: 1) == 0
    let intDoub2 = num2.truncatingRemainder(dividingBy: 1) == 0
    
    if intDoub && intDoub2 {
        return true
    }
    return false
}

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

func minMaxOverflow(string: String) -> Bool {
    let arrayTest = string.components(separatedBy: " ")
    if let _ = Int(arrayTest[0]), let _ = Int(arrayTest[2]) {
        return true
    }
    return false
}

func myMap(array: [Int], closure: (Int) -> Int) ->[Int] {
    var newArray = [Int]()
    for num in array {
        newArray.append(closure(num))
    }
    return newArray
}

func myFilter(inputArray: [Int], filter: (Int) -> Bool) -> [Int] {
    var newArray = [Int]()
    for num in inputArray {
        if filter(num) {
            newArray.append(num)
        }
    }
    return newArray
}

func myReduce(array: [Int], closure: (Int) -> Int) -> Int {
    var sum = 0
    for num in array {
        sum += closure(num)
    }
    switch saveByOp {
    case "+":
        return saveNum + sum
    case "-":
        return saveNum - sum
    case "*":
        return saveNum * sum
    case "/":
        guard !ifDivideByZero(op: saveByOp, num: Double(sum)) else {
            print("the sum of your array is zero")
            return saveNum
        }
        return saveNum / sum
    default:
        return -1
    }
}

func tryAgain() {
    
    print("Would you like to calculate something else? yes or no")
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


print("Hello! Welcome to my project!")

repeat {
    while firstChoice {
        print("Please choose from 1: normal calculator/guessing game or 2: higher order functions?")
        if let choice = readLine()?.lowercased() {
            switch choice {
            case "1":
                print("You chose normal calculator/ guessing game!")
                firstChoice = false
                optionOne = true
            case "2":
                print("You chose higher order functions!")
                firstChoice = false
                optionTwo = true
            default:
                print("Invalid choice")
            }
        }
    }
    
    while optionOne {
        print("Please write your equation or let's guess the missing operator.")
        print("Here are some examples:")
        print("For calculator: \" 2.8 + 6\", For guessing game: \"8 ? 4\"")
        if let equation = readLine() {
            saveEquation = equation
            if checkStringTrue(string: equation) == true && operation != "?" {
                optionOne = false
                mathLoop = true
            } else if checkStringTrue(string: equation) == true && operation == "?" {
                optionOne = false
                solveLoop = true
            } else {
                print("that is not a valid equation")
            }
        }
    }
    
    while optionTwo {
        print("Enter your function, your set of numbers, your operator and the final number.")
        print("Here's an example: \"reduce 1,2,3,4 by / 5\"")
        if let equationTwo = readLine()?.lowercased() {
            if checkStringTrue2(string: equationTwo) {
                switch saveTerm {
                case "filter":
                    optionTwo = false
                    print("you chose filter")
                    print(myFilter(inputArray: saveArray) {(num: Int) -> Bool in
                        switch saveByOp {
                        case ">":
                            if num > saveNum {
                                return true
                            } else {
                                return false
                            }
                        case "<":
                            if num < saveNum {
                                return true
                            } else {
                                return false
                            }
                        case "=":
                            if num == saveNum {
                                return true
                            } else {
                                return false
                            }
                        default:
                            print("error")
                        }
                        return false
                    })
                    tryAgain()
                case "map":
                    optionTwo = false
                    print("you chose map")
                    print(myMap(array: saveArray) {(num: Int) -> Int in
                        switch saveByOp {
                        case "+":
                            return num + saveNum
                        case "-":
                            return num - saveNum
                        case "/":
                            return num / saveNum
                        case "*":
                            return num * saveNum
                        default:
                            print("error")
                        }
                        return -1
                    })
                    tryAgain()
                case "reduce":
                    optionTwo = false
                    print("you chose reduce")
                    print(myReduce(array: saveArray, closure: {$0}))
                    tryAgain()
                default:
                    print("YOU SHOULD NEVER SEE THIS!")
                }
            }
        }
    }
    while mathLoop {
        let mathFunction = mathStuffFactory(opString: operation)
        if ifDivideByZero(op: operation, num: number2) {
            mathLoop = false
            optionOne = true
        } else {
            if intDouble(num1: number1, num2: number2) {
                if minMaxOverflow(string: saveEquation) {
                    print("\(Int(number1)) \(operation) \(Int(number2)) = \(Int(mathFunction(number1, number2)))")
                } else {
                    print("That is not a valid equation")
                }
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
            if !ifDivideByZero(op: operation, num: number2) {
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




