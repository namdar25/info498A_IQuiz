//
//  QuizCellDTO.swift
//  IQuiz
//
//  Created by Shawn Namdar on 11/3/15.
//  Copyright © 2015 Shawn Namdar. All rights reserved.
//

import Foundation

class QuizCellDTO {
    let quizTitle: String
    let quizDescription: String
    
    init (quizTitle: String, quizDescription: String) {
        self.quizTitle = quizTitle
        self.quizDescription = quizDescription
    }
}