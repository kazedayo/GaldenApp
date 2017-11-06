//
//  ChannelSelectViewController.swift
//  GaldenApp
//
//  Created by 1080 on 27/9/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit
import KeychainSwift

class ChannelSelectViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    var channelSelected = ""
    let cellIdentifiers: [String] = ["bw","et","ca","fn","gm","ap","it","mp","sp","lv","sy","ed","tm","tr","an","to","mu","vi","dc","st","ts","mb","ia","ac","ep"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var background: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.heroModifiers = [.cascade]
        self.titleLabel.heroModifiers = [.position(CGPoint.init(x: -100, y: titleLabel.frame.midY))]
        let keychain = KeychainSwift()
        if keychain.getData("BackgroundImage") != nil {
            background.image = UIImage.init(data: keychain.getData("BackgroundImage")!)
        }
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellIdentifiers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifiers[indexPath.item], for: indexPath)
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
