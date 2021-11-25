//
//  LoginViewController.swift
//  dietApp
//
//  Created by 小倉瑞希 on 2021/11/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainAccess

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: Any) {
        
        let email = emailTextField.text
        let password = passwordTextField.text
        
        let url = "http://localhost/api/login"
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                self.transitionToTabBar()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func transitionToTabBar() {
        let tabBarContorller = self.storyboard?.instantiateViewController(withIdentifier: "TabBarC") as! UITabBarController
        tabBarContorller.modalPresentationStyle = .fullScreen
        present(tabBarContorller, animated: true, completion: nil)
    }
}
