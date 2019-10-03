//
//  InfoViewController.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 10/2/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateNavBarTheme()
    }
    
    private func updateNavBarTheme() {
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: .shouldShowWhiteTheme) == true {
            //updateNavBar
            let mainColorBlue = #colorLiteral(red: 0.1721551418, green: 0.3156097233, blue: 0.4867617488, alpha: 1)
            let textAttributes = [NSAttributedString.Key.foregroundColor: mainColorBlue]
            self.navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
            self.navigationController?.navigationBar.barTintColor = .white
            
        } else {
            let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
            self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1721551418, green: 0.3156097233, blue: 0.4867617488, alpha: 1)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
