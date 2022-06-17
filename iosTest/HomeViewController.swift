//
//  HomeViewController.swift
//  iosTest
//
//  Created by bitocto_Barry on 17/06/22.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var emptyProfileLabel: UILabel!
    @IBOutlet weak var filledProfileView: UIView!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var website: UILabel!
    
    var user : User? = nil
    
    var showProfile = false {
        didSet{
            if(showProfile){
                filledProfileView.isHidden = false
                emptyProfileLabel.isHidden = true
            } else {
                filledProfileView.isHidden = true
                emptyProfileLabel.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameTitleLabel.text = UserDefaults.standard.string(forKey: "name")
        if let user = user {
            profileEmail.text = user.email
            profileNameLabel.text = user.fullName
            profileImage.sd_setImage(with: URL(string: user.avatarLink), placeholderImage: UIImage(named: "empty"), options: .highPriority, context: nil)
            showProfile = true
        }
    }
    
    @IBAction func chooseAUser(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "User"){
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func clickWebsite(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebView"){
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
