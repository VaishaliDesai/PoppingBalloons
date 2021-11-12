import UIKit
import SpriteKit

class GameViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    DispatchQueue.main.async { [weak self] in
      let scene = GameScene(size: self?.view.bounds.size ?? .zero)
      scene.name = "gameScene"
      scene.scaleMode = .aspectFill
      let skView = self?.view as! SKView
      skView.showsFPS = true
      skView.showsNodeCount = true
      skView.ignoresSiblingOrder = true
      skView.presentScene(scene)
    }
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
