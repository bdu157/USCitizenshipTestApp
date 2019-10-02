//
//  AppearanceHeler.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 10/2/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

//call this based on userDefault for notification for sender ison

enum AppearanceHelper {
    
    static var mainColorDarkBlue = #colorLiteral(red: 0.0995137468, green: 0.263354212, blue: 0.4718250036, alpha: 1)
    // set up appearance based on userDefaults being saved after choosing bright mode in setting
    static func setDefaultAppearance() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UINavigationBar.appearance().largeTitleTextAttributes = textAttributes
        
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.0995137468, green: 0.263354212, blue: 0.4718250036, alpha: 1)
        
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.0995137468, green: 0.263354212, blue: 0.4718250036, alpha: 1)
        UITabBar.appearance().tintColor = .white
    }
    
    static func setWhiteAppearance() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: mainColorDarkBlue]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UINavigationBar.appearance().largeTitleTextAttributes = textAttributes
        
        UINavigationBar.appearance().barTintColor = .white
        
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.0995137468, green: 0.263354212, blue: 0.4718250036, alpha: 1)
    }
}

