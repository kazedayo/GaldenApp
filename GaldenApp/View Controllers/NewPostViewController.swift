//
//  NewPostViewController.swift
//  GaldenApp
//
//  Created by 1080 on 28/9/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit
import KeychainSwift

class NewPostViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate,IconKeyboardDelegate {
    
    //MARK: Properties
    var channel: String = ""
    var newPostTitle: String = ""
    var content: String = ""
    
    let api = HKGaldenAPI()
    let iconKeyboard = IconKeyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 265))
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var channelLabel: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var newPostStack: UIStackView!
    @IBOutlet weak var background: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        iconKeyboard.delegate = self
        titleTextField.delegate = self
        contentTextView.delegate = self
        titleLabel.heroModifiers = [.position(CGPoint.init(x: -100, y: titleLabel.frame.midY))]
        channelLabel.heroModifiers = [.position(CGPoint.init(x: channelLabel.frame.midX, y: -100))]
        cancelButton.heroModifiers = [.position(CGPoint.init(x: 500, y: cancelButton.frame.midY))]
        newPostStack.heroModifiers = [.fade,.position(CGPoint.init(x: newPostStack.frame.midX, y: 500))]
        channelLabel.setTitle(api.channelNameFunc(ch: channel), for: .normal)
        channelLabel.backgroundColor = api.channelColorFunc(ch: channel)
        let keychain = KeychainSwift()
        if keychain.getData("BackgroundImage") != nil {
            background.image = UIImage.init(data: keychain.getData("BackgroundImage")!)
        }
        titleTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        case "BBCode":
            let destination = segue.destination as! BBCodeViewController
            destination.segueIdentifier = "NewPost"
        default:
            break
        }
    }
    
    //MARK: Actions
    @IBAction func submitNewPost(_ sender: UIButton) {
        titleTextField.endEditing(true)
        contentTextView.endEditing(true)
        if (titleTextField.text == "" || contentTextView.text == "") {
            let alert = UIAlertController(title:"喂喂喂",message:"唔好開bug post #ng#",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK",style:.cancel,handler:nil))
            present(alert,animated: true,completion: nil)
        } else {
            title = titleTextField.text
            content = contentTextView.text
            api.submitPost(channel: channel, title: newPostTitle, content: content, completion: {
                self.performSegue(withIdentifier: "unwindToThreadListAfterNewPost", sender: self)
            })
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        titleTextField.resignFirstResponder()
        contentTextView.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        newPostTitle = textField.text!
    }
    
    //MARK: UITextViewDelegate
    
    func textViewDidEndEditing(_ textView: UITextView) {
        content = textView.text!
    }
    
    func keyWasTapped(character: String) {
        contentTextView.insertText(character)
    }
    
    @IBAction func unwindToNewPost(segue: UIStoryboardSegue) {
        if (segue.source is BBCodeViewController) {
            let source = segue.source as! BBCodeViewController
            contentTextView.text = contentTextView.text.appending(source.bbcodeSent)
        }
    }
    
    @IBAction func callIconKeyboard(_ sender: UIButton) {
        if contentTextView.inputView == nil {
            contentTextView.resignFirstResponder()
            contentTextView.inputView = iconKeyboard
            contentTextView.becomeFirstResponder()
        } else {
            contentTextView.resignFirstResponder()
            contentTextView.inputView = nil
            contentTextView.becomeFirstResponder()
        }
    }
    
}
