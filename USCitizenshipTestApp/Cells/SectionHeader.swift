//
//  SectionHeader.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/13/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class SectionHeader: UICollectionReusableView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var animationView: UIView!
    
    @IBOutlet weak var finishedTitleLable: UILabel!
    @IBOutlet weak var finishedCountLabel: UILabel!
    
    let animationSubView = AnimationView()
    var filename = "studying"
    //another filename
    
    var questions: [Question]? = [] {
        didSet {
            self.updateViews()
        }
    }

    private func updateViews() {
        
        //this will update counts for studying and finisehd
        if let questions = questions {
            self.getStudyingQuestionsCount(for: questions)
            self.getFinishedQuestionsCount(for: questions)
        }
        
        animationSubView.frame = CGRect(x:0, y:0, width: 100, height:100)
        let studyingAnimation = Animation.named(filename)
        animationSubView.animation = studyingAnimation
        animationSubView.contentMode = .scaleAspectFill
        animationSubView.loopMode = .loop
        self.animationView.addSubview(animationSubView)
        animationSubView.play()
    }
    
    private func getStudyingQuestionsCount(for questions: [Question]) {
        let studyingQuestions =  questions.filter{$0.isCompleted == false}
        self.countLabel.text = "\(studyingQuestions.count)/100"
        self.titleLabel.text = "Studying"
    }
    
    private func getFinishedQuestionsCount(for questions: [Question]) {
        let finishedQuestions = questions.filter {$0.isCompleted == true}
        self.finishedCountLabel.text = "\(finishedQuestions.count)/100"
        self.finishedTitleLable.text = "Finished"
    }
}
