//
//  UserDetailViewController.swift
//  GaldenApp
//
//  Created by Kin Wa Lam on 19/10/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit
import KeychainSwift

class UserDetailViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var leaveNameTextField: UITextField!
    @IBOutlet weak var blocklistButton: UIButton!
    
    var email = ""
    var password = ""
    
    let api = HKGaldenAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        let keychain = KeychainSwift()
        if (keychain.get("userKey") != nil) {
            loginButton.isHidden = true
            logoutButton.isHidden = false
            emailTextField.isHidden = true
            passwordTextField.isHidden = true
            blocklistButton.isHidden = false
            self.userName.text = "已登入為: " + keychain.get("userName")! + " (UID: " + keychain.get("userID")! + ")"
            leaveNameTextField.text = keychain.get("LeaveNameText")
            self.userName.textColor = UIColor.white
        } else {
            loginButton.isHidden = false
            logoutButton.isHidden = true
            emailTextField.isHidden = false
            passwordTextField.isHidden = false
            blocklistButton.isHidden = true
            userName.text = "未登入 (UID: Unknown)"
            userName.textColor = UIColor.lightGray
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            email = emailTextField.text!
        case passwordTextField:
            password = passwordTextField.text!
        default:
            break
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let keychain = KeychainSwift()
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        api.login(email: email, password: password, completion: {
            self.api.getUserDetail(completion: {
                username, userid in
                keychain.set(username, forKey: "userName")
                keychain.set(userid, forKey: "userID")
                self.loginButton.isHidden = true
                self.logoutButton.isHidden = false
                self.emailTextField.isHidden = true
                self.passwordTextField.isHidden = true
                self.blocklistButton.isHidden = false
                self.userName.text = "已登入為: " + keychain.get("userName")! + " (UID: " + keychain.get("userID")! + ")"
                self.leaveNameTextField.text = keychain.get("LeaveNameText")
                self.userName.textColor = UIColor.white
            })
        })
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        api.logout {
            self.loginButton.isHidden = false
            self.logoutButton.isHidden = true
            self.emailTextField.isHidden = false
            self.passwordTextField.isHidden = false
            self.blocklistButton.isHidden = true
            self.userName.text = "未登入 (UID: Unknown)"
            self.userName.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func backgroundImagePicker(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func backToDefaultBackground(_ sender: UIButton) {
        let keychain = KeychainSwift()
        keychain.delete("BackgroundImage")
        let alert = UIAlertController(title: "注意", message: "重新載入app以套用",preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage]
        let imageData = UIImagePNGRepresentation(selectedImage as! UIImage)
        let keychain = KeychainSwift()
        keychain.set(imageData!, forKey: "BackgroundImage")
        dismiss(animated: true, completion: nil)
        let alert = UIAlertController(title: "注意", message: "重新載入app以套用",preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        leaveNameTextField.endEditing(true)
        let keychain = KeychainSwift()
        keychain.set(leaveNameTextField.text!, forKey: "LeaveNameText")
    }
}
