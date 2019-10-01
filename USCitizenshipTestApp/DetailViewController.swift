//
//  DetailViewController.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/15/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class DetailViewController: UIViewController {
    
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var seeAnswerButton: UIButton!
    @IBOutlet weak var thumbLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    
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
        questionImageView.layer.cornerRadius = 14
        divisor = (view.frame.width / 2) / 0.61
        card.isUserInteractionEnabled = true
        
        self.card.center = CGPoint(x: view.center.x, y: view.center.y)
        self.card.layer.borderWidth = 0.5
        self.card.layer.borderColor = UIColor.white.cgColor
        self.card.layer.cornerRadius = 14
        
        self.seeAnswerButton.isHidden = false
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    func updateViews() {
        if let question = question {
            DispatchQueue.main.async {
                self.questionImageView.image = UIImage(named: question.questionPhoto!)
                self.questionImageView.alpha = 0.93
            }
            if question.isCompleted == true {
                self.thumbLabel?.text = "👍"
                self.thumbLabel?.isHidden = false
            } else {
                self.thumbLabel?.isHidden = true
            }
        }
    }
    
    
    let randomNumber = Int.random(in: 1...3)
    
    @IBAction func toSeeAnswerButtonTapped(_ sender: Any) {
        
        self.seeAnswerButton.isHidden = true
        
        if let question = self.question {
            let isContained = self.checkphotoNumber(for: question)
            
            if isContained {
                self.textView.text = question.answer
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
    
    private func checkphotoNumber(for question: Question) -> Bool {
        let numArray = ["36", "55", "64", "87", "92"]
        var isContained: Bool = false
        let questionPhotoString = question.questionPhoto
        
        for i in numArray {
            if questionPhotoString == i {
                isContained = true
            }
        }
        return isContained
    }
    
    
    //animations for answer
    
    private func animationForAnswer() {
        let animBlock = {

            UILabel.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.3, animations: {
                self.answerLabel.backgroundColor = UIColor(red: CGFloat(Int.random(in: 0...255)) / 255, green: CGFloat(Int.random(in: 0...255)) / 255, blue: CGFloat(Int.random(in: 0...255)) / 255, alpha: 1)
            })
            
            UILabel.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.4, animations: {
                self.answerLabel.transform = .identity
                self.answerLabel.alpha = 1.0
            })
        }
        UILabel.animateKeyframes(withDuration: 1.5, delay: 0.0, options: [], animations: animBlock, completion: nil)
    }
    
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func studyMoreButtonTapped(_ sender: Any) {
        
        guard let question = question else {return}
        let backgroundContext = CoreDataStack.shared.container.newBackgroundContext()
        backgroundContext.performAndWait {
            //getting the specific object from persistentStore - CoreData
            if let object = self.modelViewController.fetchSingleQuestionFromPersistentStore(for: question.questionPhoto!, context: backgroundContext) {
                self.modelViewController.updateToStudyMore(question: object)
            } else {
                print("there is an error in updating question object from persistent store")
            }
            
            do {
                try backgroundContext.save()
            } catch {
                NSLog("there is an error in saving the data as backgroundContext")
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func gotItButtonTapped(_ sender: Any) {
        
        guard let question = question else {return}
        let backgroundContext = CoreDataStack.shared.container.newBackgroundContext()
        backgroundContext.performAndWait {
            //getting the specific object from persistentStore - CoreData
            if let object = self.modelViewController.fetchSingleQuestionFromPersistentStore(for: question.questionPhoto!, context: backgroundContext) {
                self.modelViewController.updateToFinished(question: object)
            } else {
                print("there is an error in updating question object from persistent store")
            }
            
            do {
                try backgroundContext.save()
            } catch {
                NSLog("there is an error in saving the data as backgroundContext")
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: card) //how far you moved
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
                print("areas before swipe right animation happens")
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                    card.alpha = 0
                    print("swipe right action and animation called ")
                }
                self.gotItAndStudyMore()
                return
                
            } else if card.center.x > (view.frame.width - 75) {
                //move off to the right side
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                    card.alpha = 0
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
    
    private func gotItAndStudyMore() {
        guard let question = self.question else {return}
        let target = card.center.x
        
        if target >= 75 {
            let backgroundContext = CoreDataStack.shared.container.newBackgroundContext()
            backgroundContext.performAndWait {
                //getting the specific object from persistentStore - CoreData
                if let object = self.modelViewController.fetchSingleQuestionFromPersistentStore(for: question.questionPhoto!, context: backgroundContext) {
                    self.modelViewController.updateToFinished(question: object)
                } else {
                    print("there is an error in updating question object from persistent store")
                }
                
                do {
                    try backgroundContext.save()
                } catch {
                    NSLog("there is an error in saving the data as backgroundContext")
                }
            }
        } else if target < 75 {
            let backgroundContext = CoreDataStack.shared.container.newBackgroundContext()
            backgroundContext.performAndWait {
                //getting the specific object from persistentStore - CoreData
                if let object = self.modelViewController.fetchSingleQuestionFromPersistentStore(for: question.questionPhoto!, context: backgroundContext) {
                    self.modelViewController.updateToStudyMore(question: object)
                } else {
                    print("there is an error in updating question object from persistent store")
                }
                
                do {
                    try backgroundContext.save()
                } catch {
                    NSLog("there is an error in saving the data as backgroundContext")
                }
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
}
