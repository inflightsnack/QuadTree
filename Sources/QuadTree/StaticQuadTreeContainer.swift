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
    public var startIndex: Index { items.startIndex }
    public var endIndex: Index { items.endIndex }
    public subscript(position: Index) -> Element {
        return items[position]
    }
    
    var items: [Element] = []
    var tree: StaticQuadTree< Array<Element>.Index >
    public var area : CGRect {
        return tree.area
    }

    public init(area: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100)) {
        tree = StaticQuadTree(area: area, depth: 0)
    }
    
    public mutating func removeAll() {
        items.removeAll()
        tree.removeAll()
    }
    
    public var count: Int {
        return items.count
    }
    
    public var isEmpty: Bool {
        return items.isEmpty
    }
    
    public mutating func insert(_ newElement: Element, at elementArea: CGRect) {
        items.append(newElement)
        tree.insert(items.endIndex.advanced(by: -1), at: elementArea)
    }
    
    public func search(in searchArea: CGRect) -> [Index] {
        return tree.query(in: searchArea)
    }
    
    public func allAreas() -> [CGRect] {
        return tree.allAreas()
    }
}

