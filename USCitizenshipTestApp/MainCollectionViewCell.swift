//
//  MainCollectionViewCell.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/7/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 14
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.cyan.cgColor
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
        }
    }
}
