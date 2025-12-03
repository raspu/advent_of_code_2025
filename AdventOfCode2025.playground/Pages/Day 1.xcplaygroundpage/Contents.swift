

import Foundation

func day1(turns: [String]) -> Int{
    var current = 50
    var num0s = 0
    
    for turn in turns {
        guard let amount = Int(turn.dropFirst()) else { continue }
                
        if turn[turn.startIndex] == "R" {
            if current + amount >= 100 {
                num0s += Int((current + amount)/100)
            }
            current += amount % 100
        } else if turn[turn.startIndex] == "L" {
            if current - amount <= 0 {
                num0s += abs(Int((current - amount)/100)) + min(current,1)
            }
            
            current -= amount % 100
            if current < 0 {
                current = abs(100 + current)
            }
        }
        
        current = current % 100
        
        print(current)
        
    }
    
    return num0s
}

day1(turns: Day1Input)
   
// 0 1 2 3 4 5 6 7 8 9

