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
        let studyingAnimation = Animation.named(randomFileName)
        animationSubView.animation = studyingAnimation
        animationSubView.contentMode = .scaleAspectFill
        animationSubView.loopMode = .loop
        self.animationView.addSubview(animationSubView)
        animationSubView.play()

    }
    
    private var randomFileName: String {
        var filenames: [String] = ["studying1", "studying2", "studying3"]
        let randomNumber = Int.random(in: 0...2)
        let randomName = filenames[randomNumber]
        return randomName
    }
    
    
    private func getStudyingQuestionsCount(for questions: [Question]) {
        let studyingQuestions =  questions.filter{$0.isCompleted == false}
        self.countLabel.text = "\(studyingQuestions.count)"
        self.titleLabel.text = "Studying"
    }
    
    private func getFinishedQuestionsCount(for questions: [Question]) {
        let finishedQuestions = questions.filter {$0.isCompleted == true}
        self.finishedCountLabel.text = "\(finishedQuestions.count)"
        self.finishedTitleLable.text = "Finished"
    }
}
