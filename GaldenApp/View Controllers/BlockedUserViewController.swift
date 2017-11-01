//
//  BlockedUserViewController.swift
//  GaldenApp
//
//  Created by Kin Wa Lam on 28/10/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit
import DeckTransition

class BlockedUserViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var blockListTableView: UITableView!
    
    var blockedUsers = [BlockedUsers]()
    
    let api = HKGaldenAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blockListTableView.dataSource = self
        blockListTableView.delegate = self
        api.getBlockedUsers(completion: {
            blocked in
            self.blockedUsers = blocked
            self.blockListTableView.reloadData()
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blockedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlockedUserTableViewCell") as! BlockedUserTableViewCell
        
        cell.userLabel.text = blockedUsers[indexPath.row].userName
        cell.idLabel.text = "UID: " + blockedUsers[indexPath.row].id
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.isEqual(blockListTableView) else {
            return
        }
        
        if let delegate = transitioningDelegate as? DeckTransitioningDelegate {
            if scrollView.contentOffset.y > 0 {
                // Normal behaviour if the `scrollView` isn't scrolled to the top
                scrollView.bounces = true
                delegate.isDismissEnabled = false
            } else {
                if scrollView.isDecelerating {
                    // If the `scrollView` is scrolled to the top but is decelerating
                    // that means a swipe has been performed. The view and
                    // scrollviewʼs subviews are both translated in response to this.
                    view.transform = CGAffineTransform(translationX: 0, y: -scrollView.contentOffset.y)
                    /*scrollView.subviews.forEach {
                        $0.transform = CGAffineTransform(translationX: 0, y: scrollView.contentOffset.y)
                    }*/
                } else {
                    // If the user has panned to the top, the scrollview doesnʼt bounce and
                    // the dismiss gesture is enabled.
                    scrollView.bounces = false
                    delegate.isDismissEnabled = true
                }
            }
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
