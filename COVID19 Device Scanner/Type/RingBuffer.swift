//
//  RingBuffer.swift
//  COVID19 Device Scanner
//
//  Created by Takahiko Inayama on 2020/07/02.
//  Copyright © 2020 TETRA2000. All rights reserved.
//

import Foundation

public struct RingBuffer<T> {
    private var array: [T?]
    private var currentIndex = 0
    init(capacity: Int) {
        array = Array<T?>(repeating: nil, count: capacity)
    }
    
    public mutating func append(elm: T) {
        array[currentIndex] = elm
        incrementIndex()
    }
    
    public func toArray() -> Array<T> {
        let sorted = array[currentIndex...] + array[..<currentIndex]
        return Array(sorted.compactMap({$0}))
    }
    
    private mutating func incrementIndex() {
        if currentIndex == array.count - 1 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
    }
    
    
}
