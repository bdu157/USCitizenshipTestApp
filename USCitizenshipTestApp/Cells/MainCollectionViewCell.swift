//
//  MainCollectionViewCell.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/7/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var finishedLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 14
    }
    
    
    var question: Question? {
        didSet {
            self.updateViews()
        }
    }
    
    private func updateViews() {
        if let question = question {
            
            let image = UIImage(named: question.questionPhoto)
            self.imageView.image = image
            
            if question.isCompleted == true {
                self.finishedLabel.text = "👍"
                self.finishedLabel.isHidden = false
            } else if question.isCompleted == false {
                self.finishedLabel.isHidden = true
            }
        }
    }
}
