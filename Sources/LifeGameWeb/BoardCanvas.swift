import JavaScriptKit
import LifeGame

class BoardCanvas {

    let context: JSObject

    static let cellSize = 6
    static let boarderWidth = 1

    let liveColor: String

    init(canvas: JSObject, size: (width: Int, height: Int), liveColor: String) {
        context = canvas.getContext!("2d").object!
        canvas.width = .number(Double(width * (BoardCanvas.cellSize + BoardCanvas.boarderWidth)))
        canvas.height = .number(Double(height * (BoardCanvas.cellSize + BoardCanvas.boarderWidth)))
        self.liveColor = liveColor 
    }

    fileprivate func getCellRect(at point: Point) -> (x: Int, y: Int, width: Int, height: Int) {
        (
            point.x * (BoardCanvas.cellSize + BoardCanvas.boarderWidth),
            point.y * (BoardCanvas.cellSize + BoardCanvas.boarderWidth),
            BoardCanvas.cellSize, BoardCanvas.cellSize
        )
    }

    fileprivate func drawPoint(at point: Point) {
        context.fillStyle = .string(liveColor)
        let rect = getCellRect(at: point)
        _ = context.fillRect!(rect.x, rect.y, rect.width, rect.height)
    }

    fileprivate func clearPoint(at point: Point) {
        let rect = getCellRect(at: point)
        _ = context.clearRect!(rect.x, rect.y, rect.width, rect.height)
    }

    func drawCell(_ cell: Cell, at point: Point) {
        if cell.live {
            drawPoint(at: point)
        } else {
            clearPoint(at: point)
        }
    }
}
