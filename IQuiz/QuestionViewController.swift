
//
//  QuestionViewController.swift
//  IQuiz
//
//  Created by Shawn Namdar on 11/10/15.
//  Copyright © 2015 Shawn Namdar. All rights reserved.
//

import Foundation
import UIKit

class QuestionViewController: UITableViewController {

    let question: String
    let correctAnswer: Int
    let answers: [String]
    
    override func viewDidLoad() {
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("questionToAnswer", sender: nil)
    }
    
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Label")
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
}