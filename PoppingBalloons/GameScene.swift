import SpriteKit

class GameScene: SKScene {
  var balloon: SKSpriteNode!
  
  override func didMove(to view: SKView) {
    backgroundColor = .white
    run(SKAction.repeatForever(
      SKAction.sequence([
        SKAction.run(flyBalloon),
        SKAction.wait(forDuration: 1.0)
      ])
    ))
    
    let background = SKSpriteNode(imageNamed: "background")
    background.position = CGPoint(x: size.width / 2, y: size.height / 2)
    background.scale(to: size)
    addChild(background)
    
    let backgroundMusic = SKAudioNode(fileNamed: "background.mp3")
    backgroundMusic.autoplayLooped = true
    addChild(backgroundMusic)
    
    physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
  }
  
  func flyBalloon() {
    balloon = SKSpriteNode(imageNamed: Color.allCases.randomElement()?.rawValue ?? Color.red.rawValue)
    
    balloon.position = CGPoint(x: CGFloat.random(in: 0...size.width), y: 0) //random
    balloon.physicsBody = SKPhysicsBody(circleOfRadius: balloon.size.width)
    balloon.physicsBody?.isDynamic = false
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
  
  func burstBalloon(balloon: SKNode) {
    run(SKAction.playSoundFileNamed("balloon_pop", waitForCompletion: false))
    balloon.removeFromParent()
    
    addCelebration(ballon: balloon)
  }
  
  func addCelebration(ballon: SKNode) {
    let size = size.width * 0.01
    let emitter = SKEmitterNode()
    emitter.particleSize = CGSize(width: size, height: size)
    emitter.particleZPosition = 2
    emitter.numParticlesToEmit = 100
    emitter.particleBirthRate = 300
    emitter.particleLifetimeRange = 5
    emitter.emissionAngleRange = 360 * .pi / 180
    emitter.particleSpeed = 700
    emitter.particleColor = .red
    emitter.position = ballon.position
    emitter.particleColorSequence = SKKeyframeSequence(
      keyframeValues: [SKColor.yellow, SKColor.red, SKColor.lightGray,SKColor.gray],
      times: [0, 0.25, 0.5, 1]
    )
    addChild(emitter)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      
      let touchLocation = touch.location(in: self)
      let balloonNode = physicsWorld.body(at: touchLocation)?.node
      
      if balloonNode?.contains(touchLocation) != nil {
        burstBalloon(balloon: balloonNode!)
      }
    }
  }
}

public enum Color: String, CaseIterable {
  case blue = "blue"
  case brown = "brown"
  case cyan = "cyan"
  case green = "green"
  case lime = "lime"
  case olive = "olive"
  case orange = "orange"
  case pink = "pink"
  case purple = "purple"
  case red = "red"
  case yellow = "yellow"
}


