//
//  ContentViewController.swift
//  GaldenApp
//
//  Created by Kin Wa Lam on 2/10/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit
import JavaScriptCore
import KeychainSwift
import MarqueeLabel
import Toaster

class ContentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate,UINavigationControllerDelegate {
    
    //MARK: Properties
    
    var threadIdReceived: String = ""
    var goToLastPage: Bool = false
    var isRated: String = ""
    var pageNow: Int = 1
    var convertedText: String = ""
    var op = OP(t: "",n: "",l: "",c: "",cA: NSAttributedString(),a: "",d: "",gd: "",b: "",ge: "",ch: "",qid:"",uid:"")
    var comments = [Replies]()
    var replyCount = 1
    var pageCount = 0.0
    var quoteContent = ""
    var blockedUsers = [String]()
    
    let f5view = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 70))
    
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var pageButton: UIBarButtonItem!
    @IBOutlet weak var goodCount: UIBarButtonItem!
    @IBOutlet weak var badCount: UIBarButtonItem!
    @IBOutlet weak var prevButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var goodButton: UIBarButtonItem!
    @IBOutlet weak var badButton: UIBarButtonItem!
    @IBOutlet weak var leaveNameButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    
    //HKGalden API (NOT included in GitHub repo)
    var api = HKGaldenAPI()
    let keychain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeJS()
        contentTableView.delegate = self
        contentTableView.dataSource = self
        navigationController?.delegate = self
        
        let title = MarqueeLabel.init()
        title.text = self.title
        title.animationDelay = 1
        title.marqueeType = .MLLeftRight
        title.fadeLength = 5
        navigationItem.titleView = title
        
        f5view.setImage(UIImage(named: "F5"), for: .normal)
        f5view.addTarget(self, action: #selector(f5Button(_:)), for: .touchUpInside)
        
        self.prevButton.isEnabled = false
        self.nextButton.isEnabled = false
        
        self.contentTableView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(ContentViewController.handleBBCodeToHTMLNotification(notification:)), name: NSNotification.Name("bbcodeToHTMLNotification"), object: nil)
        
        if keychain.get("LeaveNameText") == nil {
            leaveNameButton.isEnabled = false
        }
        
        self.api.pageCount(postId: threadIdReceived, completion: {
            [weak self] count in
            self?.pageCount = count
            if (self?.pageNow == Int((self?.pageCount)!)) {
                self?.nextButton.isEnabled = false
            }
            else {
                self?.nextButton.isEnabled = true
            }
            self?.updateSequence(action: "init")
        })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.contentTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (pageNow == 1) {
            return (comments.count) + 1
        }
        else {
            return comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell", for: indexPath) as! ContentTableViewCell
        
        if (pageNow == 1) {
            if(indexPath.row == 0) {
                if (blockedUsers.contains(op.userID)) {
                    cell.userAvatarImageView.image = UIImage(named: "block")
                    cell.userNameLabel.text = "//XXX//"
                    cell.userNameLabel.textColor = .gray
                    cell.userLevelLabel.text = "???"
                    cell.replyCountLabel.text = ""
                    cell.dateLabel.text = ""
                    cell.contentTextView.attributedText = NSAttributedString.init(string: "[已封鎖]", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
                    cell.quoteButton.isEnabled = false
                    cell.blockButton.isEnabled = false
                    cell.reportButton.isEnabled = false
                } else {
                    cell.configureOP(opData: op)
                }
            }
            else {
                if (blockedUsers.contains(comments[indexPath.row - 1].userID)) {
                    cell.userAvatarImageView.image = UIImage(named: "block")
                    cell.userNameLabel.text = "//XXX//"
                    cell.userNameLabel.textColor = .gray
                    cell.userLevelLabel.text = "???"
                    cell.replyCountLabel.text = ""
                    cell.dateLabel.text = ""
                    cell.contentTextView.attributedText = NSAttributedString.init(string: "[已封鎖]", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
                    cell.quoteButton.isEnabled = false
                    cell.blockButton.isEnabled = false
                    cell.reportButton.isEnabled = false
                } else {
                    cell.configureReplyFirstPage(comments: comments, indexPath: indexPath,pageNow: pageNow)
                }
            }
        }
        else {
            if (blockedUsers.contains(comments[indexPath.row].userID)) {
                cell.userAvatarImageView.image = UIImage(named: "block")
                cell.userNameLabel.text = "//XXX//"
                cell.userNameLabel.textColor = .gray
                cell.userLevelLabel.text = "???"
                cell.replyCountLabel.text = ""
                cell.dateLabel.text = ""
                cell.contentTextView.attributedText = NSAttributedString.init(string: "[已封鎖]", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
                cell.quoteButton.isEnabled = false
                cell.blockButton.isEnabled = false
                cell.reportButton.isEnabled = false
            } else {
                cell.configureReply(comments: comments, indexPath: indexPath, pageNow: pageNow)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @objc func f5Button(_ sender: UIButton) {
        contentTableView.isHidden = true
        self.api.pageCount(postId: threadIdReceived, completion: {
            [weak self] count in
            self?.pageCount = count
            if (self?.pageNow == Int((self?.pageCount)!)) {
                self?.nextButton.isEnabled = false
            }
            else {
                self?.nextButton.isEnabled = true
            }
            self?.updateSequence(action: "f5")
        })
    }
    
    @IBAction func quoteButtonPressed(_ sender: UIButton) {
        let indexPath = IndexPath.init(row: sender.tag, section: 0)
            if (pageNow == 1 && indexPath.row == 0) {
            self.api.quote(quoteType: "t", quoteID: self.op.quoteID, completion: {
                content in
                self.quoteContent = content
                self.performSegue(withIdentifier: "quote", sender: self)
            })
            } else if pageNow == 1 {
                self.api.quote(quoteType: "r", quoteID: self.comments[(indexPath.row) - 1].quoteID, completion: {
                    content in
                    self.quoteContent = content
                    self.performSegue(withIdentifier: "quote", sender: self)
                })
            } else {
                self.api.quote(quoteType: "r", quoteID: self.comments[(indexPath.row)].quoteID, completion: {
                    content in
                    self.quoteContent = content
                    self.performSegue(withIdentifier: "quote", sender: self)
                })
        }
    }
    
    @IBAction func blockButtonPressed(_ sender: UIButton) {
        let indexPath = IndexPath.init(row: sender.tag, section: 0)
        if (pageNow == 1 && indexPath.row == 0) {
            self.api.blockUser(uid: self.op.userID, completion: {
                status in
                if status == "true" {
                    self.blockedUsers.append(self.op.userID)
                    self.contentTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                }
            })
        } else if pageNow == 1 {
            self.api.blockUser(uid: self.comments[indexPath.row - 1].userID, completion: {
                status in
                if status == "true" {
                    self.blockedUsers.append(self.comments[indexPath.row - 1].userID)
                    self.contentTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                }
            })
        } else {
            self.api.blockUser(uid: self.comments[(indexPath.row)].userID, completion: {
                status in
                if status == "true" {
                    self.blockedUsers.append(self.comments[(indexPath.row)].userID)
                    self.contentTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                }
            })
        }
    }
    
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
        switch segue.identifier {
        case "pageSelect"?:
            let popoverViewController = segue.destination as! PageSelectTableViewController
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            popoverViewController.popoverPresentationController!.delegate = self
            popoverViewController.pageCount = self.pageCount
        case "WriteReply"?:
            let destination = segue.destination as! ReplyViewController
            destination.topicID = self.threadIdReceived
            destination.modalPresentationStyle = .popover
            destination.popoverPresentationController?.delegate = self
        case "quote"?:
            let destination = segue.destination as! ReplyViewController
            destination.topicID = self.threadIdReceived
            destination.content = self.quoteContent + "\n"
            destination.modalPresentationStyle = .popover
            destination.popoverPresentationController?.delegate = self
        default:
            break
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    @IBAction func changePage(_ sender: UIBarButtonItem) {
        switch (sender.tag) {
        case 0:
            nextButton.isEnabled = true
            if (pageNow - 2 == 0) {
                prevButton.isEnabled = false
            }
            contentTableView.isHidden = true
            self.pageNow -= 1
            self.api.pageCount(postId: threadIdReceived, completion: {
                [weak self] count in
                self?.pageCount = count
                if (self?.pageNow == Int((self?.pageCount)!)) {
                    self?.nextButton.isEnabled = false
                }
                else {
                    self?.nextButton.isEnabled = true
                }
                self?.updateSequence(action: "prevPage")
            })
        case 1:
            if(pageNow + 1 == Int(pageCount)) {
                nextButton.isEnabled = false
            }
            self.prevButton.isEnabled = true
            contentTableView.isHidden = true
            self.pageNow += 1
            self.api.pageCount(postId: threadIdReceived, completion: {
                [weak self] count in
                self?.pageCount = count
                if (self?.pageNow == Int((self?.pageCount)!)) {
                    self?.nextButton.isEnabled = false
                }
                else {
                    self?.nextButton.isEnabled = true
                }
                self?.updateSequence(action: "nextPage")
            })
        default:
            print("nothing")
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToThreadListFromContent", sender: self)
    }
    
    @IBAction func unwindToPage(segue: UIStoryboardSegue) {
        let pageSelectViewController = segue.source as! PageSelectTableViewController
        self.pageNow = pageSelectViewController.pageSelected
        self.api.pageCount(postId: threadIdReceived, completion: {
            [weak self] count in
            self?.pageCount = count
            if (self?.pageNow == Int((self?.pageCount)!)) {
                self?.nextButton.isEnabled = false
            }
            else {
                self?.nextButton.isEnabled = true
            }
            self?.updateSequence(action: "nextPage")
        })
    }
    
    @IBAction func unwindAfterReply(segue: UIStoryboardSegue) {
        self.pageNow = Int(pageCount)
        self.api.pageCount(postId: threadIdReceived, completion: {
            [weak self] count in
            self?.pageCount = count
            if (self?.pageNow == Int((self?.pageCount)!)) {
                self?.nextButton.isEnabled = false
            }
            else {
                self?.nextButton.isEnabled = true
            }
            self?.updateSequence(action: "f5")
        })
    }
    
    @IBAction func goodButtonTapped(_ sender: UIBarButtonItem) {
        api.rate(threadID: threadIdReceived, rate: "g", completion: {
            self.updateSequence(action: "init")
        })
    }
    
    @IBAction func badButtonTapped(_ sender: UIBarButtonItem) {
        api.rate(threadID: threadIdReceived, rate: "b", completion: {
            self.updateSequence(action: "init")
        })
    }
    
    @IBAction func reportButtonPressed(_ sender: UIButton) {
        Toast(text:"已傳送舉報",duration:1).show()
    }
    
    //MARK: Private Functions
    
    private func updateSequence(action: String) {
        contentTableView.isHidden = true
        if (goToLastPage == true) {
            pageNow = Int(pageCount)
            goToLastPage = false
        }
        buttonLogic()
        self.pageButton.title = "第" + String(self.pageNow) + "頁"
        Toast(text:"撈緊...",duration:1).show()
        self.api.fetchContent(postId: threadIdReceived, pageNo: String(pageNow), completion: {
            [weak self] op,comments,rated,blocked,error in
            if (error == nil) {
                self?.op = op
                self?.comments = comments
                self?.blockedUsers = blocked
                self?.isRated = rated
                self?.convertBBCodeToHTML(text: (self?.op.content)!)
                self?.op.contentAttr = (self?.convertedText)!.data.attributedString!
                for index in 0..<(self?.comments.count)! {
                    self?.convertBBCodeToHTML(text: (self?.comments[index].content)!)
                    self?.comments[index].contentAttr = (self?.convertedText)!.data.attributedString!
                }
                self?.contentTableView.reloadData()
                self?.contentTableView.layoutIfNeeded()
                self?.goodCount.title = op.good
                self?.badCount.title = op.bad
                
                let keychain = KeychainSwift()
                
                if keychain.get("userKey") != nil {
                    if self?.isRated == "true"{
                        self?.goodButton.isEnabled = false
                        self?.badButton.isEnabled = false
                    } else {
                        self?.goodButton.isEnabled = true
                        self?.badButton.isEnabled = true
                    }
                }
                self?.contentTableView.isHidden = false
                
                if (self?.pageNow == Int((self?.pageCount)!)) {
                    self?.contentTableView.tableFooterView = self?.f5view
                }
                else {
                    self?.contentTableView.tableFooterView = nil
                }
                
                if (action == "f5") {
                    if (self?.pageNow == 1) {
                        let indexPath = IndexPath(row:comments.count,section:0)
                        self?.contentTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    else {
                        let indexPath = IndexPath(row:comments.count - 1,section:0)
                        self?.contentTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                }
                else if (action == "prevPage" || action == "nextPage") {
                    let indexPath = IndexPath(row:0,section:0)
                    self?.contentTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            }
        })
    }
    
    private func buttonLogic() {
        if (self.pageNow == 1 && self.pageNow != Int(pageCount)) {
            prevButton.isEnabled = false
            nextButton.isEnabled = true
        }
        else if (self.pageNow == 1 && self.pageNow == Int(pageCount)) {
            prevButton.isEnabled = false
            nextButton.isEnabled = false
        }
        else if (self.pageNow == Int(pageCount)) {
            prevButton.isEnabled = true
            nextButton.isEnabled = false
        }
        else {
            prevButton.isEnabled = true
            nextButton.isEnabled = true
        }
    }
    
    @IBAction func leaveNamePressed(_ sender: UIBarButtonItem) {
        let keychain = KeychainSwift()
        api.reply(topicID: threadIdReceived, content: keychain.get("LeaveNameText")!, completion: {
            self.updateSequence(action: "init")
        })
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        let shared = op.title + " // by: " + op.name + "\nShared via 1080-SIGNAL \nhttps://hkgalden.com/view/" + threadIdReceived
        let share = UIActivityViewController(activityItems:[shared],applicationActivities:nil)
        share.excludedActivityTypes = [.airDrop,.addToReadingList,.assignToContact,.openInIBooks,.saveToCameraRoll]
        present(share,animated: true,completion: nil)
    }
    
    //MARK JavaScript BBCode Parser Related
    var jsContext: JSContext!
    
    let consoleLog: @convention(block) (String) -> Void = { logMessage in
        print("\nJS Console:", logMessage)
    }
    
    let bbcodeToHTMLHandler: @convention(block) (String) -> Void = { htmlOutput in
        NotificationCenter.default.post(name: NSNotification.Name("bbcodeToHTMLNotification"), object: htmlOutput)
    }
    
    func initializeJS() {
        self.jsContext = JSContext()
        
        // Add an exception handler.
        self.jsContext.exceptionHandler = { context, exception in
            if let exc = exception {
                print("JS Exception:", exc.toString())
            }
        }
        
        let consoleLogObject = unsafeBitCast(self.consoleLog, to: AnyObject.self)
        self.jsContext.setObject(consoleLogObject, forKeyedSubscript: "consoleLog" as (NSCopying & NSObjectProtocol))
        _ = self.jsContext.evaluateScript("consoleLog")
        
        if let jsSourcePath = Bundle.main.path(forResource: "jssource", ofType: "js") {
            do {
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                self.jsContext.evaluateScript(jsSourceContents)
                
                
                // Fetch and evaluate the Snowdown script.
                let xbbcodeScript = try String(contentsOfFile: Bundle.main.path(forResource: "xbbcode", ofType: "js")!)
                self.jsContext.evaluateScript(xbbcodeScript)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        let htmlResultsHandler = unsafeBitCast(self.bbcodeToHTMLHandler, to: AnyObject.self)
        self.jsContext.setObject(htmlResultsHandler, forKeyedSubscript: "handleConvertedBBCode" as (NSCopying & NSObjectProtocol))
        _ = self.jsContext.evaluateScript("handleConvertedBBCode")
        
    }
    
    func convertBBCodeToHTML(text: String) {
        if let functionConvertBBCodeToHTML = self.jsContext.objectForKeyedSubscript("convertBBCodeToHTML") {
            _ = functionConvertBBCodeToHTML.call(withArguments: [text])
        }
    }
    
    @objc func handleBBCodeToHTMLNotification(notification: Notification) {
        if let html = notification.object as? String {
            let newContent = "<html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><style type=\"text/css\"> body { color: #555555; background-color: white; font-family:helvetica; font-size:15 } img{ max-width:280px; } blockquote {color: #c8c8c8;} a {overflow-wrap: break-word; word-wrap: break-word;} .xbbcode-b {font-weight:bold;} .xbbcode-blockquote {} .xbbcode-center {margin-left:auto;margin-right:auto;display: block;text-align: center;} .xbbcode-code {white-space: pre-wrap;font-family: monospace;} .xbbcode-i {font-style: italic;} .xbbcode-justify {display: block;text-align: justify;} .xbbcode-left {display: block;text-align: left;} .xbbcode-right {display: block;text-align: right;} .xbbcode-s {text-decoration: line-through;} .xbbcode-size-1 {font-size:xx-small;} .xbbcode-size-2 {font-size:x-small;} .xbbcode-size-3 {font-size:medium;} .xbbcode-size-4 {font-size:large;} .xbbcode-size-5 {font-size:x-large;} .xbbcode-size-6 {font-size:xx-large;} .xbbcode-u {text-decoration: underline;} .xbbcode-table {border-collapse:collapse;} .xbbcode-tr {} .xbbcode-table , .xbbcode-th, .xbbcode-td {border: 1px solid #666;} .xbbcode-hide {color: #ffccd5}</style></head><body>\(html)</body></html>"
            convertedText = newContent
        }
    }
}
