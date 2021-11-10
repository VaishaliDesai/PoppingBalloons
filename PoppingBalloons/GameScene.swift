import SpriteKit

class GameScene: SKScene {
  
  override func didMove(to view: SKView) {
    backgroundColor = .white
    
    run(SKAction.repeatForever(
      SKAction.sequence([
        SKAction.run(flyBalloon),
        SKAction.wait(forDuration: 1.0)
      ])
    ))
    
    let backgroundMusic = SKAudioNode(fileNamed: "background-music-aac.caf")
    backgroundMusic.autoplayLooped = true
    addChild(backgroundMusic)
  }
  
  func flyBalloon() {
    let balloon = SKSpriteNode(imageNamed: Color.allCases.randomElement()?.rawValue ?? Color.red.rawValue)
    
    balloon.position = CGPoint(x: CGFloat.random(in: 0...size.width), y: 0) //random
    addChild(balloon)
    
    let actualDuration = CGFloat.random(in: 4.0...6.0)
    
    ///fly balloons straight up
//    let actualMove = SKAction.move(to: CGPoint(x: size.width/2, y: size.height), duration: TimeInterval(actualDuration))
    
    ///fly balloons more towards left
    //let min = size.height/2
//    let max = size.height - size.height/2
    //let actualMove = SKAction.move(to: CGPoint(x: CGFloat.random(in: min...max), y: size.height), duration: TimeInterval(actualDuration))
    
    ///fly balloons both the sides distributed
    let max = size.width
    let actualMove = SKAction.move(to: CGPoint(x: CGFloat.random(in: 0...max), y: size.height), duration: TimeInterval(actualDuration))
    
    let actionMoveDone = SKAction.removeFromParent()
    balloon.run(SKAction.sequence([actualMove, actionMoveDone]))
  }
    
  func balloonBursts(balloon: SKNode) {
    let balloonSpriteNode = SKSpriteNode(imageNamed: Color.allCases.randomElement()?.rawValue ?? Color.red.rawValue)
    balloonSpriteNode.position = balloon.position
    addChild(balloonSpriteNode)
    balloon.removeFromParent()
  }
}

public enum Color: String, CaseIterable {
  case blue = "balloon_blue"
  case brown = "balloon_brown"
  case cyan = "balloon_cyan"
  case green = "balloon_green"
  case lime = "balloon_lime"
  case olive = "balloon_olive"
  case orange = "balloon_orange"
  case pink = "balloon_pink"
  case purple = "balloon_purple"
  case red = "balloon_red"
  case yellow = "balloon_yellow"
}


