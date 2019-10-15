//
//  NotificationExtension.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 10/3/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

extension Notification.Name {
    static var needtoReloadData = Notification.Name("needtoReloadData")
    static var needtoResetData = Notification.Name("needtoResetData")
    static var needtoReloadDataForTheme = Notification.Name("needtoReloadDataForTheme")
    static var needtoReloadDataForReverseTheme = Notification.Name("needtoReloadDataForReverseTheme")
}
