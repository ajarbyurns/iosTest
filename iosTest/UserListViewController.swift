//
//  UserListViewController.swift
//  iosTest
//
//  Created by bitocto_Barry on 17/06/22.
//

import UIKit
import SDWebImage

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var loadingBar: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStateLabel: UILabel!
    var users: [User] = []{
        didSet{
            if(!users.isEmpty){
                loadingBar.stopAnimating()
                tableView.isHidden = false
                tableView.reloadData()
            } else{
                loadingBar.isHidden = true
                emptyStateLabel.isHidden = false
            }
        }
    }
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshTable), for: .valueChanged)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadTable()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "User") as? UserTableViewCell
        cell?.displayPic.sd_setImage(with: URL(string: user.avatarLink), placeholderImage: UIImage(named: "empty"), options: .retryFailed, context: nil)
        cell?.emailLabel.text = user.email
        cell?.nameLabel.text = user.fullName
        
        if indexPath.row == self.users.count - 1 {
            self.loadTable()
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tempUser = users[indexPath.row]
        if let controllers = navigationController?.viewControllers {
            if let vc = controllers[controllers.count - 2] as? HomeViewController {
                vc.user = tempUser
                navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    
    @objc func refreshTable(){
        currentPage = 1
        loadTable()
    }

    func loadTable(){
                
        if(currentPage == 0){
            tableView.refreshControl?.endRefreshing()
            return
        }
                
        let link = "https://reqres.in/api/users?page=\(currentPage)&per_page=10"
                            
        if let url = URL(string: link) {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request){data, response, error in
                
                guard error == nil else {
                    DispatchQueue.main.async{
                        self.tableView.refreshControl?.endRefreshing()
                    }
                    return
                }
                
                if let jsonData = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? Dictionary<String , Any> ?? [:]
                        //print(json)
                        let output = json["data"] as? [Dictionary<String, Any>] ?? []
                        var tempUsers : [User] = []
                        for item in output {
                            tempUsers.append(User(input: item))
                        }
                        DispatchQueue.main.async{
                            if(self.currentPage == 1){
                                self.users = tempUsers
                            } else {
                                self.users.append(contentsOf: tempUsers)
                            }
                            let totalPages = json["total_pages"] as? Int ?? 0
                            if(self.currentPage < totalPages){
                                self.currentPage = self.currentPage + 1
                            } else {
                                self.currentPage = 0
                            }
                            self.tableView.refreshControl?.endRefreshing()
                        }
                    } catch {
                        print("ERROR \(error.localizedDescription)")
                        DispatchQueue.main.async{
                            self.tableView.refreshControl?.endRefreshing()
                            self.users = []
                        }
                    }
                }
                
            }.resume()
        }
    }
}
