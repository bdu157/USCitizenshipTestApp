//
//  ThemeHelper.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 10/2/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

class ThemeHelper {
    
    init() {
        if themePreference == "White" {
            self.setThemePreferenceToWhite()
        }
    }
    
    func setThemePreferenceToWhite() {
        let userDefaults = UserDefaults.standard
        userDefaults.set("White", forKey: .themePreferenceKey)
    }
    
    var themePreference: String? {
        let themePreference = UserDefaults.standard
        return themePreference.string(forKey: .themePreferenceKey)
    }
}

extension String {
    static var themePreferenceKey = "themePreferenceKey"
}
