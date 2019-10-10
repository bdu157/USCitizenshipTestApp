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
    
    
    //MARK: Outlets and propreties
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var animationView: UIView!
    
    @IBOutlet weak var finishedTitleLable: UILabel!
    @IBOutlet weak var finishedCountLabel: UILabel!
    
    let animationSubView = AnimationView()
    
    var questions: [Question]? = [] {
        didSet {
            self.updateViews()
        }
    }
    
    var delegate: SectionHeaderDelegate?
    
    //MARK: UpdateViews
    private func updateViews() {
        //this will update counts for studying and finisehd
        if let questions = questions {
            self.getStudyingQuestionsCount(for: questions)
            self.getFinishedQuestionsCount(for: questions)
        }
        animationSubView.frame = CGRect(x:0, y:0, width: 100, height:100)
        let studyingAnimation = Animation.named("studying3")
        animationSubView.animation = studyingAnimation
        animationSubView.contentMode = .scaleAspectFill
        animationSubView.loopMode = .loop
        self.animationView.addSubview(animationSubView)
        animationSubView.play()
    }
    //private methods for updateViews
    private func getStudyingQuestionsCount(for questions: [Question]) {
        let studyingQuestions =  questions.filter{$0.isCompleted == false}
        self.countLabel.text = "\(studyingQuestions.count)"
    }
    
    private func getFinishedQuestionsCount(for questions: [Question]) {
        let finishedQuestions = questions.filter {$0.isCompleted == true}
        self.finishedCountLabel.text = "\(finishedQuestions.count)"
        self.alertMessages(for: finishedQuestions.count)
    }

    private func alertMessages(for finishedQuestionsCount: Int) {
        switch finishedQuestionsCount {
        case 8:
            delegate?.showConfettiAnimation()
        case 9:
            delegate?.showAlertTwentyFive()
        case 10:
            delegate?.showAlertFifty()
        case 11:
            delegate?.showAlertSeventyFive()
        default:
            break
        }
    }
}
