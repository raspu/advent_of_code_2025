//: [Previous](@previous)

import Foundation
import CoreGraphics

struct PointPair: Hashable {
    let a: Point
    let b: Point
    let distance: Double
    
    init(a: Point, b: Point) {
        self.a = a
        self.b = b
        self.distance = calculateDistance(a, b)
    }
    
    static func ==(lhs: PointPair, rhs: PointPair) -> Bool {
        return lhs.a == rhs.a && lhs.b == rhs.b || lhs.a == rhs.b && lhs.b == rhs.a
    }
}

struct Circuit: Hashable {
    var points: Set<Point>
    var distance: Double
}

func calculateDistance(_ a: Point, _ b: Point) -> Double {
    return sqrt(pow((a.x - b.x), 2) + pow((a.y - b.y),2) + pow((a.z - b.z),2))
}

/// Brute force approach
func day8Part1(input: [Point], connections: Int) -> UInt64 {
    var distances: [PointPair] = []
    var circuits: [Circuit] = []
    
    print ("Distances")
    for pA in 0..<input.count {
        for pB in pA+1..<input.count {
            distances.append(PointPair(a: input[pA], b: input[pB]))
        }
    }
    
    print ("Sorting")

    distances.sort { $0.distance < $1.distance }
    
    print ("Circuits")
    for i in 0..<connections {
        let pair = distances[i]
        
        let circuitA = circuits.firstIndex { $0.points.contains(pair.a) }
        let circuitB = circuits.firstIndex { $0.points.contains(pair.b) }
        
        switch (circuitA, circuitB) {
            case (.some(let a), .some(let b)):
            if a == b { continue }
            circuits[a].points.formUnion(circuits[b].points)
            circuits[a].points.insert(pair.a)
            circuits[a].points.insert(pair.b)
            circuits[a].distance += pair.distance + circuits[b].distance
            circuits.remove(at: b)

            
        case (.some(let a), .none):
            circuits[a].points.insert(pair.a)
            circuits[a].points.insert(pair.b)
            circuits[a].distance += pair.distance
        
        case (.none, .some(let b)):
            circuits[b].points.insert(pair.a)
            circuits[b].points.insert(pair.b)
            circuits[b].distance += pair.distance
            
        case (.none, .none):
            circuits.append(Circuit(points: [pair.a, pair.b], distance: pair.distance))
        }

    }
    
    circuits.sort { $0.points.count > $1.points.count }
    print (circuits.map(\.points.count))
    var result: UInt64 = 1
    
    for i in 0..<3 {
        result *= UInt64(circuits[i].points.count)
    }
    
    return result
}




func day8Part2(input: [Point]) -> CGFloat {
    var distances: [PointPair] = []
    var circuits: [Circuit] = []
    
    print ("Distances")
    for pA in 0..<input.count {
        for pB in pA+1..<input.count {
            distances.append(PointPair(a: input[pA], b: input[pB]))
        }
    }
    
    print ("Sorting")

    distances.sort { $0.distance < $1.distance }
    
    print ("Circuits")
    var connected: Set<Point> = []
    var distanceIndex = 0
    while connected.count < input.count || circuits.count != 1 {
        let pair = distances[distanceIndex]
        
        connected.insert(pair.a)
        connected.insert(pair.b)
        distanceIndex += 1
        
        let circuitA = circuits.firstIndex { $0.points.contains(pair.a) }
        let circuitB = circuits.firstIndex { $0.points.contains(pair.b) }
        
        switch (circuitA, circuitB) {
            case (.some(let a), .some(let b)):
                if a == b { continue }
                circuits[a].points.formUnion(circuits[b].points)
                circuits[a].points.insert(pair.a)
                circuits[a].points.insert(pair.b)
                circuits[a].distance += pair.distance + circuits[b].distance
                circuits.remove(at: b)

                
            case (.some(let a), .none):
                circuits[a].points.insert(pair.a)
                circuits[a].points.insert(pair.b)
                circuits[a].distance += pair.distance
            
            case (.none, .some(let b)):
                circuits[b].points.insert(pair.a)
                circuits[b].points.insert(pair.b)
                circuits[b].distance += pair.distance
                
            case (.none, .none):
                circuits.append(Circuit(points: [pair.a, pair.b], distance: pair.distance))
        }
        
        print(connected.count, input.count, circuits.count)
    }
    
    let lastPair = distances[distanceIndex-1]
    return lastPair.a.x * lastPair.b.x

}

//day8Part2(input: Day8Input)
