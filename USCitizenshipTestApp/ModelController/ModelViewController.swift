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
    
    //MARK: Update coreData - collectionView
    //updateToFinished
    //start with fetchQuestionFromthePersistentStore <- updateToFinished <- save (performAndWait - sync)
    func studyMore(for question: Question) {
        let backgroundContext = CoreDataStack.shared.container.newBackgroundContext()
        backgroundContext.performAndWait {
            //getting the specific object from persistentStore - CoreData
            if let object = self.fetchSingleQuestionFromPersistentStore(for: question.questionPhoto!, context: backgroundContext) {
                self.updateToStudyMore(question: object)
            } else {
                print("there is an error in updating question object from persistent store")
            }
            
            do {
                try self.saveToPersistentStorebgcontext(context: backgroundContext)
            } catch {
                NSLog("There is an error in saving data into backgroundContext")
            }
        }
    }
    
    
    //updateToStudyMore
    func finished(for question: Question) {
        let backgroundContext = CoreDataStack.shared.container.newBackgroundContext()
        backgroundContext.performAndWait {
            if let object = self.fetchSingleQuestionFromPersistentStore(for: question.questionPhoto!, context: backgroundContext) {
                self.updateToFinished(question: object)
            } else {
                print("there is an error in updating question object from persistent store")
            }
            do {
                try self.saveToPersistentStorebgcontext(context: backgroundContext)
            } catch {
                NSLog("There is an error in saving data into backgroundContext")
            }
        }
    }
    
    //MARK: - private methods for updating datas in persistentStore
    private func updateToFinished(question: Question) {
        if !question.isCompleted {
            question.isCompleted = true
        }
    }
    private func updateToStudyMore(question: Question) {
        if question.isCompleted {
            question.isCompleted = false
        }
    }
    private func fetchSingleQuestionFromPersistentStore(for questionPhotoString: String, context:NSManagedObjectContext) -> Question? {
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
    private func saveToPersistentStorebgcontext(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws {
        var error: Error?
        context.performAndWait {
            do {
                try context.save()
            } catch let saveError {
                error = saveError
            }
        }
        if let error = error {throw error}
    }
    
    
    //saveToMaincontext
    func saveToPersistentStore() {
        do {
            let moc = CoreDataStack.shared.mainContext
            try moc.save()
        } catch {
            NSLog("Error saving managed object context:\(error)")
        }
    }
    
    
    
    
    
    /*
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
 */
}


extension String {
    static var loadDataValueKey = "loadDataValueKey"
}
