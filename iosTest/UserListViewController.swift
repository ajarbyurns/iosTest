//
//  UserListViewController.swift
//  iosTest
//
//  Created by bitocto_Barry on 17/06/22.
//

import UIKit

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
            tableView.refreshControl?.endRefreshing()
        }
    }
    var images: [UIImage] = []
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshTable), for: .valueChanged)

        loadTable()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "User") as? UserTableViewCell
        cell?.displayPic.loadFromURL(link: user.avatarLink)
        cell?.emailLabel.text = user.email
        cell?.nameLabel.text = user.fullName
        return cell ?? UITableViewCell()
    }
    
    @objc func refreshTable(){
        currentPage = 1
        users = []
        loadTable()
    }

    func loadTable(){
        
        print(currentPage)
        
        if(currentPage == 0){
            return
        }
        
        let link = "https://reqres.in/api/users?page=\(currentPage)&per_page=10"
                            
        if let url = URL(string: link) {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request){data, response, error in
                
                guard error == nil else {
                    return
                }
                
                if let jsonData = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? Dictionary<String , Any> ?? [:]
                        //print(json)
                        let output = json["data"] as? [Dictionary<String, Any>] ?? []
                        var tempUsers : [User] = []
                        for item in output {
                            let userItem = User(input: item)
                            tempUsers.append(userItem)
                        }
                        DispatchQueue.main.async{
                            if(!tempUsers.isEmpty){
                                self.users = tempUsers
                            }
                            let totalPages = json["total_pages"] as? Int ?? 0
                            if(self.currentPage < totalPages){
                                self.currentPage = self.currentPage + 1
                            } else {
                                self.currentPage = 0
                            }
                        }
                    } catch {
                        print("ERROR \(error.localizedDescription)")
                    }
                }
                
            }.resume()
        }
    }
}
