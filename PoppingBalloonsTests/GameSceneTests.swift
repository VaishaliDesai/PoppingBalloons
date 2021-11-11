import XCTest
@testable import PoppingBalloons
import SpriteKit

class GameSceneTests: XCTestCase {
  private var gameScene: GameScene!

    override func setUp() {
      super.setUp()
      
      gameScene = GameScene()
    }

    override func tearDown() {
      gameScene = nil
      
      super.tearDown()
    }

    func test_backgroundWithMusic() throws {
      gameScene.addBackgroundWithMusic()
      
      let background = try XCTUnwrap(gameScene.childNode(withName: "background") as? SKSpriteNode)
      let backgroundMusic = try XCTUnwrap(gameScene.childNode(withName: "backgroundMusic") as? SKAudioNode)
      
      XCTAssertEqual(background.position, CGPoint(x: gameScene.size.width / 2, y: gameScene.size.height / 2))
      
      XCTAssertTrue(backgroundMusic.autoplayLooped)
    }
  
  func test_addScoreLabel() throws {
    gameScene.addScoreLabel()
    
    let scoreLabel = try XCTUnwrap(gameScene.childNode(withName: "scoreLabel") as? SKLabelNode)
    
    XCTAssertEqual(scoreLabel.fontColor, .red)
    XCTAssertEqual(scoreLabel.fontSize, 20)
    XCTAssertEqual(scoreLabel.text, "Score: 0")
    XCTAssertEqual(scoreLabel.horizontalAlignmentMode, .right)
    XCTAssertEqual(scoreLabel.position, CGPoint(x: gameScene.size.width - 20, y: gameScene.size.height - 20))
  }
  
  func test_flyBalloon() {
    let range: ClosedRange<CGFloat> = 0...gameScene.size.width
    gameScene.flyBalloon()
    
    XCTAssertTrue(range.contains(gameScene.balloon.position.x), "x is: \(gameScene.balloon.position.x)")
    XCTAssertEqual(gameScene.balloon.position.y, 0)
    XCTAssertEqual(gameScene.balloon.xScale, 2)
    XCTAssertEqual(gameScene.balloon.yScale, 2)
    XCTAssertFalse(try XCTUnwrap(gameScene.balloon.physicsBody?.isDynamic))
    
    
  }
  
  func test_burstBalloon() throws {
    let balloon = SKNode()
    
    gameScene.addScoreLabel()
    
    XCTAssertEqual(gameScene.score, 0, "precondition")
    
    gameScene.burstBalloon(balloon: balloon)
    XCTAssertEqual(gameScene.score, 1)
  }
  
  func test_addCelebration() throws {
    let balloon = SKNode()
    let size = gameScene.size.width * 0.01
    
    gameScene.addCelebration(balloon: balloon)
    
    let emitter = try XCTUnwrap(gameScene.childNode(withName: "emitter") as? SKEmitterNode)
    XCTAssertEqual(emitter.particleSize, CGSize(width: size, height: size))
    XCTAssertEqual(emitter.particleZPosition, 2)
    XCTAssertEqual(emitter.numParticlesToEmit, 100)
    XCTAssertEqual(emitter.particleBirthRate, 300)
    XCTAssertEqual(emitter.particleLifetimeRange, 5)
    XCTAssertEqual(floor(emitter.emissionAngleRange), 6)
    XCTAssertEqual(emitter.particleSpeed, 700)
    XCTAssertEqual(emitter.particleColor, .red)
    XCTAssertEqual(emitter.position, balloon.position)
    XCTAssertEqual(emitter.particleColorSequence?.count(), 4)
    XCTAssertEqual(emitter.particleColorSequence?.getKeyframeValue(for: 0) as? SKColor, .yellow)
    XCTAssertEqual(emitter.particleColorSequence?.getKeyframeTime(for: 0), 0)
    XCTAssertEqual(emitter.particleColorSequence?.getKeyframeValue(for: 1) as? SKColor, .red)
    XCTAssertEqual(emitter.particleColorSequence?.getKeyframeTime(for: 1), 0.25)
    XCTAssertEqual(emitter.particleColorSequence?.getKeyframeValue(for: 2) as? SKColor, .lightGray)
    XCTAssertEqual(emitter.particleColorSequence?.getKeyframeTime(for: 2), 0.5)
    XCTAssertEqual(emitter.particleColorSequence?.getKeyframeValue(for: 3) as? SKColor, .gray)
    XCTAssertEqual(emitter.particleColorSequence?.getKeyframeTime(for: 3), 1)
  }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
