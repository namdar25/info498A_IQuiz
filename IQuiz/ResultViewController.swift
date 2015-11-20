//
//  ResultViewController.swift
//  IQuiz
//
//  Created by Shawn Namdar on 11/10/15.
//  Copyright © 2015 Shawn Namdar. All rights reserved.
//

import Foundation
import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var howTheyDid: UILabel!
    
    
    @IBAction func nextQuiz(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        let questionView = (self.navigationController?.viewControllers.count)! - 3
        let questionViewController = (self.navigationController?.viewControllers[questionView] as! QuestionViewController)
        var numberCorrect: Int = 0
        let numberOfQuestion = questionViewController.quizDTO!.questionDTOs.count
        for var index = 0; index < numberOfQuestion; ++index {
            if questionViewController.quizDTO!.questionDTOs[index].wasAnsweredCorrect {
                numberCorrect += 1
            }
        }
        score.text = "\(numberCorrect)/\(numberOfQuestion)"
        let scorePercent = (Double(numberCorrect)/Double(numberOfQuestion))*100
        switch scorePercent {
        case 0...20:
        howTheyDid.text = "YOU ARE SOOOO BAD"
        case 21...40:
        howTheyDid.text = "STILL BAD"
        case 41...60:
        howTheyDid.text = "Bad"
        case 61...80:
        howTheyDid.text = "passed"
        default:
        howTheyDid.text = "Good Job!"
        }
    }

}