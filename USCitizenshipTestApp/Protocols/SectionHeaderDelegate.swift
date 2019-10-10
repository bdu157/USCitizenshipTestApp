//
//  sectionHeaderProtocol.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/20/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

protocol SectionHeaderDelegate {
    //Show confetti
    func showConfettiAnimation()
    
    //UIAlert progress messages
    func showAlertTwentyFive()
    func showAlertFifty()
    func showAlertSeventyFive()
}
