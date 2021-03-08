public struct Cell: Equatable {
    public let live: Bool
    public init(live: Bool) {
        self.live = live
    }
}

public typealias Point = (x: Int, y: Int)

public protocol BoardUpdater {
    func update(at point: Point, cell: Cell)
    func noUpdate(at point: Point, cell: Cell)
}

public func iterate<U: BoardUpdater>(_ cells: [[Cell]], updater: U) {
    let height = cells.count
    let width = cells[0].count
    forEachCell(cells) { cell, point in
        var liveCount = 0
        for dy in [-1, 0, 1] {
            for dx in [-1, 0, 1] {
                if dy == 0 && dx == 0 { continue }
                guard 0..<height ~= (point.y + dy),
                      0..<width ~= (point.x + dx) else {
                    continue
                }

                liveCount += cells[point.y + dy][ point.x + dx].live ? 1 : 0
            }
        }

        if !cell.live {
            guard liveCount == 3 else { 
                updater.noUpdate(at: point, cell: cell)
                return 
            }
            updater.update(at: point, cell: Cell(live: true))
        }

        switch liveCount {
        case 2, 3: 
            updater.noUpdate(at: point, cell: cell)
            return
        case ...1:
            updater.update(at: point, cell:  Cell(live: false))
            return
        case 4...:
            updater.update(at: point, cell:  Cell(live: false))
            return
        default: fatalError("unreachable")
        }
    }
}

public func forEachCell(_ cells: [[Cell]], _ f: (Cell, Point) -> Void) {
    for (y, rows) in cells.enumerated() {
        for (x, cell) in rows.enumerated() {
            f(cell, (x, y))
        }
    }
}
