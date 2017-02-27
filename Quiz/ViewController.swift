//
//  ViewController.swift
//  Quiz
//
//  Created by Jackson Inchalik on 1/20/17.
//  Copyright © 2017 Jackson Inchalik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var answerLabel: UILabel!
    
    var screenWidth: CGFloat!
    
    let layoutGuide = UILayoutGuide()
    
    
    let questions: [String] = [
        "What is 7+7?",
        "What is the capital of Vermont?",
        "What is cognac made from?"
    ]
    let answers: [String] = [
        "14",
        "Montpelier",
        "Grapes"
    ]
    var currentQuestionIndex: Int = 0
    @IBAction func showNextQuestion(_ sender: UIButton){
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(_ sender: UIButton){
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
          screenWidth = view.frame.width
        
        updateOffScreenLabel()
    }
    
    func updateOffScreenLabel() {
        //let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Set the label's initial alpha
        nextQuestionLabel.alpha = 0
    }
    
    func animateLabelTransitions() {
        
        //Force any outstanding layout changes to occur
        view.layoutIfNeeded()
    
        
        //Animate the alpha
        //and the center X constraints
        //let screenWidth = view.frame.width
        let startNewQuestion = (self.currentQuestionLabelCenterXConstraint.constant == screenWidth)
        
        if(startNewQuestion)
        {
            self.nextQuestionLabelCenterXConstraint.constant = 0
            answerLabel.isEnabled = true
        }else
        {
            self.currentQuestionLabelCenterXConstraint.constant += screenWidth
            answerLabel.isEnabled = false
        }
        
        /*UIView.animate(withDuration: 0.5, 
         delay: 0, 
         options: [.curveLinear], 
         animations: {
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            
            
            
            UIView.animate(withDuration: 1  , 
         delay: 0.5, 
         usingSpringWithDamping: 0.5, 
         initialSpringVelocity: 5, 
         options: [UIViewAnimationOptions.curveEaseOut], 
         animations: {
                
                self.view.layoutIfNeeded()
         
            })
            

        },
                       completion: { _ in
                swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
                self.updateOffScreenLabel() 
        }) */
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 5,
                       options: [.curveEaseInOut],
                       animations: {
                        self.currentQuestionLabel.alpha = 0
                        self.nextQuestionLabel.alpha = 1
                        self.view.layoutIfNeeded()
                        },
                       completion: { _ in
                        if(startNewQuestion){
                        swap(&self.currentQuestionLabel,
                             &self.nextQuestionLabel)
                        swap(&self.currentQuestionLabelCenterXConstraint,
                             &self.nextQuestionLabelCenterXConstraint)
                        }
                        self.updateOffScreenLabel()
        })
            }
    

}

