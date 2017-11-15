//
//  ReplyViewController.swift
//  GaldenApp
//
//  Created by Kin Wa Lam on 20/10/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit
import KeychainSwift

class ReplyViewController: UIViewController,UITextViewDelegate,IconKeyboardDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var replyTextField: UITextView!
    @IBOutlet weak var buttonStack: UIStackView!
    
    var content = ""
    let api = HKGaldenAPI()
    var topicID = ""
    
    let iconKeyboard = IconKeyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 265))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        replyTextField.delegate = self
        iconKeyboard.delegate = self
        replyTextField.text = content
        replyTextField.becomeFirstResponder()
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
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch (segue.identifier ?? "") {
        case "BBCode":
            let destination = segue.destination as! BBCodeViewController
            destination.segueIdentifier = "Reply"
        default:
            break
        }
    }*/
    

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
    
    @IBAction func fontSizeButtonPressed(_ sender: UIButton) {
        let actionsheet = UIAlertController(title:"揀大細", message: nil, preferredStyle: .alert)
        actionsheet.addAction(UIAlertAction(title:"超大",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[size=6][/size=6]")
        }))
        actionsheet.addAction(UIAlertAction(title:"特大",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[size=5][/size=5]")
        }))
        actionsheet.addAction(UIAlertAction(title:"大",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[size=4][/size=4]")
        }))
        actionsheet.addAction(UIAlertAction(title:"一般",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[size=3][/size=3]")
        }))
        actionsheet.addAction(UIAlertAction(title:"小",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[size=2][/size=2]")
        }))
        actionsheet.addAction(UIAlertAction(title:"特小",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[size=1][/size=1]")
        }))
        actionsheet.addAction(UIAlertAction(title:"冇嘢啦",style:.cancel,handler:nil))
        self.present(actionsheet,animated: true,completion: nil)
    }
    
    @IBAction func fontStyleButtonPressed(_ sender: UIButton) {
        let actionsheet = UIAlertController(title:"字體格式", message: nil, preferredStyle: .alert)
        actionsheet.addAction(UIAlertAction(title:"粗體",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[b][/b]")
        }))
        actionsheet.addAction(UIAlertAction(title:"斜體",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[i][/i]")
        }))
        actionsheet.addAction(UIAlertAction(title:"底線",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[u][/u]")
        }))
        actionsheet.addAction(UIAlertAction(title:"刪除線",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[s][/s]")
        }))
        actionsheet.addAction(UIAlertAction(title:"置左",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[left][/left]")
        }))
        actionsheet.addAction(UIAlertAction(title:"置中",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[center][/center]")
        }))
        actionsheet.addAction(UIAlertAction(title:"置右",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[right][/right]")
        }))
    }
    
    @IBAction func fontColorButtonPressed(_ sender: UIButton) {
        let actionsheet = UIAlertController(title:"揀顏色", message: nil, preferredStyle: .alert)
        actionsheet.addAction(UIAlertAction(title:"紅色",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[#ff0000][/#ff0000]")
        }))
        actionsheet.addAction(UIAlertAction(title:"橙色",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[#ffa500][/#ffa500]")
        }))
        actionsheet.addAction(UIAlertAction(title:"黃色",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[#ffff00][/#ffff00]")
        }))
        actionsheet.addAction(UIAlertAction(title:"綠色",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[#008000][/#008000]")
        }))
        actionsheet.addAction(UIAlertAction(title:"藍色",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[#0000ff][/#0000ff]")
        }))
        actionsheet.addAction(UIAlertAction(title:"靛色",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[#4b0082][/#4b0082]")
        }))
        actionsheet.addAction(UIAlertAction(title:"紫色",style:.default,handler: {
            _ in
            self.replyTextField.text.append("[#800080][/#800080]")
        }))
        actionsheet.addAction(UIAlertAction(title:"冇嘢啦",style:.cancel,handler:nil))
        present(actionsheet,animated: true,completion: nil)
    }
    
    @IBAction func imageButtonPressed(_ sender: UIButton) {
        let actionsheet = UIAlertController(title:"噏圖(powered by eService-HK)",message:"你想...",preferredStyle:.alert)
        actionsheet.addAction(UIAlertAction(title:"影相",style:.default,handler: {
            _ in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            self.present(imagePicker,animated: true,completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title:"揀相",style:.default,handler: {
            _ in
            let imagePicker = UIImagePickerController()
            imagePicker.navigationBar.tintColor = .darkGray
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker,animated: true,completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title:"冇嘢啦",style:.cancel,handler:nil))
        present(actionsheet,animated: true,completion: nil)
    }
    
    @IBAction func urlButtonPressed(_ sender: UIButton) {
        self.replyTextField.text.append("[url][/url]")
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
