//
//  UserViewController.swift
//  iosTest
//
//  Created by bitocto_Barry on 17/06/22.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var container: UIView!
    var listOrMap = true {
        didSet{
            for views in container.subviews {
                views.removeFromSuperview()
            }
            if(listOrMap){
                userListVC?.view.frame = container.bounds
                container.addSubview(userListVC?.view ?? UIView())
                navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "mapMenu"), style: .plain, target: self, action: #selector(navBar))
            } else {
                mapVC?.view.frame = container.bounds
                container.addSubview(mapVC?.view ?? UIView())
                navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "listMenu"), style: .plain, target: self, action: #selector(mapBar))
            }
        }
    }
    var userListVC : UserListViewController? = nil
    var mapVC: MapViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        userListVC = storyboard?.instantiateViewController(withIdentifier: "UserList") as? UserListViewController
        mapVC = storyboard?.instantiateViewController(withIdentifier: "Map") as? MapViewController
        if let userListVC = userListVC {
            addChild(userListVC)
        }
        if let mapVC = mapVC {
            addChild(mapVC)
        }
        
        listOrMap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.rightBarButtonItem = nil
    }

    @objc func navBar(){
        listOrMap = !listOrMap
    }
    
    @objc func mapBar(){
        listOrMap = !listOrMap
    }

}
