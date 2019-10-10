//
//  Question+Convenience.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/24/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import CoreData
//this app is not creating any new value and this is just for putting all datas (jsonfile) into persistentStore(coreData)

extension Question {
    @discardableResult convenience init(questionPhoto: String, isCompleted: Bool, answer: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.questionPhoto = questionPhoto
        self.isCompleted = isCompleted
        self.answer = answer
    }
}

