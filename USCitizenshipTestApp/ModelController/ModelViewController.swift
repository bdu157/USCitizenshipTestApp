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
        
        let userDefaults = UserDefaults.standard
        let value = userDefaults.bool(forKey: .loadDataValueKey)
        if !value {
            self.loadData()
        } 
    }
    
    
    //MARK: Setting the data - bringing the data from questions.json and saving them into persistentStore(coreData)
    let jsonUrl = Bundle.main.url(forResource: "questions", withExtension: "json")
    
    private func loadData() {
        
        do {
            let jsonData = try Data(contentsOf: jsonUrl!)
            let allQuestions = try JSONDecoder().decode([QuestionRepresentation].self, from: jsonData)
            
            for question in allQuestions {
                Question(questionNumber: question.questionNumber, question: question.question, isCompleted: question.isCompleted, answer: question.answer)
            }
            
            self.saveToPersistentStore()
            
        } catch {
            NSLog("no data being decoded")
            return
        }
        
        let userDefault = UserDefaults.standard
        userDefault.set(true, forKey: .loadDataValueKey)
    }
    
    
    //MARK: Update isCompleted - coreData - collectionView
    //update for cards that user needs to study more
    //fetchQuestionFromthePersistentStore <- updateToFinished <- save (performAndWait)
    func studyMore(for question: Question) {
        let backgroundContext = CoreDataStack.shared.container.newBackgroundContext()
        backgroundContext.performAndWait {
            //getting the specific object from persistentStore - CoreData
            if let object = self.fetchSingleQuestionFromPersistentStore(for: question.questionNumber!, context: backgroundContext) {
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
    //update for cards that user finishes studying
    func finished(for question: Question) {
        let backgroundContext = CoreDataStack.shared.container.newBackgroundContext()
        backgroundContext.performAndWait {
            if let object = self.fetchSingleQuestionFromPersistentStore(for: question.questionNumber!, context: backgroundContext) {
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
    
    
    //MARK: Private methods for updating datas in persistentStore
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
    //fetch question from persistent store, using NSPredicate
    private func fetchSingleQuestionFromPersistentStore(for questionPhotoString: String, context:NSManagedObjectContext) -> Question? {
        let fetchRequest: NSFetchRequest<Question> = Question.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "questionNumber == %@", questionPhotoString)
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
    //save updated data into background Context
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
    
    
    //Extra - NSPredicate for resetting datas//
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

