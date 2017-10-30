//
//  LeaveNameViewController.swift
//  GaldenApp
//
//  Created by Kin Wa Lam on 23/10/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit
import KeychainSwift

class LeaveNameViewController: UIViewController {
    
    @IBOutlet weak var leaveNameTextField: UITextField!
    
    let keychain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaveNameTextField.text = keychain.get("LeaveNameText")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        keychain.set(leaveNameTextField.text!, forKey: "LeaveNameText")
        performSegue(withIdentifier: "unwindToUserDetail", sender: self)
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
