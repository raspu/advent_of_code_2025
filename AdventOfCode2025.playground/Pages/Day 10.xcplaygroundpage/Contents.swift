//: [Previous](@previous)

import Foundation

func day10Part1(input: [String]) -> Int {
    let inputParts = input.map { $0.split(separator: " ") }
    var result = 0
    
    for input in inputParts {
        let target = Array(input[0].trimmingCharacters(in: CharacterSet(charactersIn: "[]")))
        var buttonSets: [[Int]] = []
        for i in 1..<input.count-1 {
            let buttonSet = input[i].trimmingCharacters(in: CharacterSet(charactersIn: "()")).split(separator: ",").map { Int($0)! }
            buttonSets.append(buttonSet)
        }
        
        var lightsPath: Set<String> = []
        var cache: [String: Int] = [:]
        var start: [Character] = Array(repeating: ".", count: target.count)
        let moves = minMoves(lights: start, target: target, buttons: buttonSets, lightsPath: lightsPath, cache: &cache)
        print (moves)
        result += moves
    }
    
    return result
}

func applyButton(lights: [Character], button: [Int]) -> [Character] {
    var lights = lights
    for lightIndex in button {
        lights[lightIndex] = lights[lightIndex] == "." ? "#" : "."
    }

    return lights
}

func minMoves(lights: [Character], target: [Character], buttons: [[Int]], lightsPath: Set<String>, cache: inout [String: Int] ) -> Int {

    guard lights != target else { print("Solution!"); return 0 }
    guard !lightsPath.contains(String(lights)) else { return Int.max - 1 }
    
    if let cachedResult = cache[String(lights)] {
        return cachedResult
    }
    
    var minResult = Int.max - 1
    for button in buttons {
        var lightsPath = lightsPath
        lightsPath.insert(String(lights))

        let nextLights = applyButton(lights: lights, button: button)

        let next = minMoves(lights: nextLights, target: target, buttons: buttons, lightsPath: lightsPath, cache: &cache)
        
        minResult = min(minResult, next + 1)
    }
    
    cache[String(lights)] = minResult
    return minResult
}


day10Part1(input: Day10Input)
