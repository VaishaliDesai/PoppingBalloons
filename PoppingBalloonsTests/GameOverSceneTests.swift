import XCTest
@testable import PoppingBalloons
import SpriteKit

class GameOverSceneTests: XCTestCase {
  private var gameOverScene = GameOverScene(size: .zero)

    override func setUp() {
      super.setUp()
    }

    override func tearDown() {
      super.tearDown()
    }

    func test_background() throws {
      let background = try XCTUnwrap(gameOverScene.childNode(withName: "gameOverBackground") as? SKSpriteNode)
      
      XCTAssertEqual(background.zPosition, -1)
      XCTAssertEqual(background.position, CGPoint(x: gameOverScene.size.width / 2, y: gameOverScene.size.height / 2))
    }
}
