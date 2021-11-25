//
//  PostViewController.swift
//  dietApp
//
//  Created by 小倉瑞希 on 2021/11/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainAccess
import Kingfisher

class PostViewController: UIViewController {
    
    var posts:[Post] = []
    
    @IBOutlet weak var postTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.dataSource = self
        postTableView.delegate = self
        
        let url = "http://localhost/api/posts"
        
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).arrayValue
                print(json)
                self.posts = []
                for posts in json {
                    let post = Post(
                        id: posts["id"].int!,
                        body: posts["body"].string!,
                        charenge_id: posts["charenge_id"].int!
                    )
                    self.posts.append(post)
                }
                self.postTableView.reloadData()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
}

extension PostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].body
        return cell
    }
}

extension PostViewController: UITableViewDelegate {
    //セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
}

