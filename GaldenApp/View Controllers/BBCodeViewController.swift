//
//  BBCodeViewController.swift
//  GaldenApp
//
//  Created by Kin Wa Lam on 8/10/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit

class BBCodeViewController: UIViewController {
    
    var bbcodeSent = ""
    var segueIdentifier = ""
    
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
