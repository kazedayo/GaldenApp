//
//  BBCodeViewController.swift
//  GaldenApp
//
//  Created by Kin Wa Lam on 8/10/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit

class BBCodeViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var bbcodeSent = ""
    var segueIdentifier = ""
    
    let api = HKGaldenAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    @IBAction func imageButtonPressed(_ sender: UIButton) {
        let actionsheet = UIAlertController(title:"噏圖(powered by eService-HK)",message:"你想...",preferredStyle:.actionSheet)
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
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker,animated: true,completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title:"冇嘢啦",style:.cancel,handler:nil))
        present(actionsheet,animated: true,completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        api.imageUpload(image: image, completion: {
            url in
            self.bbcodeSent = "[img]" + url + "[/img]\n"
            if (self.segueIdentifier == "Reply") {
                self.performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (self.segueIdentifier == "NewPost") {
                self.performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        })
    }
    
    @IBAction func colorButtonPressed(_ sender: UIButton) {
        let actionsheet = UIAlertController(title:"揀顏色", message: nil, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title:"紅色",style:.default,handler: {
            action in
            self.bbcodeSent = "[#ff0000][/#ff0000]"
            if (self.segueIdentifier == "Reply") {
                self.performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (self.segueIdentifier == "NewPost") {
                self.performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        }))
        actionsheet.addAction(UIAlertAction(title:"橙色",style:.default,handler: {
            action in
            self.bbcodeSent = "[#ffa500][/#ffa500]"
            if (self.segueIdentifier == "Reply") {
                self.performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (self.segueIdentifier == "NewPost") {
                self.performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        }))
        actionsheet.addAction(UIAlertAction(title:"黃色",style:.default,handler: {
            action in
            self.bbcodeSent = "[#ffff00][/#ffff00]"
            if (self.segueIdentifier == "Reply") {
                self.performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (self.segueIdentifier == "NewPost") {
                self.performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        }))
        actionsheet.addAction(UIAlertAction(title:"綠色",style:.default,handler: {
            action in
            self.bbcodeSent = "[#008000][/#008000]"
            if (self.segueIdentifier == "Reply") {
                self.performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (self.segueIdentifier == "NewPost") {
                self.performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        }))
        actionsheet.addAction(UIAlertAction(title:"藍色",style:.default,handler: {
            action in
            self.bbcodeSent = "[#0000ff][/#0000ff]"
            if (self.segueIdentifier == "Reply") {
                self.performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (self.segueIdentifier == "NewPost") {
                self.performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        }))
        actionsheet.addAction(UIAlertAction(title:"靛色",style:.default,handler: {
            action in
            self.bbcodeSent = "[#4b0082][/#4b0082]"
            if (self.segueIdentifier == "Reply") {
                self.performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (self.segueIdentifier == "NewPost") {
                self.performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        }))
        actionsheet.addAction(UIAlertAction(title:"紫色",style:.default,handler: {
            action in
            self.bbcodeSent = "[#800080][/#800080]"
            if (self.segueIdentifier == "Reply") {
                self.performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (self.segueIdentifier == "NewPost") {
                self.performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        }))
        actionsheet.addAction(UIAlertAction(title:"冇嘢啦",style:.cancel,handler:nil))
        self.present(actionsheet,animated: true,completion: nil)
    }
    
    @IBAction func sizeButtonPressed(_ sender: UIButton) {
        let actionsheet = UIAlertController(title:"揀大細", message: nil, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title:"超大",style:.default,handler: {
            action in
            self.bbcodeSent = "[size=6][/size=6]"
            if (self.segueIdentifier == "Reply") {
                self.performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (self.segueIdentifier == "NewPost") {
                self.performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        }))
        actionsheet.addAction(UIAlertAction(title:"特大",style:.default,handler: {
            action in
            self.bbcodeSent = "[size=5][/size=5]"
            if (self.segueIdentifier == "Reply") {
                self.performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (self.segueIdentifier == "NewPost") {
                self.performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        }))
        actionsheet.addAction(UIAlertAction(title:"大",style:.default,handler: {
            action in
            self.bbcodeSent = "[size=4][/size=4]"
            if (self.segueIdentifier == "Reply") {
                self.performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (self.segueIdentifier == "NewPost") {
                self.performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        }))
        actionsheet.addAction(UIAlertAction(title:"一般",style:.default,handler: {
            action in
            self.bbcodeSent = "[size=3][/size=3]"
            if (self.segueIdentifier == "Reply") {
                self.performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (self.segueIdentifier == "NewPost") {
                self.performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        }))
        actionsheet.addAction(UIAlertAction(title:"小",style:.default,handler: {
            action in
            self.bbcodeSent = "[size=2][/size=2]"
            if (self.segueIdentifier == "Reply") {
                self.performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (self.segueIdentifier == "NewPost") {
                self.performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        }))
        actionsheet.addAction(UIAlertAction(title:"特小",style:.default,handler: {
            action in
            self.bbcodeSent = "[size=1][/size=1]"
            if (self.segueIdentifier == "Reply") {
                self.performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (self.segueIdentifier == "NewPost") {
                self.performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        }))
        actionsheet.addAction(UIAlertAction(title:"冇嘢啦",style:.cancel,handler:nil))
        self.present(actionsheet,animated: true,completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        if (segueIdentifier == "Reply") {
            performSegue(withIdentifier: "unwindToReply", sender: self)
        } else if (segueIdentifier == "NewPost") {
            performSegue(withIdentifier: "unwindToNewPost", sender: self)
        }
    }
    
    @IBAction func bbcodeButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            bbcodeSent = "[b][/b]"
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 1:
            bbcodeSent = "[i][/i]"
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 2:
            bbcodeSent = "[u][/u]"
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 3:
            bbcodeSent = "[s][/s]"
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 4:
            bbcodeSent = "[left][/left]"
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 5:
            bbcodeSent = "[center][/center]"
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 6:
            bbcodeSent = "[right][/right]"
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 7:
            bbcodeSent = "[quote][/quote]"
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 9:
            bbcodeSent = "[url][/url]"
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 10:
            bbcodeSent = "[list]\n[*]第一項\n[*]第二項\n[*]第三項\n[/list]"
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        case 11:
            bbcodeSent = "[hide][/hide]"
            if (segueIdentifier == "Reply") {
                performSegue(withIdentifier: "unwindToReply", sender: self)
            } else if (segueIdentifier == "NewPost") {
                performSegue(withIdentifier: "unwindToNewPost", sender: self)
            }
        default:
            break
        }
    }
    
}
