//
//  QuestionDTO.swift
//  IQuiz
//
//  Created by Shawn Namdar on 11/10/15.
//  Copyright © 2015 Shawn Namdar. All rights reserved.
//

import Foundation

class QuestionDTO {
    let question: String
    let correctAnswer: Int
    let answers: [String]
    
    init (question: String, correctAnswer: Int, answers: [String]) {
        self.question = question
        self.correctAnswer = correctAnswer
        self.answers = answers
    }
}