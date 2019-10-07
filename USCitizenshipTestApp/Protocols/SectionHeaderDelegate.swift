//
//  sectionHeaderProtocol.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/20/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

//work on this later with confetti
protocol SectionHeaderDelegate {
    //show confetti
    func showConfettiAnimation()
    
    //UIAlerts
    func showAlertTwentyFive()
    func showAlertFifty()
    func showAlertSeventyFive()
}
