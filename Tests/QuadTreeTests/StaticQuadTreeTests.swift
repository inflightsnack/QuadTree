//
//  StaticQuadTreeTests.swift
//  QuadTree
//
//  Created by Martin Bell on 07/09/2025.
//

import Testing
import CoreGraphics

@testable import QuadTree



@Test func insertIntoStaticQuadTree() async throws {
    // Test that inserting an element into the StaticQuadTree works correctly.
    var quadTree = StaticQuadTree<Int>(area: CGRect(x: 0, y: 0, width: 100, height: 100))
    quadTree.insert(1, at: CGRect(x: 10, y: 10, width: 5, height: 5))
    #expect(quadTree.count == 1)
}

@Test func searchInStaticQuadTree() async throws {
    // Test searching for elements in a region.
    var quadTree = StaticQuadTree<Int>(area: CGRect(x: 0, y: 0, width: 100, height: 100))
    quadTree.insert(1, at: CGRect(x: 10, y: 10, width: 5, height: 5))
    quadTree.insert(2, at: CGRect(x: 50, y: 50, width: 10, height: 10))
    quadTree.insert(3, at: CGRect(x: 80, y: 80, width: 5, height: 5))
    let results = quadTree.query(in: CGRect(x: 0, y: 0, width: 60, height: 60))
    #expect(results.contains(1))
    #expect(results.contains(2))
    #expect(!results.contains(3))
}

@Test func removeAllFromStaticQuadTree() async throws {
    // Test removing all elements.
    var quadTree = StaticQuadTree<Int>(area: CGRect(x: 0, y: 0, width: 100, height: 100))
    quadTree.insert(1, at: CGRect(x: 10, y: 10, width: 5, height: 5))
    quadTree.insert(2, at: CGRect(x: 20, y: 20, width: 5, height: 5))
    quadTree.removeAll()
    #expect(quadTree.isEmpty)
    #expect(quadTree.count == 0)
}

@Test func overlappingAreasStaticQuadTree() async throws {
    // Test inserting overlapping areas and searching.
    var quadTree = StaticQuadTree<String>(area: CGRect(x: 0, y: 0, width: 100, height: 100))
    quadTree.insert("A", at: CGRect(x: 10, y: 10, width: 20, height: 20))
    quadTree.insert("B", at: CGRect(x: 15, y: 15, width: 10, height: 10))
    let results = quadTree.query(in: CGRect(x: 12, y: 12, width: 5, height: 5))
    #expect(results.contains("A"))
    #expect(results.contains("B"))
}

@Test func outOfBoundsInsertionStaticQuadTree() async throws {
    // Test inserting an element outside the tree area.
    var quadTree = StaticQuadTree<Int>(area: CGRect(x: 0, y: 0, width: 100, height: 100))
    quadTree.insert(99, at: CGRect(x: 200, y: 200, width: 10, height: 10))
    #expect(quadTree.count == 1) // Should still be counted, but not found in a normal search
    let results = quadTree.query(in: CGRect(x: 0, y: 0, width: 100, height: 100))
    #expect(!results.contains(99))
}

@Test func emptySearchStaticQuadTree() async throws {
    // Test searching an empty region.
    let quadTree = StaticQuadTree<Int>(area: CGRect(x: 0, y: 0, width: 100, height: 100))
    let results = quadTree.query(in: CGRect(x: 10, y: 10, width: 5, height: 5))
    #expect(results.isEmpty)
}
