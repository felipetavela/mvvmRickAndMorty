import Foundation
import UIKit

class ViewControllerMenu: UIViewController {
    
    @IBOutlet weak var characterButton: UIButton!
    @IBOutlet weak var locationsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "rick")!)
        
        characterButton.layer.cornerRadius = 10
        locationsButton.layer.cornerRadius = 10
        
       }
    }

