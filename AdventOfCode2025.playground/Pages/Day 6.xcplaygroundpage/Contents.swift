//: [Previous](@previous)

import Foundation

func removeExtraSpaces(input: String) -> String {
    return input.replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
}


/// Super crappy solution, don't look at it :( 
func day6Part2(input: [String]) -> UInt64 {
    var items = [[String]]()
    var operators: [String] = []
    
    operators = input.last!.split(separator: /\s(?=([*+]))/,
                                  omittingEmptySubsequences: false).map { String($0) }

    for string in input {
        guard string != input.last! else { continue }
        
        var currentIndex = string.startIndex
        var row: [String] = []
        
        for oper in operators {
            let colLen = oper.count
            let lastIndex = string.index(currentIndex, offsetBy: colLen, limitedBy: string.endIndex) ?? string.endIndex
            row.append(String(string[currentIndex..<lastIndex]))
            currentIndex = string.index(lastIndex, offsetBy: 1, limitedBy: string.endIndex) ?? string.endIndex
        }
        
        items.append(row)
    }
        
    var result: UInt64 = 0
    for i in 0..<operators.count {
        var numbers = [UInt64]()
        var index = 0
        while index >= 0 {
            var number = ""
            for item in items {
                if index < item[i].count {
                    let string = item[i]
                    let position = string.index(string.startIndex, offsetBy: index)
                    if !string[position].isWhitespace {
                        number.append(string[position])
                    }
                }
            }
            if number.isEmpty {
                index = -1
            } else {
                guard let number = UInt64(number) else { index += 1; continue }
                numbers.append(number)
                index += 1
            }
        }
        
        operators = operators.map { $0.trimmingCharacters(in: .whitespaces) }
        
        var accumulator: UInt64 = operators[i] == "*" ? 1 : 0
        for number in numbers {
            switch operators[i] {
                case "*":
                    accumulator *= number
                case "+":
                    accumulator += number
                default:
                    continue
            }
        }
        
        print (numbers, operators, accumulator)
        result += accumulator
    }
    
    
    return result
}

day6Part2(input: Day6Input)

func day6Part1(input: [String]) -> UInt64 {
    var items = [[UInt64]]()
    var operators: [String] = []
    for string in input {
        if input.last != string {
            let elements = removeExtraSpaces(input: string).split(separator: " ").map { UInt64($0)! }
            items.append(elements)
        } else {
            operators = removeExtraSpaces(input: string).split(separator: " ").map { String($0) }
        }
    }
    
    var result: UInt64 = 0
    
    for i in 0..<operators.count {
        var accumulator: UInt64 = operators[i] == "*" ? 1 : 0
        for item in items {
            switch operators[i] {
                case "*":
                    accumulator *= item[i]
                case "+":
                    accumulator += item[i]
                default:
                    continue
            }
        }
        
        result += accumulator
    }
    
    return result
}



