import Testing
import CoreGraphics

@testable import QuadTree

@Test func testInitAndArea() {
    let area = CGRect(x: 0, y: 0, width: 100, height: 100)
    let container = StaticQuadTreeContainer<Int>(area: area)
    #expect(container.area == area)
    #expect(container.isEmpty)
    #expect(container.count == 0)
}

@Test func testInsertAndAccess() {
    var container = StaticQuadTreeContainer<String>(
        area: CGRect(x: 0, y: 0, width: 100, height: 100)
    )
    let rect1 = CGRect(x: 10, y: 10, width: 10, height: 10)
    let rect2 = CGRect(x: 50, y: 50, width: 10, height: 10)
    container.insert("A", at: rect1)
    container.insert("B", at: rect2)
    #expect(container.count == 2)
    #expect(container[0] == "A")
    #expect(container[1] == "B")
}

@Test func testRemoveAll() {
    var container = StaticQuadTreeContainer<Int>(
        area: CGRect(x: 0, y: 0, width: 100, height: 100)
    )
    container.insert(1, at: CGRect(x: 10, y: 10, width: 10, height: 10))
    container.insert(2, at: CGRect(x: 20, y: 20, width: 10, height: 10))
    #expect(!container.isEmpty)
    container.removeAll()
    #expect(container.isEmpty)
    #expect(container.count == 0)
}

@Test func testSearch() {
    var container = StaticQuadTreeContainer<Int>(
        area: CGRect(x: 0, y: 0, width: 100, height: 100)
    )
    container.insert(1, at: CGRect(x: 10, y: 10, width: 10, height: 10))
    container.insert(2, at: CGRect(x: 50, y: 50, width: 10, height: 10))
    container.insert(3, at: CGRect(x: 80, y: 80, width: 10, height: 10))
    let foundIndices = container.search(
        in: CGRect(x: 0, y: 0, width: 30, height: 30)
    )
    #expect(foundIndices.contains(0))
    #expect(!foundIndices.contains(1))
    #expect(!foundIndices.contains(2))
}

@Test func testCollectionConformance() {
    var container = StaticQuadTreeContainer<String>(
        area: CGRect(x: 0, y: 0, width: 100, height: 100)
    )
    container.insert("A", at: CGRect(x: 10, y: 10, width: 10, height: 10))
    container.insert("B", at: CGRect(x: 50, y: 50, width: 10, height: 10))
    let all = Array(container)
    #expect(all == ["A", "B"])
}
