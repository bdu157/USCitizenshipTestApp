//
//  DetailViewController.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/15/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    
    //MARK: Outlets and properties
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var seeAnswerButton: UIButton!
    @IBOutlet weak var thumbLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var studyMoreButton: UIButton!
    @IBOutlet weak var gotitButton: UIButton!
    
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var divisor: CGFloat!
    
    var modelViewController: ModelViewController!
    
    var question: Question? {
        didSet {
            self.updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        questionView.layer.cornerRadius = 14
        divisor = (view.frame.width / 2) / 0.61
        card.isUserInteractionEnabled = true
        self.card.center = CGPoint(x: view.center.x, y: view.center.y)
        self.card.layer.borderWidth = 0.5
        self.card.layer.cornerRadius = 14

        self.seeAnswerButton.isHidden = false
        self.card.layer.borderColor = UIColor.white.cgColor
        
        self.updateTheme()
    }
    
    
    //MARK: UpdateView and theme
    //updateview
    private func updateViews() {
        guard isViewLoaded else {return}
        if let question = question {
            DispatchQueue.main.async {
                self.questionLabel.text = question.question
            }
            if question.isCompleted == true {
                self.thumbLabel?.text = "👍"
                self.thumbLabel?.isHidden = false
            } else {
                self.thumbLabel?.isHidden = true
            }
        }
    }
    //updateTheme
    private func updateTheme() {
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: .shouldShowWhiteTheme) == true {
            let mainColorBlue = #colorLiteral(red: 0.1651235223, green: 0.3135112226, blue: 0.5044639707, alpha: 1)
            self.answerLabel.textColor = mainColorBlue
            self.seeAnswerButton.setTitleColor(mainColorBlue, for: .normal)
            self.view.backgroundColor = .white
            self.card.layer.borderColor = CGColor.init(srgbRed: 0.1651235223, green: 0.3135112226, blue: 0.5044639707, alpha: 1)
            self.dismissButton.setTitleColor(mainColorBlue, for: .normal)
            self.studyMoreButton.setTitleColor(mainColorBlue, for: .normal)
            self.gotitButton.setTitleColor(mainColorBlue, for: .normal)
            self.card.backgroundColor = .white
            self.card.layer.borderWidth = 1.0
            self.questionView.backgroundColor = mainColorBlue
            self.questionLabel.textColor = .white
        }
    }
    
    
    //MARK: Tab to see the answer button
    let randomNumber = Int.random(in: 1...3)
    
    @IBAction func toSeeAnswerButtonTapped(_ sender: Any) {
        
        self.seeAnswerButton.isHidden = true
        
        let userDefaults = UserDefaults.standard
        
        
        if let question = self.question {
            
            let isContained = self.checkphotoNumber(for: question)
            
            if isContained {
                
                self.textView.text = question.answer
                
            } else {
                
                if userDefaults.bool(forKey: .noAnswerAnimtaion) {
                    self.answerLabel.text = question.answer
                } else {
                    
                    self.answerLabel.text = question.answer
                    
                    let animationCase = randomNumber
                    
                    switch animationCase {
                    case 1:
                        self.answerLabel.pulse()
                        print("random number 1")
                    case 2:
                        self.answerLabel.flash()
                        print("random number 2")
                    case 3:
                        self.answerLabel.shake()
                        print("random number 3")
                    default:
                        return
                    }
                }
            }
        }
    }
    //TextView for long answers
    private func checkphotoNumber(for question: Question) -> Bool {
        let numArray = ["36", "55", "64", "87", "92"]
        var isContained: Bool = false
        let questionPhotoString = question.questionNumber
        
        for i in numArray {
            if questionPhotoString == i {
                isContained = true
            }
        }
        return isContained
    }
    
    
    //MARK: Buttons
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func studyMoreButtonTapped(_ sender: Any) {
        guard let question = question else {return}
        self.modelViewController.studyMore(for: question)
        //notification here so reloadData() only occurs when there is an update
        NotificationCenter.default.post(name: .needtoReloadData, object: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func gotItButtonTapped(_ sender: Any) {
        guard let question = question else {return}
        self.modelViewController.finished(for: question)
        //notification here so reloadData() only occurs when there is an update
        NotificationCenter.default.post(name: .needtoReloadData, object: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: PanGestureRecognizer for swiping right and left
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: card) //how far you move
        let xFromCenter = card.center.x - view.center.x
        //100/2 = 50/0.61 degree number = 81.967
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        //let scale = min(100/abs(xFromCenter), 1)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor)
        
        if xFromCenter > 0 {
            thumbImageView.image = #imageLiteral(resourceName: "thumbsup")
            thumbImageView.tintColor = UIColor.yellow
        } else {
            thumbImageView.image = #imageLiteral(resourceName: "thumbsdown")
            thumbImageView.tintColor = UIColor.red
        }
        
        thumbImageView.alpha = abs(xFromCenter) / view.center.x
        
        if sender.state == UIGestureRecognizer.State.ended {
            
            print("sender.state.ended is getting called")
            if card.center.x < 75 {
                //move off to the left side
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                    card.alpha = 0
                    print("swipe left action and animation called ")
                }
                self.gotItAndStudyMore()
                return
                
            } else if card.center.x > (view.frame.width - 75) {
                //move off to the right side
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                    card.alpha = 0
                    print("swipe right action and animation called ")
                }
                self.gotItAndStudyMore()
                return
            }
            
            UIView.animate(withDuration: 0.2) {
                card.center = self.view.center
                self.thumbImageView.alpha = 0
                card.transform = .identity
            }
        }
    }
    //private method to update datas based on right or left swipe
    private func gotItAndStudyMore() {
        guard let question = self.question else {return}
        let target = card.center.x
        
        if target >= 75 {
            self.modelViewController.finished(for: question)
        } else if target < 75 {
            self.modelViewController.studyMore(for: question)
        }
        //notification here so reloadData() only occurs when there is an update
        NotificationCenter.default.post(name: .needtoReloadData, object: self)
        self.dismiss(animated: true, completion: nil)
    }
}


