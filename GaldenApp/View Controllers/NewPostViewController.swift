//
//  NewPostViewController.swift
//  GaldenApp
//
//  Created by 1080 on 28/9/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit
import KeychainSwift

class NewPostViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate,IconKeyboardDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //MARK: Properties
    var channel: String = ""
    var newPostTitle: String = ""
    var content: String = ""
    
    let api = HKGaldenAPI()
    let iconKeyboard = IconKeyboard(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 265))
    
    @IBOutlet weak var channelLabel: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var buttonStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        iconKeyboard.delegate = self
        titleTextField.delegate = self
        contentTextView.delegate = self
        channelLabel.setTitle(api.channelNameFunc(ch: channel), for: .normal)
        channelLabel.backgroundColor = api.channelColorFunc(ch: channel)
        titleTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        default:
            break
        }
    }*/
    
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
    
    @IBAction func fontSizeButtonPressed(_ sender: UIButton) {
        let actionsheet = UIAlertController(title:"揀大細", message: nil, preferredStyle: .alert)
        actionsheet.addAction(UIAlertAction(title:"超大",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[size=6][/size=6]")
        }))
        actionsheet.addAction(UIAlertAction(title:"特大",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[size=5][/size=5]")
        }))
        actionsheet.addAction(UIAlertAction(title:"大",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[size=4][/size=4]")
        }))
        actionsheet.addAction(UIAlertAction(title:"一般",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[size=3][/size=3]")
        }))
        actionsheet.addAction(UIAlertAction(title:"小",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[size=2][/size=2]")
        }))
        actionsheet.addAction(UIAlertAction(title:"特小",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[size=1][/size=1]")
        }))
        actionsheet.addAction(UIAlertAction(title:"冇嘢啦",style:.cancel,handler:nil))
        self.present(actionsheet,animated: true,completion: nil)
    }
    
    @IBAction func fontStyleButtonPressed(_ sender: UIButton) {
        let actionsheet = UIAlertController(title:"字體格式", message: nil, preferredStyle: .alert)
        actionsheet.addAction(UIAlertAction(title:"粗體",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[b][/b]")
        }))
        actionsheet.addAction(UIAlertAction(title:"斜體",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[i][/i]")
        }))
        actionsheet.addAction(UIAlertAction(title:"底線",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[u][/u]")
        }))
        actionsheet.addAction(UIAlertAction(title:"刪除線",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[s][/s]")
        }))
        actionsheet.addAction(UIAlertAction(title:"置左",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[left][/left]")
        }))
        actionsheet.addAction(UIAlertAction(title:"置中",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[center][/center]")
        }))
        actionsheet.addAction(UIAlertAction(title:"置右",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[right][/right]")
        }))
    }
    
    @IBAction func fontColorButtonPressed(_ sender: UIButton) {
        let actionsheet = UIAlertController(title:"揀顏色", message: nil, preferredStyle: .alert)
        actionsheet.addAction(UIAlertAction(title:"紅色",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[#ff0000][/#ff0000]")
        }))
        actionsheet.addAction(UIAlertAction(title:"橙色",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[#ffa500][/#ffa500]")
        }))
        actionsheet.addAction(UIAlertAction(title:"黃色",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[#ffff00][/#ffff00]")
        }))
        actionsheet.addAction(UIAlertAction(title:"綠色",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[#008000][/#008000]")
        }))
        actionsheet.addAction(UIAlertAction(title:"藍色",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[#0000ff][/#0000ff]")
        }))
        actionsheet.addAction(UIAlertAction(title:"靛色",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[#4b0082][/#4b0082]")
        }))
        actionsheet.addAction(UIAlertAction(title:"紫色",style:.default,handler: {
            _ in
            self.contentTextView.text.append("[#800080][/#800080]")
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
        self.contentTextView.text.append("[url][/url]")
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        newPostTitle = textField.text!
    }
    
    //MARK: UITextViewDelegate
    
    func textViewDidEndEditing(_ textView: UITextView) {
        content = textView.text!
    }
    
    //MARK: ImagePickerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        api.imageUpload(image: image, completion: {
            url in
            self.contentTextView.text.append("[img]" + url + "[/img]\n")
        })
    }
    
    func keyWasTapped(character: String) {
        contentTextView.insertText(character)
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
