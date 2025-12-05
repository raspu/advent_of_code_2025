//: [Previous](@previous)

import Foundation

/// Part 1
func day4(input: [[Character]]) -> Int {
    var movPositions = 0
    
    for i in 0..<input.count {
        for j in 0..<input[i].count {
            if input[i][j] == "." { continue }
            
            var rollsAround = 0
            
            rollsAround += input[safe: i - 1]?[safe: j - 1] ?? "." == "@" ? 1 : 0
            rollsAround += input[safe: i - 1]?[safe: j] ?? "." == "@" ? 1 : 0
            rollsAround += input[safe: i - 1]?[safe: j + 1] ?? "." == "@" ? 1 : 0
            
            rollsAround += input[safe: i]?[safe: j - 1] ?? "." == "@" ? 1 : 0
            rollsAround += input[safe: i]?[safe: j + 1] ?? "." == "@" ? 1 : 0
            
            rollsAround += input[safe: i + 1]?[safe: j - 1] ?? "." == "@" ? 1 : 0
            rollsAround += input[safe: i + 1]?[safe: j] ?? "." == "@" ? 1 : 0
            rollsAround += input[safe: i + 1]?[safe: j + 1] ?? "." == "@" ? 1 : 0
            movPositions += rollsAround < 4 ? 1 : 0
        }
    }
    
    return movPositions
}

/// Part 2
/// In order to run this, please move it to Day4Input.swift, if not it will go crazy trying to log all the Results.
public func day4Part2(input: [[Character]]) -> Int {
    var removedPositions = 0
    var removedTotal = 0
    var input = input
    
    repeat {
        removedPositions = 0
        for i in 0..<input.count {
            for j in 0..<input[i].count {
                if input[i][j] == "." { continue }
                
                var rollsAround = 0
                
                rollsAround += input[safe: i - 1]?[safe: j - 1] ?? "." == "@" ? 1 : 0
                rollsAround += input[safe: i - 1]?[safe: j] ?? "." == "@" ? 1 : 0
                rollsAround += input[safe: i - 1]?[safe: j + 1] ?? "." == "@" ? 1 : 0
                
                rollsAround += input[safe: i]?[safe: j - 1] ?? "." == "@" ? 1 : 0
                rollsAround += input[safe: i]?[safe: j + 1] ?? "." == "@" ? 1 : 0
                
                rollsAround += input[safe: i + 1]?[safe: j - 1] ?? "." == "@" ? 1 : 0
                rollsAround += input[safe: i + 1]?[safe: j] ?? "." == "@" ? 1 : 0
                rollsAround += input[safe: i + 1]?[safe: j + 1] ?? "." == "@" ? 1 : 0
                
                if rollsAround < 4 {
                    removedPositions += 1
                    removedTotal += 1
                    input[i][j] = "."
                }
            }
        }
    } while (removedPositions > 0)
    
    return removedTotal
}


//day4Part2(input: Day4Input)
