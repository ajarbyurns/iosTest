//
//  BottomSheetViewController.swift
//  iosTest
//
//  Created by bitocto_Barry on 18/06/22.
//

import UIKit

class BottomSheetViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var user: User? = nil {
        didSet{
            if let user = user {
                nameLabel.text = user.fullName
                profileImage.sd_setImage(with: URL(string: user.avatarLink), placeholderImage: UIImage(named: "empty"), options: .highPriority, context: nil)
            }
        }
    }
    weak var parentVC: UIViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImage.layer.cornerRadius = profileImage.frame.height/2
    }
    
    @IBAction func selectUser(_ sender: Any) {
        if let controllers = parentVC?.navigationController?.viewControllers {
            if let vc = controllers[controllers.count - 2] as? HomeViewController {
                self.dismiss(animated: true, completion: {
                    vc.user = self.user
                    self.parentVC?.navigationController?.popToViewController(vc, animated: true)
                })
            }
        }
    }
    
}
