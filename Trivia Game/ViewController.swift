//
//  ViewController.swift
//  Trivia Game
//
//  Created by Mason Nesbitt on 10/8/18.
//  Copyright © 2018 Mason Nesbitt. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    var currentQuestion: TriviaQuestion! {
        didSet {
            questionLabel.text = currentQuestion.question
            answer1Button.setTitle(currentQuestion.answers[0], for: .normal)
            answer2Button.setTitle(currentQuestion.answers[1], for: .normal)
            answer3Button.setTitle(currentQuestion.answers[2], for: .normal)
            answer4Button.setTitle(currentQuestion.answers[3], for: .normal)
        }
    }
    

    var questions: [TriviaQuestion] = []
    
    var questionsPlaceholder: [TriviaQuestion] = []
    
    var score = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    
    var randomIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateQuestions()
        getNewQuestion()
    }
    
    //This will be used to populate our questions array when the app loads
    func populateQuestions() {
        let question1 = TriviaQuestion(question: "How far is the sun from earth?", answers: ["93,000,000", "103,000,000", "50,000,000", "2,000,000,000"], correctAnswerIndex: 0)
        let question2 = TriviaQuestion(question: "Does a ton of bricks weigh more or a ton of feathers?", answers: ["Bricks", "Feathers", "The Same", "Needs further Testing"], correctAnswerIndex: 2)
        let question3 = TriviaQuestion(question: "What bear is best?", answers: ["Battlestar Galactica", "Bears eat beets.", "Blackbear", "False, Brownbear"], correctAnswerIndex: 3)
        let question4 = TriviaQuestion(question: "What do squirrels do when nobody is looking?", answers: ["I don't know", "Water their grass", "Fight with other animals", "Eat Nuts"], correctAnswerIndex: 0)
        questions = [question1, question2, question3, question4]
    }
    
    //This function will be used to get a random question from our array of questions
    func getNewQuestion() {
        if questions.count > 0 {
            randomIndex = Int(arc4random_uniform(UInt32(questions.count)))
            currentQuestion = questions[randomIndex]
        } else {
            showGameOverAlert()
        }
    }
    
    func resetGame() {
        score = 0
        if !questions.isEmpty {
            questionsPlaceholder.append(contentsOf: questions)
        }
        questions = questionsPlaceholder
        questionsPlaceholder.removeAll()
        getNewQuestion()
    }
    
    //Show an alert when the user gets the question right
    func showCorrectAnswerAlert() {
        //UIAlertController
        let correctAlert = UIAlertController(title: "Correct", message: "\(currentQuestion.correctAnswer) was the correct answer.", preferredStyle: .actionSheet)
        //UIAlertAction
        let closeAction = UIAlertAction(title: "Close", style: .default) { _ in
            self.questionsPlaceholder.append(self.questions.remove(at: self.randomIndex))
            self.getNewQuestion()
        }
        correctAlert.addAction(closeAction)
        self.present(correctAlert, animated: true, completion: nil)
    }
    
    func showIncorrectAnswerAlert() {
        //UIAlertController
        let correctAlert = UIAlertController(title: "Incorrect", message: "\(currentQuestion.correctAnswer) was the correct answer.", preferredStyle: .actionSheet)
        //UIAlertAction
        let closeAction = UIAlertAction(title: "Close", style: .default) { _ in
            self.questionsPlaceholder.append(self.questions.remove(at: self.randomIndex))
            self.getNewQuestion()
        }
        correctAlert.addAction(closeAction)
        self.present(correctAlert, animated: true, completion: nil)
    }
    
    func showGameOverAlert() {
        //UIAlertController
        let gameOverAlert = UIAlertController(title: "Results", message: "Game over! Your score was \(score) out of \(questionsPlaceholder.count)", preferredStyle: .actionSheet)
        //UIAlertAction
        let resetAction = UIAlertAction(title: "Reset", style: .default) { _ in
            self.resetGame()
        }
        //Add the action to the alert controller
        gameOverAlert.addAction(resetAction)
        //Present the alert controller
        self.present(gameOverAlert, animated: true, completion: nil)
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        if sender.tag == currentQuestion.correctAnswerIndex {
            //They got the question right, so we need to let them know
            showCorrectAnswerAlert()
            score += 1
        } else {
            //They got the question wrong, so we need to let them know
            showIncorrectAnswerAlert()
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        resetGame()
    }
    
    //Unwind segue to this screen
    @IBAction func unwindToQuizScreen(segue: UIStoryboardSegue) { }
    
}

