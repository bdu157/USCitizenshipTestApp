//
//  ModelViewControllers.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/1/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ModelViewController {
    
    init() {
        //userDefault bool true then load date if it is false then no initializer for loadData()
        let userDefaults = UserDefaults.standard
        let value = userDefaults.bool(forKey: .loadDataValueKey)
        if !value {
            self.loadData()
        } 
    }
    
    let jsonUrl = Bundle.main.url(forResource: "questions", withExtension: "json")
    
    private func loadData() {
        
        //var allQuestions: [Question] = []
        
        do {
            let jsonData = try Data(contentsOf: jsonUrl!)
            let questionss = try JSONDecoder().decode([QuestionRepresentation].self, from: jsonData)
            
            for question in questionss {
                let _ = Question(questionPhoto: question.questionPhoto, isCompleted: question.isCompleted, answer: question.answer)
            }
            
            self.saveToPersistentStore()
            
        } catch {
            NSLog("no data being decoded")
            return
        }
        
        let userDefault = UserDefaults.standard
        userDefault.set(true, forKey: .loadDataValueKey)
    }
    
    
    func updateToFinished(question: Question) {
        if !question.isCompleted {
            question.isCompleted = true
        }
    }
    
    func updateToStudyMore(question: Question) {
        if question.isCompleted {
            question.isCompleted = false
        }
    }
    
    func fetchSingleQuestionFromPersistentStore(for questionPhotoString: String, context:NSManagedObjectContext) -> Question? {
        let fetchRequest: NSFetchRequest<Question> = Question.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "questionPhoto == %@", questionPhotoString)
        var result: Question? = nil
        context.performAndWait {
            do {
                result = try context.fetch(fetchRequest).first
            } catch {
                NSLog("Error fetching question from CoreData for \(questionPhotoString)")
            }
        }
        return result
    }
    
    
    //    func updateQuestionForFinishedQuestion(for question: Question) {
    //
    //        if let index = allQuestions.firstIndex(of: question) {
    //            if allQuestions[index].isCompleted == false {
    //                allQuestions[index].isCompleted = true
    //            }
    //        }
    //        self.saveToPersistentStore()
    //    }
    
    //    func updateQuestionForStudyMoreQuestion(for question: QuestionRepresentation) {
    //        if let index = allQuestions.firstIndex(of: question) {
    //            if allQuestions[index].isCompleted == true {
    //                allQuestions[index].isCompleted = false
    //            }
    //        }
    //        self.saveToPersistentStore()
    //    }
    
    func saveToPersistentStore() {
        do {
            let moc = CoreDataStack.shared.mainContext
            try moc.save()
        } catch {
            NSLog("Error saving managed object context:\(error)")
        }
    }
    

    //to get false value to reset this does not work i think it is becaue format is not unique to certain objects so it will bring objects infinitely??
    func fetchTrueQuestionsFromPersistentStore(for isCompleted: Bool, context:NSManagedObjectContext) -> [Question]? {
        let fetchRequest: NSFetchRequest<Question> = Question.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "isCompleted == %@", isCompleted)
        var result: [Question]? = nil
        context.performAndWait {
            do {
                result = try context.fetch(fetchRequest)
            } catch {
                NSLog("Error fetching question from CoreData for \(isCompleted)")
            }
        }
        return result
    }
}

extension String {
    static var loadDataValueKey = "loadDataValueKey"
}
