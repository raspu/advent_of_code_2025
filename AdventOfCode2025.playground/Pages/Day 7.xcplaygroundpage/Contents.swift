//: [Previous](@previous)
struct Pos: Hashable {
    let x: Int
    let y: Int
}

func day7Part2(input: [String]) -> Int {
    var inputArr: [[Character]] = input.map { $0.map{ $0 } }
    var cache: [Pos: Int] = [:]
    
    let startX = inputArr[0].firstIndex(of: "S") ?? 0
    
    return traceBeam(map: inputArr, pos: (startX, 1), cache: &cache)
}


func traceBeam(map: [[Character]], pos: (Int, Int), cache: inout [Pos: Int]) -> Int {
    
    if pos.1 == map.count - 1 {
        return 1
    }
    
    if pos.0 < 0 || pos.0 >= map[pos.1].count || pos.1 < 0 {
        return 0
    }
    
    if let cachedResult = cache[Pos(x: pos.0, y:pos.1)] {
        return cachedResult
    }
    
    var result: Int = 0
    let char = map[pos.1][pos.0]
    
    if char == "." {
        result += traceBeam(map: map, pos: (pos.0, pos.1 + 1), cache: &cache)
    } else if char == "^" {
        result += traceBeam(map: map, pos: (pos.0 - 1, pos.1 + 1), cache: &cache)
        result += traceBeam(map: map, pos: (pos.0 + 1, pos.1 + 1), cache: &cache)
    }
    
    cache[Pos(x: pos.0, y:pos.1)] = result
    return result
}

day7Part2(input: Day7Input)

func day7Part1(input: [String]) -> Int {
    var inputArr: [[Character]] = input.map { $0.map{ $0 } }
    var result: Int = 0
    
    for i in 1..<inputArr.count {
        var line = inputArr[i]
        
        for charIndex in 0..<line.count {
            let char = line[charIndex]
                    
            if char == "." {
                let upChar = inputArr[i-1][charIndex]
                if  upChar == "|" || upChar == "S" {
                    line[charIndex] = "|"
                }
            } else if char == "^" {
                let upChar = inputArr[i-1][charIndex]
                if upChar == "|" {
                    result += 1
                    line[charIndex] = "."
                    if charIndex > 0 {
                        line[charIndex-1] = "|"
                    }
                    if charIndex < line.count - 1 {
                        line[charIndex+1] = "|"
                    }
                }
            }
        }
        
        inputArr[i] = line
    }
    
    return result
}

//day7Part1(input: Day7Input)
