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
    @IBOutlet weak var animationView: UIView!
    //add segmentedControl
    

    var filename = "2166-dotted-loader"
    //another filename
    
    var section: Section! {
        didSet {
            self.updateViews()
        }
    }
    
    private func updateViews() {
        
        //give a logic based on segmentedControl
        //just check if count for section exists
        guard let section = section else {return}
        titleLabel?.text = "Studying"   //add animation ......
        countLabel?.text = "\(section.count)/100"

        let animationSubView = AnimationView()
        animationSubView.frame = CGRect(x:0, y:0, width: 100, height:100)
        let studyingAnimation = Animation.named(filename)
        animationSubView.animation = studyingAnimation
        animationSubView.contentMode = .scaleAspectFill
        animationSubView.loopMode = .loop
        self.animationView.addSubview(animationSubView)
        animationSubView.play()
    }
    
}
