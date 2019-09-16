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
    
    let animationSubView = AnimationView()
    var filename = "2166-dotted-loader"
    //another filename
    
    var numberOfCells: Int? {
        didSet {
            self.updateViews()
        }
    }

    private func updateViews() {
        
        //this is updating sectionheader part alone
        guard let cells = numberOfCells else {return}
        titleLabel?.text = "Studying"   //add animation ......
        countLabel?.text = "\(cells)/100"

        
        animationSubView.frame = CGRect(x:0, y:0, width: 100, height:100)
        let studyingAnimation = Animation.named(filename)
        animationSubView.animation = studyingAnimation
        animationSubView.contentMode = .scaleAspectFill
        animationSubView.loopMode = .loop
        self.animationView.addSubview(animationSubView)
        animationSubView.play()
    }
}
