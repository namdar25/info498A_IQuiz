
//
//  QuestionViewController.swift
//  IQuiz
//
//  Created by Shawn Namdar on 11/10/15.
//  Copyright © 2015 Shawn Namdar. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: startIndex.advancedBy(r.startIndex), end: startIndex.advancedBy(r.endIndex)))
    }
}

class QuestionViewController: UITableViewController {

    var questionNumber: Int! = 1
    var question: String!
    var correctAnswer: Int!
    var answers: [String]!
    let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    var lastNSIndexPath: NSIndexPath!
    var questionCellArray: [QuestionDTO]!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let questionDTO1: QuestionDTO = QuestionDTO(question: "tests bl", correctAnswer: 3, answers: ["blah","bluh","bleh","bloh"])
        let questionDTO2: QuestionDTO = QuestionDTO(question: "tests cl", correctAnswer: 3, answers: ["clah","cluh","cleh","cloh"])
        let questionDTO3: QuestionDTO = QuestionDTO(question: "tests fl", correctAnswer: 3, answers: ["flah","fluh","fleh","floh"])
        
        questionCellArray = [questionDTO1, questionDTO2, questionDTO3]
        setStuff()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        let backButton = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: Selector("backButton:"))
        self.navigationItem.setLeftBarButtonItem(backButton, animated: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        setStuff()
        lastNSIndexPath = nil
    }
    
    @IBAction func submitAnswer(sender: UIButton) {
        if lastNSIndexPath != nil{
        performSegueWithIdentifier("questionToAnswer", sender: nil)
        }
    }
    
    func backButton(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if lastNSIndexPath != nil {
            tableView.deselectRowAtIndexPath(lastNSIndexPath, animated: true)
        }
                lastNSIndexPath = indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "questionToAnswer" {
            let answerViewController = segue.destinationViewController as! AnswerViewController
            answerViewController.didAnswerCorrectly = (correctAnswer == lastNSIndexPath.row)
            questionCellArray[questionNumber-1].wasAnsweredCorrect = (correctAnswer == lastNSIndexPath.row)
            answerViewController.currentQuestion = questionNumber
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            var cell = tableView.dequeueReusableCellWithIdentifier("Question")
            if cell == nil {
                cell = QuestionLabelCell()
            }
            let questionLabelCell = cell as! QuestionLabelCell
            questionLabelCell.questionLabel.text = "Question:"
            questionLabelCell.questionText.text = question
            return questionLabelCell
        } else {
            var cell = tableView.dequeueReusableCellWithIdentifier("Answer")
            if cell == nil {
                cell = AnswerCell()
            }
            let answerCell = cell as! AnswerCell
            answerCell.answerLabel.text = String(alphabet[indexPath.row - 1])
            answerCell.answerText.text = answers[indexPath.row - 1]
            return answerCell
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 129
        } else {
            return 95
        }
    }
    
    func setStuff () {
        self.title = "Question \(questionNumber)"
        
        question = questionCellArray[questionNumber-1].question
        correctAnswer = questionCellArray[questionNumber-1].correctAnswer
        answers = questionCellArray[questionNumber-1].answers
    }
}