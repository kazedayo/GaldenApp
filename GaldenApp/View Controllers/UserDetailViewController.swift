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
    @IBOutlet weak var logoutButton: UIButton!
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
        let keychain = KeychainSwift()
        if (keychain.get("userKey") != nil) {
            loggedIn()
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
        logoutButton.isHidden = false
        blocklistButton.isHidden = false
        leaveNameStack.isHidden = false
        self.userName.text = "已登入為: " + keychain.get("userName")! + " (UID: " + keychain.get("userID")! + ")"
        leaveNameTextField.text = keychain.get("LeaveNameText")
        self.userName.textColor = UIColor.white

    }
}
