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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func switchButtonTapped(_ sender: UISwitch) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(sender.isOn, forKey: .shouldShowWhiteTheme)
        
        if sender.isOn {
            self.updateViewstoWhite()
            //NotificationCenter.default.post(name: .switchWasFlipped, object: self)
        } else if !sender.isOn {
            self.updateViewstoDefault()
        }
    }
    
    private func updateViews() {
        guard isViewLoaded else {return}
        let userDefaults = UserDefaults.standard
        switchButton.isOn = userDefaults.bool(forKey: .shouldShowWhiteTheme) //true otherwise false if there is no userDefault being saved(set) for this key: shouldShowWhiteTheme
    }
    
    private func updateViewstoWhite() {
        //tabBar
        self.tabBarController?.tabBar.barTintColor = .white
        self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.0995137468, green: 0.263354212, blue: 0.4718250036, alpha: 1)
        
        //navigationBar
        let mainColorDarkBlue = #colorLiteral(red: 0.0995137468, green: 0.263354212, blue: 0.4718250036, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = .white
        let textAattributes = [NSAttributedString.Key.foregroundColor: mainColorDarkBlue]
        self.navigationController?.navigationBar.largeTitleTextAttributes = textAattributes
    }
    
    private func updateViewstoDefault() {
        //tabBar
        self.tabBarController?.tabBar.barTintColor = #colorLiteral(red: 0.0995137468, green: 0.263354212, blue: 0.4718250036, alpha: 1)
        self.tabBarController?.tabBar.tintColor = .white
        
        //navigationBar
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.0995137468, green: 0.263354212, blue: 0.4718250036, alpha: 1)
        let textAattributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.largeTitleTextAttributes = textAattributes
    }
}
