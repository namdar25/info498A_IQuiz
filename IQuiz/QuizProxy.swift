//
//  QuizProxy.swift
//  IQuiz
//
//  Created by Shawn Namdar on 11/19/15.
//  Copyright © 2015 Shawn Namdar. All rights reserved.
//

import Foundation

class QuizProxy {
    
    var urlString: String = "http://tednewardsandbox.site44.com/questions.json"
    
    func loadQuizDTOArray(completionHandler: (dtoArray: [QuizCellDTO]? ) -> Void ) {
        let request = NSURLRequest(URL: NSURL(string: urlString)!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error != nil || data == nil{
                let cachedData = NSUserDefaults.standardUserDefaults().objectForKey("WorkingJSON") as? NSData
                if cachedData != nil{
                    let dtos = self.parse(cachedData!)
                    completionHandler(dtoArray: dtos)
                } else {
                    completionHandler(dtoArray: nil)
                }
            } else {
                let dtos = self.parse(data!)
                completionHandler(dtoArray: dtos)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: "WorkingJSON")
                }
        }
        task.resume()
    }
    
    func parse (data: NSData) -> [QuizCellDTO]? {
        do{
            let parsedObject: AnyObject? = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            print(" \(parsedObject!)")
            var dtos: [QuizCellDTO] = []
            let quizDataArray = parsedObject as! NSArray
            for var i = 0; i < parsedObject?.count; ++i {
                let quizDictionary = quizDataArray[i] as! NSDictionary
                let quizTitle = quizDictionary.valueForKey("title") as! String
                let quizDescription = quizDictionary.valueForKey("desc") as! String
                let questionDataArray = quizDictionary.valueForKey("questions") as! NSArray
                var questionDTOs: [QuestionDTO] = []
                for var j = 0; j < questionDataArray.count; ++j {
                    let questionDictionary = questionDataArray[j] as! NSDictionary
                    let question = questionDictionary.valueForKey("text") as! String
                    let correctAnswer = (questionDictionary.valueForKey("answer") as! NSString).integerValue
                    let answers = questionDictionary.valueForKey("answers") as! [String]
                    
                    let newQuestionDTO = QuestionDTO(question: question, correctAnswer: correctAnswer, answers: answers)
                    questionDTOs.append(newQuestionDTO)
                }
                let newQuizDTO = QuizCellDTO(quizTitle: quizTitle, quizDescription: quizDescription, questionDTOs: questionDTOs)
                dtos.append(newQuizDTO)
            }
            return dtos
        } catch {
            return nil
        }
    }
}
