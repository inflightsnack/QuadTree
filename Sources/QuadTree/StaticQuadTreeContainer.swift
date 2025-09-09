//
//  StaticQuadTreeContainer.swift
//  QuadTree
//
//  Created by Martin Bell on 08/09/2025.
//

import Foundation
import CoreGraphics


public struct StaticQuadTreeContainer<T>: RandomAccessCollection {
    public typealias Index = Array<T>.Index
    public typealias Element = T
    public var startIndex: Index { allItems.startIndex }
    public var endIndex: Index { allItems.endIndex }
    public subscript(position: Index) -> Element {
        return allItems[position]
    }
    
    var allItems: [Element] = []
    var root: StaticQuadTree< Array<Element>.Index >
    public var area : CGRect {
        return root.area
    }

    public init(area: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100)) {
        root = StaticQuadTree(area: area, depth: 0)
    }
    
    public mutating func removeAll() {
        allItems.removeAll()
        root.removeAll()
    }
    
    public var count: Int {
        return allItems.count
    }
    
    public var isEmpty: Bool {
        return allItems.isEmpty
    }
    
    public mutating func insert(_ newElement: Element, at elementArea: CGRect) {
        allItems.append(newElement)
        root.insert(allItems.endIndex.advanced(by: -1), at: elementArea)
    }
    
    public func search(in searchArea: CGRect) -> [Index] {
        return root.search(in: searchArea)
    }
}

