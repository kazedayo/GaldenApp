//
//  ReplyViewController.swift
//  GaldenApp
//
//  Created by Kin Wa Lam on 20/10/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var replyTextField: UITextView!
    
    var content = ""
    let api = HKGaldenAPI()
    var topicID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        replyTextField.delegate = self
        replyTextField.text = content
        replyTextField.becomeFirstResponder()
        replyTextField.textContainerInset = UIEdgeInsetsMake(20, 5, 40, 5)
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
        case "Icon":
            let destination = segue.destination as! IconViewController
            destination.segueIdentifier = "Reply"
        default:
            break
        }
    }
    

    @IBAction func submitReply(_ sender: UIButton) {
        replyTextField.endEditing(true)
        content = replyTextField.text
        //print(content)
        api.reply(topicID: topicID, content: content, completion: {
            self.performSegue(withIdentifier: "unwindAfterReply", sender: self)
        })
    }
    
    @IBAction func unwindToReply(segue: UIStoryboardSegue) {
        if (segue.source is BBCodeViewController) {
            let source = segue.source as! BBCodeViewController
            replyTextField.text = replyTextField.text.appending(source.bbcodeSent)
        }
        else if (segue.source is IconViewController) {
            let source = segue.source as! IconViewController
            replyTextField.text = replyTextField.text.appending(source.iconSelected)
        }
    }
}
