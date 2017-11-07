//
//  FirstLoginViewController.swift
//  GaldenApp
//
//  Created by Kin Wa Lam on 7/11/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit
import KeychainSwift

class FirstLoginViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var loginText: UIStackView!
    @IBOutlet weak var noAccount: UIStackView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let keychain = KeychainSwift()
    let api = HKGaldenAPI()
    
    var email = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
        loginText.heroModifiers = [.fade,.position(CGPoint(x:loginText.frame.midX,y:100))]
        noAccount.heroModifiers = [.fade,.position(CGPoint(x:noAccount.frame.midX,y:650))]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cdromButtomPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Start", sender: self)
        keychain.set(false, forKey: "isFirstTimeUsage")
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        emailField.endEditing(true)
        passwordField.endEditing(true)
        api.login(email: email, password: password, completion: {
            self.api.getUserDetail(completion: {
                username, userid in
                self.keychain.set(username, forKey: "userName")
                self.keychain.set(userid, forKey: "userID")
                self.performSegue(withIdentifier: "Start", sender: self)
            })
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailField:
            email = emailField.text!
        case passwordField:
            password = passwordField.text!
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

}
