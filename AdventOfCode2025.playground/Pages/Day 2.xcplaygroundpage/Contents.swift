import Foundation
/// Part 2
func day2Part2(input: String) -> UInt64{
    var accumulator: UInt64 = 0
    
    let ranges = input.split(separator: ",").map{ next in
        let pair = next.split(separator: "-")
        return UInt64(pair[0])!...UInt64(pair[1])!
    }
    
    for range in ranges{
        let invalidIds = generateInvalidIds(range)
        accumulator += invalidIds.reduce(0, +)
    }
    
    return accumulator
}

func generateInvalidIds(_ range: ClosedRange<UInt64>) -> [UInt64]{
    let firstNumber = String(range.lowerBound)
    let lastNumber = String(range.upperBound)
    var invalidIds = Set<UInt64>()
    
    for number in firstNumber.count...lastNumber.count
    {
        var currentSeed = 1
        var currentSeedString = String(currentSeed)
        
        while currentSeedString.count <= (number/2) {
            if number % currentSeedString.count == 0 {
                let id = UInt64(String(repeating: currentSeedString, count: number / currentSeedString.count))!
                if range.contains(id) {
                    invalidIds.insert(id)
                }
            }
            currentSeed += 1
            currentSeedString = String(currentSeed)
        }
    }
    
    return [UInt64](invalidIds)
}


day2Part2(input: Day2Input)



/// Part 1
func day2Naive(input: String) -> UInt64{
    var accumulator: UInt64 = 0
    
    let ranges = input.split(separator: ",").map{ next in
        let pair = next.split(separator: "-")
        return UInt64(pair[0])!...UInt64(pair[1])!
    }
    
    for range in ranges{
       for number in range where test(number: number) != nil{
           accumulator += number
       }
    }
    
    return accumulator
}


func test(number: UInt64) -> UInt64?{
    let stringNumber = String(number)
    if stringNumber.count % 2 == 0{
        let half = stringNumber.count / 2
        let firstHalf = stringNumber.prefix(half)
        let secondHalf = stringNumber.suffix(half)
        if firstHalf == secondHalf{
            return number
        }
    }
    return nil
}


