//
//  MainCollectionViewCell.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/7/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    
    let modelViewController = ModelViewController()
    var question: Question? {
        didSet {
            self.updateViews()
        }
    }
    
    private func updateViews() {
        guard let question = question else {return}
        
        self.questionLabel.text = question.question
        
        self.modelViewController.fetchImages(imgUrlString: question.url) { (result) in
            if let result = try? result.get() {
                let image = UIImage(data: result)
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }

}
