//
//  ThreadListViewController.swift
//  
//
//  Created by Kin Wa Lam on 7/10/2017.
//

import UIKit
import KeychainSwift
import ESPullToRefresh
import Toaster

class ThreadListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var threadListTableView: UITableView!
    @IBOutlet weak var NewThreadButton: UIBarButtonItem!
    
    //HKGaldenAPI.swift required (NOT included in GitHub repo)
    let api: HKGaldenAPI = HKGaldenAPI()
    
    //MARK: Properties
    var threads = [ThreadList]()
    var channelNow: String?
    var pageNow: String?
    var selectedThread: String!
    var blockedUsers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.navigationController?.navigationBar.isHeroEnabled = true
        self.navigationController?.navigationBar.heroModifiers = [.position(CGPoint.init(x: (self.navigationController?.navigationBar.frame.midX)!, y: -100))]
        threadListTableView.delegate = self
        threadListTableView.dataSource = self
        
        self.threadListTableView.es.addPullToRefresh {
            [unowned self] in
            self.pageNow = "1"
            self.api.fetchThreadList(currentChannel: self.channelNow!, pageNumber: self.pageNow!, completion: {
                [weak self] threads,blocked,error in
                if (error == nil) {
                    self?.threads = threads
                    self?.blockedUsers = blocked
                    self?.threadListTableView.reloadData()
                    self?.threadListTableView.es.stopPullToRefresh()
                }
            })
        }

        self.threadListTableView.es.addInfiniteScrolling {
            [unowned self] in
            self.pageNow = String(Int(self.pageNow!)! + 1)
            self.api.fetchThreadList(currentChannel: self.channelNow!, pageNumber: self.pageNow!, completion: {
                [weak self] threads,blocked,error in
                if (error == nil) {
                    self?.threads.append(contentsOf: threads)
                    self?.blockedUsers = blocked
                    self?.threadListTableView.reloadData()
                    self?.threadListTableView.es.stopLoadingMore()
                }
            })
        }
        
        threadListTableView.isHidden = true
        channelNow = "bw"
        pageNow = "1"
        self.navigationItem.title = api.channelNameFunc(ch: channelNow!)
        Toast(text:"撈緊...",duration:1).show()
        api.fetchThreadList(currentChannel: channelNow!, pageNumber: pageNow!, completion: {
            [weak self] threads,blocked,error in
            if (error == nil) {
                self?.threads = threads
                self?.blockedUsers = blocked
                self?.threadListTableView.reloadData()
                self?.threadListTableView.isHidden = false
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return threads.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThreadListTableViewCell", for: indexPath) as! ThreadListTableViewCell
        
        // Configure the cell...
        if (blockedUsers.contains(threads[indexPath.row].userID)) {
            cell.threadTitleLabel.text = "[已封鎖]"
            cell.threadTitleLabel.textColor = .gray
            cell.detailLabel.text = "//unknown identity//"
        } else {
            cell.threadTitleLabel.text = threads[indexPath.row].title
            cell.threadTitleLabel.textColor = .darkGray
            cell.detailLabel.text = threads[indexPath.row].userName + "  " + "回覆:" + threads[indexPath.row].count + "  " + "評分:" + threads[indexPath.row].rate
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (blockedUsers.contains(threads[indexPath.row].userID)) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title:"喂喂喂",message:"扑咗就唔好心郁郁",preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"好囉",style:.cancel,handler:nil))
                self.present(alert,animated: true,completion: nil)
            }
        } else {
            let cell = tableView.cellForRow(at: indexPath)
            self.performSegue(withIdentifier: "GoToPost", sender: cell)
        }
    }
    
    /*func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.heroID = ""
        cell?.heroModifiers = []
    }*/
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "SwitchChannel":
            print("Switching Channel")
        case "GoToPost":
            guard let contentViewController = segue.destination as? ContentViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            if (sender is ThreadListTableViewCell) {
                let selectedThreadCell = sender as? ThreadListTableViewCell
                let indexPath = threadListTableView.indexPath(for: selectedThreadCell!)
                let selectedThread = threads[(indexPath?.row)!].id
                contentViewController.threadIdReceived = selectedThread
                contentViewController.title = threads[(indexPath?.row)!].title
                contentViewController.goToLastPage = false
            }
            else if (sender is IndexPath) {
                let selectedThreadCell = sender as? IndexPath
                let indexPath = selectedThreadCell?.row
                let selectedThread = threads[indexPath!].id
                contentViewController.threadIdReceived = selectedThread
                contentViewController.title = threads[indexPath!].title
                contentViewController.goToLastPage = true
            }
            
        case "StartNewPost":
            let destination = segue.destination as! NewPostViewController
            destination.channel = channelNow!
            destination.modalPresentationStyle = .popover
            destination.popoverPresentationController?.delegate = self
        case "UserDetail" :
            print("Show User Detail")
        default:
            break
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    @IBAction func tapOnChannelTitle(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "SwitchChannel", sender: self)
    }
    
    //Unwind Segue
    @IBAction func unwindToThreadList(segue: UIStoryboardSegue) {
        let channelSelectViewController = segue.source as! ChannelSelectViewController
        self.channelNow = channelSelectViewController.channelSelected
        self.pageNow = "1"
        threadListTableView.isHidden = true
        self.navigationItem.title = api.channelNameFunc(ch: channelNow!)
        Toast(text:"撈緊...",duration:1).show()
        api.fetchThreadList(currentChannel: channelNow!, pageNumber: pageNow!, completion: {
            [weak self] threads,blocked,error in
            if (error == nil) {
                self?.threads = threads
                self?.blockedUsers = blocked
                self?.threadListTableView.reloadData()
                self?.threadListTableView.isHidden = false
            }
        })
    }
    
    @IBAction func unwindToThreadListFromContent(segue: UIStoryboardSegue) {
        let source = segue.source as! ContentViewController
        self.blockedUsers = source.blockedUsers
        self.threadListTableView.reloadData()
    }
    
    @IBAction func unwindToThreadListAfterNewPost(segue: UIStoryboardSegue) {
        threadListTableView.isHidden = true
        api.fetchThreadList(currentChannel: channelNow!, pageNumber: pageNow!, completion: {
            [weak self] threads,blocked,error in
            if (error == nil) {
                self?.threads = threads
                self?.blockedUsers = blocked
                self?.threadListTableView.reloadData()
                self?.threadListTableView.isHidden = false
            }
        })
    }
}
