//
//  Question.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/2/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

struct Question {
    let questionPhoto: UIImage
    //let isCompleted: Bool = false
    let answer: String
    
    init(questionPhoto: UIImage, answer: String) {
        self.questionPhoto = questionPhoto
        self.answer = answer
    }

    init?(dictionary: [String: String]) {
        guard let questionPhoto = dictionary["QuestionPhoto"],
                let answer = dictionary["Answer"],
            let image = UIImage(named: questionPhoto) else {return nil}
        self.init(questionPhoto: image, answer: answer)
    }
}
