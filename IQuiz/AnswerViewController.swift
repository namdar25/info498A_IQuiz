//
//  AnswerViewController.swift
//  IQuiz
//
//  Created by Shawn Namdar on 11/10/15.
//  Copyright © 2015 Shawn Namdar. All rights reserved.
//

import Foundation
import UIKit

class AnswerViewController: UIViewController {

    var didAnswerCorrectly = false
    var currentQuestion: Int = 1
    
    var quizDTO: QuizCellDTO?
    
    @IBOutlet weak var answer: UILabel!
    
    @IBAction func next(sender: AnyObject) {
        let questionView = (self.navigationController?.viewControllers.count)! - 2
        let questionViewController = (self.navigationController?.viewControllers[questionView] as! QuestionViewController)
        if currentQuestion < questionViewController.quizDTO!.questionDTOs.count{
            currentQuestion += 1
            questionViewController.questionNumber = currentQuestion
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            performSegueWithIdentifier("AnswerToResult", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        let backButton = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: Selector("backButton:"))
        self.navigationItem.setLeftBarButtonItem(backButton, animated: false)
    }
    
    func backButton(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        if didAnswerCorrectly {
            answer.text = "Correctly"
            self.view.backgroundColor = UIColor.greenColor()
        } else {
            answer.text = "Incorrectly"
            self.view.backgroundColor = UIColor.redColor()
        }
    }

}