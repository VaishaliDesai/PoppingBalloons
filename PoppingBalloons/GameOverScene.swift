import SpriteKit

class GameOverScene: SKScene {
  override init(size: CGSize) {
    super.init(size: size)
    
    let background = SKSpriteNode(imageNamed: "gameOver")
    background.name = "gameOverBackground"
    background.zPosition = -1
    background.scale(to: size)
    background.position = CGPoint(x: size.width / 2, y: size.height / 2)
    addChild(background)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
