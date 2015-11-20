//
//  ViewController.swift
//  IQuiz
//
//  Created by Shawn Namdar on 11/3/15.
//  Copyright © 2015 Shawn Namdar. All rights reserved.
//

import UIKit

class IQuizViewController: UITableViewController {

    var quizCellArray: [QuizCellDTO]?
    let quizProxy = QuizProxy()
    
    @IBAction func settingsButtonPushed(sender: UIButton) {
        let uiAlertController = UIAlertController(title: "Settings go here", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        let urlAction = UIAlertAction(title: "Check Now", style: .Default) { (_) in
            let urlTextField = uiAlertController.textFields![0] as UITextField
            self.quizProxy.urlString = urlTextField.text!
            self.loadData()
        }
        uiAlertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.text = self.quizProxy.urlString
        }
        uiAlertController.addAction(urlAction)
        presentViewController(uiAlertController, animated: true, completion: nil)
        
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
            loadData()
    }
    
    
    func loadData() -> Void {
        quizProxy.loadQuizDTOArray { (dtoArray) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if dtoArray != nil {
                    self.quizCellArray = dtoArray
                    self.tableView.reloadData()
                } else {
                    print("ERROR")
                }
            })
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if quizCellArray != nil{
        return quizCellArray!.count
        } else {
            return 0
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("QuizTitleCell")
        if cell == nil {
            cell = QuizCell()
        }
        let quizCell = cell as! QuizCell
        quizCell.quizTitle.text = quizCellArray![indexPath.row].quizTitle
        quizCell.quizDescription.text = quizCellArray![indexPath.row].quizDescription
        return quizCell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 99
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("quizToQuestion", sender: indexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "quizToQuestion" {
            let questionViewController = segue.destinationViewController as! QuestionViewController
            let row = sender as! Int
            questionViewController.quizDTO = quizCellArray![row]
        }
    }
}

