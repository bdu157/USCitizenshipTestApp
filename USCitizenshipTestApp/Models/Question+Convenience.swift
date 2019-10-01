//
//  Question+Convenience.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/24/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import CoreData
//this is for initializing but we are not initializing anything in this app is just updating boolean on decoded file

extension Question {
    convenience init(questionPhoto: String, isCompleted: Bool, answer: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.questionPhoto = questionPhoto
        self.isCompleted = isCompleted
        self.answer = answer
    }
}

