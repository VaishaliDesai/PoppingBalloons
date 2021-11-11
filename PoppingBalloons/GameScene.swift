import SpriteKit

class GameScene: SKScene {
  var balloon: SKSpriteNode!
  var scoreLabel: SKLabelNode!
  
  var score = 0 {
    didSet {
      scoreLabel.text = "Score: \(score)"
    }
  }
  
  override func didMove(to view: SKView) {
    backgroundColor = .white
    run(SKAction.repeatForever(
      SKAction.sequence([
        SKAction.run(flyBalloon),
        SKAction.wait(forDuration: 1.0)
      ])
    ))
    
    addBackgroundWithMusic()
    addScoreLabel()
  }
  
  func addBackgroundWithMusic() {
    let background = SKSpriteNode(imageNamed: "background")
    background.name = "background"
    background.position = CGPoint(x: size.width / 2, y: size.height / 2)
    background.scale(to: size)
    addChild(background)
    
    let backgroundMusic = SKAudioNode(fileNamed: "background.mp3")
    backgroundMusic.name = "backgroundMusic"
    backgroundMusic.autoplayLooped = true
    addChild(backgroundMusic)
    
    physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
  }
  
  func addScoreLabel() {
    scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    scoreLabel.name = "scoreLabel"
    scoreLabel.fontColor = .red
    scoreLabel.fontSize = 20
    scoreLabel.text = "Score: 0"
    scoreLabel.horizontalAlignmentMode = .right
    scoreLabel.position = CGPoint(x: self.size.width - 20, y: self.size.height - 20)
    addChild(scoreLabel)
  }
  
  func flyBalloon() {
    let xRange = CGFloat.random(in: 0...size.width)
    balloon = SKSpriteNode(imageNamed: String(describing: Color.allCases.randomElement() ?? Color.red))
    
    balloon.position = CGPoint(x: xRange, y: 0) //random
    balloon.setScale(2)
    balloon.physicsBody = SKPhysicsBody(circleOfRadius: balloon.size.width)
    balloon.physicsBody?.isDynamic = false
    addChild(balloon)
    
    ///fly balloons straight up
//    let actualMove = SKAction.move(to: CGPoint(x: size.width/2, y: size.height), duration: TimeInterval(actualDuration))
    
    ///fly balloons more towards left
    //let min = size.height/2
//    let max = size.height - size.height/2
    //let actualMove = SKAction.move(to: CGPoint(x: CGFloat.random(in: min...max), y: size.height), duration: TimeInterval(actualDuration))
    
    ///fly balloons both the sides distributed
    let speed = TimeInterval(CGFloat.random(in: 4.0...6.0))
    let actualMove = SKAction.move(to: CGPoint(x: xRange, y: size.height), duration: speed)
    
    let actionMoveDone = SKAction.removeFromParent()
    balloon.run(SKAction.sequence([actualMove, actionMoveDone]))
  }
  
  func burstBalloon(balloon: SKNode) {
    run(SKAction.playSoundFileNamed("balloon_pop", waitForCompletion: false))
    balloon.removeFromParent()
    score += 1
    
    addCelebration(balloon: balloon)
  }
  
  func addCelebration(balloon: SKNode) {
    let size = size.width * 0.01
    let emitter = SKEmitterNode()
    emitter.name = "emitter"
    emitter.particleSize = CGSize(width: size, height: size)
    emitter.particleZPosition = 2
    emitter.numParticlesToEmit = 100
    emitter.particleBirthRate = 300
    emitter.particleLifetimeRange = 5
    emitter.emissionAngleRange = 360 * .pi / 180
    emitter.particleSpeed = 700
    emitter.particleColor = .red
    emitter.position = balloon.position
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

public enum Color: CaseIterable {
  case blue
  case brown
  case cyan
  case green
  case lime
  case olive
  case orange
  case pink
  case purple
  case red
  case yellow
}


