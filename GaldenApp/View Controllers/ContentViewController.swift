//
//  ContentViewController.swift
//  GaldenApp
//
//  Created by Kin Wa Lam on 2/10/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit
import JavaScriptCore
import NVActivityIndicatorView
import KeychainSwift
import MarqueeLabel

class ContentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate,UINavigationControllerDelegate {
    
    //MARK: Properties
    
    var threadIdReceived: String = ""
    var goToLastPage: Bool = false
    var channelNow: String = ""
    var isRated: String = ""
    var pageNow: Int = 1
    var convertedText: String = ""
    var op = OP(t: "",n: "",l: "",c: "",cA: NSAttributedString(),a: "",d: "",gd: "",b: "",ge: "",ch: "",qid:"",uid:"")
    var comments = [Replies]()
    var replyCount = 1
    var pageCount = 0.0
    var quoteContent = ""
    var blockedUsers = [String]()
    
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var pageButton: UIBarButtonItem!
    @IBOutlet weak var goodCount: UIBarButtonItem!
    @IBOutlet weak var badCount: UIBarButtonItem!
    @IBOutlet weak var prevButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var f5View: UIView!
    @IBOutlet weak var goodButton: UIBarButtonItem!
    @IBOutlet weak var badButton: UIBarButtonItem!
    @IBOutlet weak var leaveNameButton: UIBarButtonItem!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: MarqueeLabel!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var replyStack: UIStackView!
    
    let backgroundIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height),type: .ballPulseSync,padding: 175)
    
    //HKGalden API (NOT included in GitHub repo)
    var api = HKGaldenAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeJS()
        self.navigationController?.navigationBar.isTranslucent = true
        contentTableView.delegate = self
        contentTableView.dataSource = self
        navigationController?.delegate = self
        
        titleLabel.text = title
        
        backgroundIndicator.startAnimating()
        self.view.addSubview(backgroundIndicator)
        
        toolbar.heroModifiers = [.position(CGPoint(x:self.view.frame.midX,y:1000))]
        backgroundIndicator.isHeroEnabled = true
        backgroundIndicator.heroModifiers = [.fade,.position(CGPoint(x:self.view.frame.midX,y:200))]
        replyStack.heroModifiers = [.position(CGPoint(x:500,y:replyStack.frame.midY))]
        
        let keychain = KeychainSwift()
        
        if keychain.getData("BackgroundImage") != nil {
            backgroundImage.image = UIImage.init(data: keychain.getData("BackgroundImage")!)
        }
        
        if keychain.get("userKey") == nil {
            goodButton.isEnabled = false
            badButton.isEnabled = false
            leaveNameButton.isEnabled = false
            commentButton.isEnabled = false
        }
        
        self.prevButton.isEnabled = false
        self.nextButton.isEnabled = false
        
        self.f5View.isHidden = true
        self.contentTableView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(ContentViewController.handleBBCodeToHTMLNotification(notification:)), name: NSNotification.Name("bbcodeToHTMLNotification"), object: nil)
        
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
        self.titleLabel.triggerScrollStart()
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
                    cell.userAvatarImageView.image = UIImage(named: "DefaultAvatar")
                    cell.userNameLabel.text = "扑ed"
                    cell.userNameLabel.textColor = .gray
                    cell.userLevelLabel.text = "過街老鼠"
                    cell.replyCountLabel.text = ""
                    cell.dateLabel.text = ""
                    cell.contentTextView.attributedText = NSAttributedString()
                } else {
                    cell.configureOP(opData: op)
                }
            }
            else {
                if (blockedUsers.contains(comments[indexPath.row - 1].userID)) {
                    cell.userAvatarImageView.image = UIImage(named: "DefaultAvatar")
                    cell.userNameLabel.text = "扑ed"
                    cell.userNameLabel.textColor = .gray
                    cell.userLevelLabel.text = "過街老鼠"
                    cell.replyCountLabel.text = ""
                    cell.dateLabel.text = ""
                    cell.contentTextView.attributedText = NSAttributedString()
                } else {
                    cell.configureReplyFirstPage(comments: comments, indexPath: indexPath,pageNow: pageNow)
                }
            }
        }
        else {
            if (blockedUsers.contains(comments[indexPath.row].userID)) {
                cell.userAvatarImageView.image = UIImage(named: "DefaultAvatar")
                cell.userNameLabel.text = "扑ed"
                cell.userNameLabel.textColor = .gray
                cell.userLevelLabel.text = "過街老鼠"
                cell.replyCountLabel.text = ""
                cell.dateLabel.text = ""
                cell.contentTextView.attributedText = NSAttributedString()
            } else {
                cell.configureReply(comments: comments, indexPath: indexPath, pageNow: pageNow)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func f5Button(_ sender: UIButton) {
        contentTableView.isHidden = true
        backgroundIndicator.isHidden = false
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
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is ThreadListViewController {
            let destination = viewController as! ThreadListViewController
            destination.title = api.channelNameFunc(ch: destination.channelNow!)
            destination.navigationController?.navigationBar.barTintColor = api.channelColorFunc(ch: destination.channelNow!)
        }
    }
    
    @IBAction func showDetail(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began {
            let touchpoint = sender.location(in: contentTableView)
            let indexPath = contentTableView.indexPathForRow(at: touchpoint)
            if (pageNow == 1 && indexPath?.row == 0) {
                let actionSheet = UIAlertController(title: "你揀咗" + op.name + "嘅留言",message: "你想做啲乜?",preferredStyle: .actionSheet)
                
                actionSheet.addAction(UIAlertAction(title:"引用",style: .default, handler: {
                    action in
                    self.api.quote(quoteType: "t", quoteID: self.op.quoteID, completion: {
                        content in
                        self.quoteContent = content
                        self.performSegue(withIdentifier: "quote", sender: self)
                    })
                }))
                
                actionSheet.addAction(UIAlertAction(title: "扑柒",style: .destructive, handler: {
                    action in
                }))
                
                actionSheet.addAction(UIAlertAction(title: "冇嘢喇", style: .cancel, handler: nil))
                
                self.present(actionSheet, animated: true, completion: nil)
            } else if pageNow == 1 {
                let actionSheet = UIAlertController(title: "你揀咗" + comments[(indexPath?.row)! - 1].name + "嘅留言",message: "你想做啲乜?",preferredStyle: .actionSheet)
                
                actionSheet.addAction(UIAlertAction(title:"引用",style: .default, handler: {
                    action in
                    self.api.quote(quoteType: "r", quoteID: self.comments[(indexPath?.row)! - 1].quoteID, completion: {
                        content in
                        self.quoteContent = content
                        self.performSegue(withIdentifier: "quote", sender: self)
                    })
                }))
                
                actionSheet.addAction(UIAlertAction(title: "扑柒",style: .destructive, handler: {
                    action in
                }))
                
                actionSheet.addAction(UIAlertAction(title: "冇嘢喇", style: .cancel, handler: nil))
                
                self.present(actionSheet, animated: true, completion: nil)
            } else {
                let actionSheet = UIAlertController(title: "你揀咗" + comments[(indexPath?.row)!].name + "嘅留言",message: "你想做啲乜?",preferredStyle: .actionSheet)
                
                actionSheet.addAction(UIAlertAction(title:"引用",style: .default, handler: {
                    action in
                    self.api.quote(quoteType: "r", quoteID: self.comments[(indexPath?.row)!].quoteID, completion: {
                        content in
                        self.quoteContent = content
                        self.performSegue(withIdentifier: "quote", sender: self)
                    })
                }))
                
                actionSheet.addAction(UIAlertAction(title: "扑柒",style: .destructive, handler: {
                    action in
                }))
                
                actionSheet.addAction(UIAlertAction(title: "冇嘢喇", style: .cancel, handler: nil))
                
                self.present(actionSheet, animated: true, completion: nil)
            }
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
        case "quote"?:
            let destination = segue.destination as! ReplyViewController
            destination.topicID = self.threadIdReceived
            destination.content = self.quoteContent + "\n"
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
            backgroundIndicator.isHidden = false
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
            backgroundIndicator.isHidden = false
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
    
    //MARK: Private Functions
    
    private func updateSequence(action: String) {
        contentTableView.isHidden = true
        f5View.isHidden = true
        backgroundIndicator.isHidden = false
        if (goToLastPage == true) {
            pageNow = Int(pageCount)
            goToLastPage = false
        }
        buttonLogic()
        self.pageButton.title = "第" + String(self.pageNow) + "頁"
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
                
                self?.backgroundIndicator.isHidden = true
                self?.contentTableView.isHidden = false
                self?.contentTableView.tableFooterView = self?.f5View
                self?.f5View.isHidden = false
                self?.titleLabel.triggerScrollStart()
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
            let newContent = "<html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><style type=\"text/css\"> body { color: white; background-color: black; font-family:helvetica; font-size:15 } img{ max-width:280px; } blockquote {color: grey;} a {overflow-wrap: break-word; word-wrap: break-word;} .xbbcode-b {font-weight:bold;} .xbbcode-blockquote {} .xbbcode-center {margin-left:auto;margin-right:auto;display: block;text-align: center;} .xbbcode-code {white-space: pre-wrap;font-family: monospace;} .xbbcode-i {font-style: italic;} .xbbcode-justify {display: block;text-align: justify;} .xbbcode-left {display: block;text-align: left;} .xbbcode-right {display: block;text-align: right;} .xbbcode-s {text-decoration: line-through;} .xbbcode-size-1 {font-size:xx-small;} .xbbcode-size-2 {font-size:x-small;} .xbbcode-size-3 {font-size:medium;} .xbbcode-size-4 {font-size:large;} .xbbcode-size-5 {font-size:x-large;} .xbbcode-size-6 {font-size:xx-large;} .xbbcode-u {text-decoration: underline;} .xbbcode-table {border-collapse:collapse;} .xbbcode-tr {} .xbbcode-table , .xbbcode-th, .xbbcode-td {border: 1px solid #666;} .xbbcode-hide {color: #ffccd5}</style></head><body>\(html)</body></html>"
            convertedText = newContent
        }
    }
}
