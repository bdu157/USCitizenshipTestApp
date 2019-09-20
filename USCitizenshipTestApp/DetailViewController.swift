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
                self.questionImageView.image = UIImage(named: question.questionPhoto)
                self.questionImageView.alpha = 0.8
            }
            if question.isCompleted == true {
                self.thumbLabel?.text = "👍"
                self.thumbLabel?.isHidden = false
            } else {
                self.thumbLabel?.isHidden = true
            }
        }
        
    }
    
    var answerLabel = UILabel()
    
    @IBAction func toSeeAnswerButtonTapped(_ sender: Any) {
        animation()
    }
    
    private func animation() {
        self.seeAnswerButton.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        UIView.animate(withDuration: 3.0, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
            self.seeAnswerButton.transform = .identity
            self.seeAnswerButton.setTitle(self.question!.answer, for: .normal)
        }, completion: nil)
    }
    
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func studyMoreButtonTapped(_ sender: Any) {
        
        guard let question = question else {return}
        self.modelViewController.updateQuestionForStudyMoreQuestion(for: question)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func gotItButtonTapped(_ sender: Any) {
        
        guard let question = question else {return}
        self.modelViewController.updateQuestionForFinishedQuestion(for: question)
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
            self.modelViewController.updateQuestionForFinishedQuestion(for: question)
        } else if target < 75 {
            self.modelViewController.updateQuestionForStudyMoreQuestion(for: question)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
