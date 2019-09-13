//
//  ModelViewControllers.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/1/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

class ModelViewController {
    
    var allQuestions: [Question] {
        
        var questions: [Question] = []
        
        guard let URL = Bundle.main.url(forResource: "Questions", withExtension: "plist"),
            let QuestionsFromPlist = NSArray(contentsOf: URL) as? [[String: String]] else { return questions }
        
        for dictionary in QuestionsFromPlist {
            if let question = Question(dictionary: dictionary) {
                questions.append(question)
            }
        }
        return questions
    }
    
}
