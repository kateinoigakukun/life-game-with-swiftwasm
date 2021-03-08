import JavaScriptKit
import LifeGame

class PersistedBoardCanvas: BasicBoardCanvas {
    let liveStepsColor = ["#000000", "#0b450d", "#0f5711", "#136915", "#17911b", "#1bab20", "#21cc26", "#24e32a", "#29fd2f"]

    var persisted:[[Int]]

    public required init(canvas: JSObject, size: (width: Int, height: Int)) {
        self.persisted = (1...width).map( { _ in 
            return (1...height).map( { _ in
                return 0
            })
        })

        super.init(canvas: canvas, size: size)
    }

    override public var shouldDrawCellOnNoUpdate: Bool {
        return true
    }
    
    func needsRedraw(_ cell: Cell, at point: Point) {
        if (self.persisted[point.x][point.y] > 0) {
            drawPoint(at: point, color: .string(self.liveStepsColor[persisted[point.x][point.y]]))
        } else {
            clearPoint(at: point)
        }
    }

    override public func drawCell(_ cell: Cell, at point: Point) {
        var changed = false
        if cell.live {
            if (self.persisted[point.x][point.y] != self.liveStepsColor.count - 1) {
                changed = true
                self.persisted[point.x][point.y] = self.liveStepsColor.count - 1
            }
        } else {
            if (self.persisted[point.x][point.y] > 0) {
                changed = true
                self.persisted[point.x][point.y] -= 1
            }
        }
        if changed {
            self.needsRedraw(cell, at: point)   
        }
    }
}