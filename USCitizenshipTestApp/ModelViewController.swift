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
    
    init() {
        self.loadData()
    }
    
    var allQuestions: [Question] = []
    
    let jsonUrl = Bundle.main.url(forResource: "questions", withExtension: "json")
    
    func loadData() {
        do {
            let jsonData = try Data(contentsOf: jsonUrl!)
            let questionss = try JSONDecoder().decode([Question].self, from: jsonData)
            self.allQuestions = questionss
        } catch {
            NSLog("no data being decoded")
            return
        }
    }
    
    func updateQuestionForFinishedQuestion(for question: Question) {
        
        if let index = allQuestions.firstIndex(of: question) {
            if allQuestions[index].isCompleted == false {
                allQuestions[index].isCompleted = true
            }
        }
    }
    
    func updateQuestionForStudyMoreQuestion(for question: Question) {
        if let index = allQuestions.firstIndex(of: question) {
            if allQuestions[index].isCompleted == true {
                allQuestions[index].isCompleted = false
            }
        }
    }
}
