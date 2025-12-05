//: [Previous](@previous)

import Foundation

/// Part 2
func day3Part2(input: [String] ) -> UInt64{
    var acc: UInt64 = 0
    for line in input {
        let ints = line.map { UInt64($0.wholeNumberValue!) }
        acc += joltage2(input: ints)
    }
    return acc
}


func joltage2(input: [UInt64]) -> UInt64 {
    var startIndex = input.startIndex
    var windowSize = input.count - 11
    var acc: String = ""
        
    while startIndex + windowSize <= input.count && acc.count < 12 {
        let window = input[startIndex..<startIndex + windowSize]
        let maxInWindow = window.max()!
        let maxPos = window.firstIndex(of: maxInWindow)!
        acc.append(String(maxInWindow))

        windowSize -= maxPos - startIndex
        startIndex +=  maxPos - startIndex + 1

    }
    print (acc)
    return UInt64(acc)!
}



/// Part 1
func joltage(input: [Int]) -> (Int, Int) {
    if input.count <= 2 {
        guard input.count == 2 else {
            return (input[0],-1)
        }
        return (input[0], input[1])
    } else {
        let midpoint = input.count / 2
        let left = input[..<midpoint]
        let right = input[midpoint...]
        
        let joltageLeft = joltage(input: Array(left))
        let joltageRight = joltage(input: Array(right))
        
        let order = [joltageLeft.0, joltageLeft.1, joltageRight.0, joltageRight.1]
        
        let maxL = order.prefix(3).max()!
        let maxLPos = order.firstIndex(of: maxL)!
        
        let maxR = order.suffix(from: maxLPos + 1).max()!
        
        return (maxL, maxR)
    }
}

func day3(input: [String] ) -> Int{
    var acc = 0
    for line in input {
        let ints = line.map { $0.wholeNumberValue! }
        let joltage = joltage(input: ints)
        acc += joltage.0*10 + joltage.1
    }
    return acc
}


day3Part2(input: Day3Input)
