//
//  ChannelSelectViewController.swift
//  GaldenApp
//
//  Created by 1080 on 27/9/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit

class ChannelSelectViewController: UIViewController {
    
    var channelSelected = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectChannel(_ sender: UIButton) {
        switch (sender.tag) {
        case 0:
            channelSelected = "bw"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 1:
            channelSelected = "et"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 2:
            channelSelected = "ca"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 3:
            channelSelected = "fn"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 4:
            channelSelected = "gm"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 5:
            channelSelected = "ap"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 6:
            channelSelected = "it"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 7:
            channelSelected = "mp"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 8:
            channelSelected = "sp"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 9:
            channelSelected = "lv"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 10:
            channelSelected = "sy"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 11:
            channelSelected = "ed"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 12:
            channelSelected = "tm"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 13:
            channelSelected = "tr"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 14:
            channelSelected = "an"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 15:
            channelSelected = "to"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 16:
            channelSelected = "mu"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 17:
            channelSelected = "vi"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 18:
            channelSelected = "dc"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 19:
            channelSelected = "st"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 20:
            channelSelected = "ts"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 21:
            channelSelected = "mb"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 22:
            channelSelected = "ia"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 23:
            channelSelected = "ac"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        case 24:
            channelSelected = "ep"
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
        default:
            self.performSegue(withIdentifier: "unwindToThreadList", sender: self)
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
