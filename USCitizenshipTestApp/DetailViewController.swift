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
    
}
