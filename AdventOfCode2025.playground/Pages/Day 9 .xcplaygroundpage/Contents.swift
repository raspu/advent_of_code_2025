//: [Previous](@previous)

import Foundation
import CoreGraphics

func calculateArea(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
    return (abs(a.x - b.x)+1) * (abs(a.y - b.y)+1)
}


func day9Part1(input: [CGPoint]) -> CGFloat {
    var maxArea: CGFloat = 0
    
    for i in 0..<input.count {
        for j in i+1..<input.count {
            let area = calculateArea(input[i], input[j])
            maxArea = max(maxArea, area)
        }
    }
        
    return maxArea
}


day9Part1(input: Day9Input)
