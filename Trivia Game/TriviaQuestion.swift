//
//  TriviaQuestion.swift
//  Trivia Game
//
//  Created by Mason Nesbitt on 10/9/18.
//  Copyright © 2018 Mason Nesbitt. All rights reserved.
//

import Foundation

class TriviaQuestion {
    //String of question
    let question: String
    
    //Answer array
    let answers: [String]
    
    //Correct answers
    let correctAnswerIndex: Int
    
    //Returns the right answer
    var correctAnswer: String {
        return answers[correctAnswerIndex]
    }

    init(question: String, answers: [String], correctAnswerIndex: Int) {
        self.question = question
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
    }
}
