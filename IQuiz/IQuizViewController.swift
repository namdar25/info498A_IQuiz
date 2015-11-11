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
    
    @IBAction func settingsButtonPushed(sender: UIButton) {
        let uiAlertController = UIAlertController(title: "Settings go here", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        uiAlertController.addAction(alertAction)
        presentViewController(uiAlertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let quizDTO1: QuizCellDTO = QuizCellDTO(quizTitle: "Mathematics", quizDescription: "number stuff")
        let quizDTO2: QuizCellDTO = QuizCellDTO(quizTitle: "Marvel SuperHeroes", quizDescription: "nerd stuff")
        let quizDTO3: QuizCellDTO = QuizCellDTO(quizTitle: "Science", quizDescription: "real stuff")
       
        quizCellArray = [quizDTO1, quizDTO2, quizDTO3]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizCellArray!.count
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
        performSegueWithIdentifier("quizToQuestion", sender: nil)
    }
}

