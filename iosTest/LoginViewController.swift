//
//  LoginViewController.swift
//  iosTest
//
//  Created by bitocto_Barry on 17/06/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var palindrome: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    @IBAction func onCheck(_ sender: Any) {
        let text = palindrome.text ?? ""
        let reverse = String(text.reversed())
        var message = "not palindrome"
        if(text == reverse){
            message = "isPalindrome"
        }
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
        
    
    @IBAction func onNext(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Home") {
            UserDefaults.standard.set(name.text ?? "", forKey: "name")
            navigationController?.pushViewController(vc, animated: true)
        }
            
    }
    
}
