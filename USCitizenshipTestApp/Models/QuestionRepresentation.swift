//
//  QuestionRepresentation.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/24/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

struct QuestionRepresentation: Equatable, Codable {
    let questionPhoto: String
    var isCompleted: Bool
    let answer: String
}
