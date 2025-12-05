//: [Previous](@previous)

import Foundation

func day5Part2(rangeStrings: [String]) -> UInt64 {
    let ranges = rangeStrings.map {
        let pair = $0.split(separator: "-")
        return UInt64(pair[0])!...UInt64(pair[1])!
    }.sorted { $0.lowerBound < $1.lowerBound }
        
    var mergedRanges = [ClosedRange<UInt64>]()
    var currentRange: ClosedRange<UInt64>? = ranges.first
    
    for range in ranges {
        if range.lowerBound <= currentRange!.upperBound {
            currentRange = currentRange!.lowerBound...max(currentRange!.upperBound, range.upperBound)
        } else {
            mergedRanges.append(currentRange!)
            currentRange = range
        }
    }
    mergedRanges.append(currentRange!)
    
    return mergedRanges.reduce(0) { $0 + ($1.upperBound - $1.lowerBound + 1) }
}


func day5Part1(rangeStrings: [String], input: [UInt64]) -> Int {
    let ranges = rangeStrings.map {
        let pair = $0.split(separator: "-")
        return UInt64(pair[0])!...UInt64(pair[1])!
    }
    
    var freshIDs = 0
    
    for number in input {
        if (ranges.firstIndex(where: { $0.contains(number) }) != nil) {
            freshIDs += 1
        }
    }
    
    return freshIDs
}


day5Part2(rangeStrings: Day5InputRanges)
