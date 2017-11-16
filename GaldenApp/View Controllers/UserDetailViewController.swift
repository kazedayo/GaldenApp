//
//  UserDetailViewController.swift
//  GaldenApp
//
//  Created by Kin Wa Lam on 19/10/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit
import KeychainSwift
import Toaster

class UserDetailViewController: UITableViewController,UINavigationControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var leaveNameTextField: UITextField!
    @IBOutlet weak var blocklistButton: UIButton!
    
    let api = HKGaldenAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //cancelButton.heroModifiers = [.position(CGPoint.init(x: 500, y: cancelButton.frame.midY))]
        let keychain = KeychainSwift()
        if (keychain.get("userKey") != nil) {
            loggedIn()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        api.logout {
            let keychain = KeychainSwift()
            keychain.delete("isLoggedIn")
            self.performSegue(withIdentifier: "logout", sender: self)
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        leaveNameTextField.endEditing(true)
        let keychain = KeychainSwift()
        keychain.set(leaveNameTextField.text!, forKey: "LeaveNameText")
    }
    
    @IBAction func changeNameButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController.init(title: "改名怪", message: "你想改咩名?", preferredStyle: .alert)
        alert.addTextField {
            textField in
            textField.placeholder = "新名"
        }
        alert.addAction(UIAlertAction(title:"改名",style:.default,handler:{
            [weak alert] _ in
            let textField = alert?.textFields![0]
            self.api.changeName(name: (textField?.text)!, completion: {
                status,newName in
                if status == "true" {
                    let keychain = KeychainSwift()
                    keychain.set(newName, forKey: "userName")
                    self.loggedIn()
                } else if status == "false" {
                    Toast.init(text: "改名失敗", delay: 0, duration: 1).show()
                }
            })
        }))
        present(alert,animated: true,completion: nil)
    }
    
    func loggedIn() {
        let keychain = KeychainSwift()
        self.userName.text = "已登入為: " + keychain.get("userName")! + " (UID: " + keychain.get("userID")! + ")"
        leaveNameTextField.text = keychain.get("LeaveNameText")
        self.userName.textColor = UIColor.gray

    }
}
