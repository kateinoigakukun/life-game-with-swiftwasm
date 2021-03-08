import JavaScriptKit
import LifeGame

public class BasicBoardCanvas: BoardCanvas {
    let context: JSObject

    static let cellSize = 6
    static let boarderWidth = 1

    let liveColor = "#29fd2f"

    public required init(canvas: JSObject, size: (width: Int, height: Int)) {
        context = canvas.getContext!("2d").object!
        canvas.width = .number(Double(width * (BasicBoardCanvas.cellSize + BasicBoardCanvas.boarderWidth)))
        canvas.height = .number(Double(height * (BasicBoardCanvas.cellSize + BasicBoardCanvas.boarderWidth)))
    }

    func getCellRect(at point: Point) -> (x: Int, y: Int, width: Int, height: Int) {
        (
            point.x * (BasicBoardCanvas.cellSize + BasicBoardCanvas.boarderWidth),
            point.y * (BasicBoardCanvas.cellSize + BasicBoardCanvas.boarderWidth),
            BasicBoardCanvas.cellSize, BasicBoardCanvas.cellSize
        )
    }

    func drawPoint(at point: Point, color: JSValue) {
        context.fillStyle = color
        let rect = getCellRect(at: point)
        _ = context.fillRect!(rect.x, rect.y, rect.width, rect.height)
    }

    func clearPoint(at point: Point) {
        let rect = getCellRect(at: point)
        _ = context.clearRect!(rect.x, rect.y, rect.width, rect.height)
    }

    public var shouldDrawCellOnNoUpdate: Bool {
        return false
    }

    public func drawCell(_ cell: Cell, at point: Point) {
        if cell.live {
            drawPoint(at: point, color: .string(liveColor))
        } else {
            clearPoint(at: point)
        }
    }
}
