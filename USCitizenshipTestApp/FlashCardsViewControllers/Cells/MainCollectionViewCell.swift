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
    @IBOutlet weak var questionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 14
    }
    
    var question: Question? {
        didSet {
            self.updateViews()
        }
    }
    
    private func updateViews() {
        guard let question = question else {return}
            
        if question.questionNumber == "hundred" {
            self.questionNumberLabel.text = "100"
            self.updateViewsInside(for: question)
        } else {
            self.questionNumberLabel.text = question.questionNumber
            self.updateViewsInside(for: question)
        }
    }
    
    private func updateViewsInside(for question: Question) {
        self.questionLabel.text = question.question
        self.updateTheme()
        
        if question.isCompleted == true {
            self.updateViewsonTrue()
        } else if question.isCompleted == false {
            self.updateViewsonFalse()
        }
    }
    
    //private methods for updateviews
    private func updateTheme() {
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: .shouldShowWhiteTheme) {
            self.questionLabel.textColor = .black
            self.questionNumberLabel.textColor = .black
            self.backgroundColor = .white
        } else {
            self.questionLabel.textColor = .white
            self.questionNumberLabel.textColor = .white
            self.backgroundColor = UIColor.init(displayP3Red: 0.1028374508, green: 0.2917560935, blue: 0.5240949392, alpha: 1)
        }
    }
    
    private func updateViewsonTrue() {
        self.finishedLabel.text = "👍"
        self.finishedLabel.isHidden = false
        self.questionLabel.alpha = 0.2
        self.questionNumberLabel.alpha = 0.2
        
        self.updateBGColorTrue()
    }
    
    private func updateViewsonFalse() {
        self.finishedLabel.isHidden = true
        self.questionLabel.alpha = 0.8
        self.questionNumberLabel.alpha = 0.8
        
        self.updateBGColorFalse()
    }
    
    private func updateBGColorTrue() {
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: .shouldShowWhiteTheme) {
            self.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        } else {
            self.backgroundColor = UIColor.init(displayP3Red: 0.1028374508, green: 0.2917560935, blue: 0.5240949392, alpha: 0.2)
        }
    }
    
    private func updateBGColorFalse() {
        let userDefaults = UserDefaults.standard
        if !userDefaults.bool(forKey: .shouldShowWhiteTheme) {
            self.backgroundColor = UIColor.init(displayP3Red: 0.1028374508, green: 0.2917560935, blue: 0.5240949392, alpha: 1)
        } else {
            self.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        }
    }
}
