//
//  MainCollectionViewCell.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/7/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import CoreData

class MainCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: Outlets
    @IBOutlet weak var finishedLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 14
        self.questionTextView.layer.cornerRadius = 14
        self.questionTextView.layer.borderWidth = 0.3
        self.questionTextView.layer.borderColor = UIColor.white.cgColor
        self.questionTextView.textColor = .white
        self.questionNumberLabel.layer.cornerRadius = 20
    }
    
    var question: Question? {
        didSet {
            self.updateViews()
        }
    }
    
    private func updateViews() {
        if let question = question {
            DispatchQueue.main.async {
                
                self.questionNumberLabel.text = question.questionNumber
                self.questionTextView.text = question.question
            }
            
            if question.isCompleted == true {
                self.finishedLabel.text = "👍"
                self.finishedLabel.isHidden = false
                self.alpha = 0.2
                self.questionTextView.alpha = 0.2
                self.questionNumberLabel.alpha = 0.2
                

            } else if question.isCompleted == false {
                self.finishedLabel.isHidden = true
                self.alpha = 0.8
                self.questionTextView.alpha = 0.8
                self.questionNumberLabel.alpha = 0.8
            }
        }
    }
}
