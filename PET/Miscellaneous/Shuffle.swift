//
//  Shuffle.swift
//  Template
//
//  Created by liuyal on 11/14/17.
//  Copyright © 2017 J.L. All rights reserved.
//

import Foundation

/* Returns a random integer between 0 and n-1. */
public func random(_ n: Int) -> Int {
    return Int(arc4random_uniform(UInt32(n)))
}

extension Array {
    public mutating func shuffle() {
        for i in (1...count-1).reversed() {
            let j = random(i + 1)
            if i != j {
                let t = self[i]
                self[i] = self[j]
                self[j] = t
            }
        }
    }
}

// Simultaneously initializes an array with the values 0...n-1 and shuffles it.
public func shuffledArray(_ n: Int) -> [Int] {
    var a = Array(repeating: 0, count: n)
    for i in 0..<n {
        let j = random(i + 1)
        if i != j {
            a[i] = a[j]
        }
        // insert next number from the sequence
        a[j] = i  
    }
    return a
}

