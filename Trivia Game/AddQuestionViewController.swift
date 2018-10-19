//
//  AddQuestionViewController.swift
//  Trivia Game
//
//  Created by Mason Nesbitt on 10/11/18.
//  Copyright © 2018 Mason Nesbitt. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController {

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answer1TextField: UITextField!
    @IBOutlet weak var answer2TextField: UITextField!
    @IBOutlet weak var answer3TextField: UITextField!
    @IBOutlet weak var answer4TextField: UITextField!
    @IBOutlet weak var correctAnswerSegmentedControl: UISegmentedControl!
    
    var newQuestion: TriviaQuestion!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? ViewController {
            //Append the new question to the questions array
            destination.questions.append(newQuestion)
        }
    }
    
    func showErrorAlert() {
        let errorAlert = UIAlertController(title: "Error", message: "Please enter text in all fields, or hit the back button to go back to the quiz.", preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        errorAlert.addAction(dismissAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        //Make sure each of the text fields has text
        guard let question = questionTextField.text, !question.isEmpty,
        let answer1 = answer1TextField.text, !answer1.isEmpty,
        let answer2 = answer2TextField.text, !answer2.isEmpty,
        let answer3 = answer3TextField.text, !answer3.isEmpty,
        let answer4 = answer4TextField.text, !answer4.isEmpty else {
            showErrorAlert()
            return
        }
        
        newQuestion = TriviaQuestion(question: question, answers: [answer1, answer2, answer3, answer4], correctAnswerIndex: correctAnswerSegmentedControl.selectedSegmentIndex)
        
        self.performSegue(withIdentifier: "unwindToQuizScreen", sender: self)
    }
}
