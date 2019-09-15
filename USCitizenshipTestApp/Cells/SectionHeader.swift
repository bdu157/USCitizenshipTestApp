//
//  SectionHeader.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/13/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

class SectionHeader: UICollectionReusableView {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!
    
    var section: Section! {
        didSet {
            titleLabel?.text = "Studying..."   //add animation ......
            countLabel?.text = "\(section.count)/100"
        }
    }
    
}
