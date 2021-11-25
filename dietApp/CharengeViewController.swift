//
//  CharengeViewController.swift
//  dietApp
//
//  Created by 小倉瑞希 on 2021/11/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainAccess
import Kingfisher

class CharengeViewController: UIViewController{
    
    var charenges:[Charenge] = []

    @IBOutlet weak var charengeTableView: UITableView!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var charengeImage: UIImageView!
//    @IBOutlet weak var bodyLabel: UILabel!
    
    var titleLabel = String()
    var bodyLabel = String()
    var charengeImage = UIImage()
    
    var contentsArray = [Contents]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charengeTableView.dataSource = self
        charengeTableView.delegate = self
        
        let url = "http://localhost/api/charenges"
        
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).arrayValue
                print(json)
                self.charenges = []
                for charenges in json {
                    let charenge = Charenge(
                        id: charenges["id"].int!,
                        title: charenges["title"].string!,
                        body: charenges["body"].string!,
                        image: charenges["image"].string!
                    )
                    self.charenges.append(charenge)
                }
                self.charengeTableView.reloadData()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }

    }
}

extension CharengeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharengeCell", for: indexPath)
//        let charengeImage = cell.viewWithTag(1) as! UIImageView
//        charengeImage.sd_setImage(with: URL(string: contentsArray[indexPath.row].charengeImageString), completed: nil)

        let titleLabel = cell.viewWithTag(2) as! UILabel
        titleLabel.text = contentsArray[indexPath.row].titleLabelString
        let bodyLabel = cell.viewWithTag(3) as! UILabel
        bodyLabel.text = contentsArray[indexPath.row].bodyLabelString
//        cell.textLabel?.text = charenges[indexPath.row].title + charenges[indexPath.row].body
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height * 1 / 5
    }
}

extension CharengeViewController: UITableViewDelegate {
    //セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番目の行が選択されました。")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}




