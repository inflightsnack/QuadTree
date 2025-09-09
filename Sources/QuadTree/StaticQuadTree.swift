//
//  StaticQuadTree.swift
//  QuadTree
//
//  Created by Martin Bell on 07/09/2025.
//

import Foundation
import CoreGraphics

public struct StaticQuadTree<T> {
    
    let depth: Int
    
    // the area does not include the upper bound
    public let area: CGRect
    let childAreas: [CGRect]
    var children: [StaticQuadTree<T>?] = [nil, nil, nil, nil]
    // the items at this node that are too big to fit in a child node
    var items: [(value: T, area: CGRect)] = []
    
    public init(area: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100), depth: Int = 0) {
        self.depth = depth
        self.area = area
        let halfWidth = area.width / 2
        let halfHeight = area.height / 2
        childAreas = [
            CGRect(x: area.minX, y: area.minY, width: halfWidth, height: halfHeight),
            CGRect(x: area.minX + halfWidth, y: area.minY, width: halfWidth, height: halfHeight),
            CGRect(x: area.minX, y: area.minY + halfHeight, width: halfWidth, height: halfHeight),
            CGRect(x: area.minX + halfWidth, y: area.minY + halfHeight, width: halfWidth, height: halfHeight)
        ]
    }
    
    public mutating func removeAll() {
        items.removeAll()
        children = [nil, nil, nil, nil]
    }
    
    public var count: Int {
        var count = items.count
        for child in children {
            count += child?.count ?? 0
        }
        return count
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public mutating func insert(_ newElement: T, at elementArea: CGRect) {
        for (i, childRect) in childAreas.enumerated() {
            if childRect.contains(elementArea) {
                if (children[i] == nil && depth < QuadTree.maxDepth) {
                    let newChild = StaticQuadTree(area: childRect, depth: depth + 1)
                    children[i] = newChild
                }
                if children[i] != nil {
                    children[i]?.insert(newElement, at: elementArea)
                    return
                }
            }
        }
        // didn't insert into child so...
        items.append((value: newElement, area: elementArea))
    }
    
    public func search(in searchArea: CGRect) -> [T] {
        var results: [T] = []
        for item in items {
            if searchArea.intersects(item.area) {
                results.append(item.value)
            }
        }
        for child in children {
            if let child = child, searchArea.contains(child.area) {
                // whole child area is contained so add all its items
                results.append(contentsOf: child.allItems().map { $0.value })
            }
            else if let child = child, searchArea.intersects(child.area) {
                results.append(contentsOf: child.search(in: searchArea))
            }
        }
        return results
    }
    
    public func allItems() -> [(value: T, area: CGRect)] {
        var allItems = items
        for child in children {
            if let child = child {
                allItems.append(contentsOf: child.allItems())
            }
        }
        return allItems
    }
}
