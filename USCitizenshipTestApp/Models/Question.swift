//
//  Question.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/2/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

struct Question: Codable, Equatable {
    let questionPhoto: String
    var isCompleted: Bool
    let answer: String
}
