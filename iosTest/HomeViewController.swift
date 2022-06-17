//
//  HomeViewController.swift
//  iosTest
//
//  Created by bitocto_Barry on 17/06/22.
//

import UIKit

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
            filledProfileView.isHidden = !filledProfileView.isHidden
            emptyProfileLabel.isHidden = !emptyProfileLabel.isHidden
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = user {
            profileEmail.text = user.email
            profileNameLabel.text = user.fullName
            profileImage.loadFromURL(link: user.avatarLink)
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

extension UIImageView {
    
    func loadFromURL(link: String){
        if let url = URL(string: link){
            DispatchQueue.main.async {
                [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        self?.image = image
                    }
                }
            }
        }
    }
}
