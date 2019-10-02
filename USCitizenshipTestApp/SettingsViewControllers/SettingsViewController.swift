//
//  SettingsViewController.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 10/2/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var switchButton: UISwitch!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateViews()
    }
    
    
    @IBAction func switchButtonTapped(_ sender: UISwitch) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(sender.isOn, forKey: .shouldShowWhiteTheme)
        NotificationCenter.default.post(name: .switchWasFlipped, object: self)
    }
    
    private func updateViews() {
        guard isViewLoaded else {return}
        let userDefaults = UserDefaults.standard
        switchButton.isOn = userDefaults.bool(forKey: .shouldShowWhiteTheme) //true otherwise false if there is no userDefault being saved(set) for this key: shouldShowWhiteTheme
        self.observeShouldShowWhiteTheme()
        
    }
    
    func observeShouldShowWhiteTheme() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeThemetoWhite(notification:)), name: .switchWasFlipped, object: nil)
    }
    
    @objc func changeThemetoWhite(notification: Notification) {
        //tabBar
        self.tabBarController?.tabBar.barTintColor = .white
        self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.0995137468, green: 0.263354212, blue: 0.4718250036, alpha: 1)
        
        //navigationBar
        let mainColorDarkBlue = #colorLiteral(red: 0.0995137468, green: 0.263354212, blue: 0.4718250036, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = .white
        let textAattributes = [NSAttributedString.Key.foregroundColor: mainColorDarkBlue]
        self.navigationController?.navigationBar.largeTitleTextAttributes = textAattributes
    }
}
