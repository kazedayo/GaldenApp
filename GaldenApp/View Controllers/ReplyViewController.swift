//
//  ReplyViewController.swift
//  GaldenApp
//
//  Created by Kin Wa Lam on 20/10/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit
import KeychainSwift

class ReplyViewController: UIViewController,UITextViewDelegate,IconKeyboardDelegate {

    @IBOutlet weak var replyTextField: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var backgroundView: UIImageView!
    
    var content = ""
    let api = HKGaldenAPI()
    var topicID = ""
    
    let iconKeyboard = IconKeyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 265))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let keychain = KeychainSwift()
        if keychain.getData("BackgroundImage") != nil {
            backgroundView.image = UIImage.init(data: keychain.getData("BackgroundImage")!)
        }
        replyTextField.delegate = self
        iconKeyboard.delegate = self
        replyTextField.text = content
        replyTextField.becomeFirstResponder()
        replyTextField.textContainerInset = UIEdgeInsetsMake(10, 5, 10, 5)
        cancelButton.heroModifiers = [.fade, .position(CGPoint.init(x: 250, y: cancelButton.frame.midY))]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        content = textView.text
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch (segue.identifier ?? "") {
        case "BBCode":
            let destination = segue.destination as! BBCodeViewController
            destination.segueIdentifier = "Reply"
        default:
            break
        }
    }
    

    @IBAction func submitReply(_ sender: UIButton) {
        replyTextField.endEditing(true)
        if replyTextField.text == "" {
            let alert = UIAlertController(title:"喂喂喂",message:"你未打字喎:o)",preferredStyle:.alert)
            alert.addAction(UIAlertAction(title:"OK",style:.cancel,handler:nil))
            present(alert,animated: true,completion: nil)
        } else {
            content = replyTextField.text
            api.reply(topicID: topicID, content: content, completion: {
                self.performSegue(withIdentifier: "unwindAfterReply", sender: self)
            })
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        replyTextField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToReply(segue: UIStoryboardSegue) {
        if (segue.source is BBCodeViewController) {
            let source = segue.source as! BBCodeViewController
            replyTextField.text = replyTextField.text.appending(source.bbcodeSent)
        }
    }
    
    func keyWasTapped(character: String) {
        replyTextField.insertText(character)
    }
    
    @IBAction func callIconKeyboard(_ sender: UIButton) {
        if replyTextField.inputView == nil {
            replyTextField.resignFirstResponder()
            replyTextField.inputView = iconKeyboard
            replyTextField.becomeFirstResponder()
        } else {
            replyTextField.resignFirstResponder()
            replyTextField.inputView = nil
            replyTextField.becomeFirstResponder()
        }
    }
}
