//
//  UserDetailViewController.swift
//  GaldenApp
//
//  Created by Kin Wa Lam on 19/10/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit
import KeychainSwift

class UserDetailViewController: UIViewController,UINavigationControllerDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var leaveNameTextField: UITextField!
    @IBOutlet weak var blocklistButton: UIButton!
    @IBOutlet weak var leaveNameStack: UIStackView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var background: UIImageView!
    
    var email = ""
    var password = ""
    
    let api = HKGaldenAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //cancelButton.heroModifiers = [.position(CGPoint.init(x: 500, y: cancelButton.frame.midY))]
        emailTextField.delegate = self
        passwordTextField.delegate = self
        let keychain = KeychainSwift()
        if (keychain.get("userKey") != nil) {
            loggedIn()
        } else {
            loggedOut()
        }
        if keychain.getData("BackgroundImage") != nil {
            background.image = UIImage.init(data: keychain.getData("BackgroundImage")!)
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
                self.loggedIn()
            })
        })
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        api.logout {
            self.loggedOut()
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backgroundImagePicker(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.navigationBar.barStyle = .black
        imagePicker.navigationBar.tintColor = .white
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker,animated: true,completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let keychain = KeychainSwift()
        keychain.set(UIImagePNGRepresentation(selectedImage)!, forKey: "BackgroundImage")
        dismiss(animated: true, completion: {
            let alert = UIAlertController(title: "注意", message: "重新載入app以套用",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    @IBAction func backToDefaultBackground(_ sender: UIButton) {
        let keychain = KeychainSwift()
        keychain.delete("BackgroundImage")
        let alert = UIAlertController(title: "注意", message: "重新載入app以套用",preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        leaveNameTextField.endEditing(true)
        let keychain = KeychainSwift()
        keychain.set(leaveNameTextField.text!, forKey: "LeaveNameText")
    }
    
    func loggedIn() {
        let keychain = KeychainSwift()
        loginButton.isHidden = true
        logoutButton.isHidden = false
        emailTextField.isHidden = true
        passwordTextField.isHidden = true
        blocklistButton.isHidden = false
        leaveNameStack.isHidden = false
        self.userName.text = "已登入為: " + keychain.get("userName")! + " (UID: " + keychain.get("userID")! + ")"
        leaveNameTextField.text = keychain.get("LeaveNameText")
        self.userName.textColor = UIColor.white

    }
    
    func loggedOut() {
        loginButton.isHidden = false
        logoutButton.isHidden = true
        emailTextField.isHidden = false
        passwordTextField.isHidden = false
        blocklistButton.isHidden = true
        leaveNameStack.isHidden = true
        userName.text = "未登入 (UID: Unknown)"
        userName.textColor = UIColor.lightGray
    }
}
