//
//  NewPostViewController.swift
//  GaldenApp
//
//  Created by 1080 on 28/9/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPopoverPresentationControllerDelegate {
    
    //MARK: Properties
    var channel: String = ""
    var newPostTitle: String = ""
    var content: String = ""
    
    let api = HKGaldenAPI()
    
    @IBOutlet weak var channelLabel: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleTextField.delegate = self
        contentTextView.delegate = self
        modalPresentationCapturesStatusBarAppearance = true
        channelLabel.setTitle(api.channelNameFunc(ch: channel), for: .normal)
        channelLabel.backgroundColor = api.channelColorFunc(ch: channel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissNewPost(_ sender: UIButton) {
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        case "ChannelSelect":
            let popoverViewController = segue.destination as! ChannelSelectViewController
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            popoverViewController.popoverPresentationController!.delegate = self
        case "BBCode":
            let destination = segue.destination as! BBCodeViewController
            destination.segueIdentifier = "NewPost"
        case "Icon":
            let destination = segue.destination as! IconViewController
            destination.segueIdentifier = "NewPost"
        default:
            break
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
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
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        newPostTitle = textField.text!
    }
    
    //MARK: UITextViewDelegate
    
    func textViewDidEndEditing(_ textView: UITextView) {
        content = textView.text!
    }
    
    @IBAction func unwindToNewPost(segue: UIStoryboardSegue) {
        if (segue.source is BBCodeViewController) {
            let source = segue.source as! BBCodeViewController
            contentTextView.text = contentTextView.text.appending(source.bbcodeSent)
        }
        else if (segue.source is IconViewController) {
            let source = segue.source as! IconViewController
            contentTextView.text = contentTextView.text.appending(source.iconSelected)
        }
    }
    
}
