//
//  Question.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/2/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

struct Question: Codable {
    let questionPhoto: String
    let isCompleted: Bool
    let answer: String
}
