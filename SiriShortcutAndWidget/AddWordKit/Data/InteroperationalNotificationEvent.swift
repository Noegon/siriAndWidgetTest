//
//  InteroperationalNotificationEvent.swift
//  SiriShortcutTestExtension
//
//  Created by astafeev on 11/12/20.
//

import CoreFoundation

final public class InteroperationalNotificationEvent: NSObject {
    public static func post() {
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),
                                             CFNotificationName(rawValue: Constants.DBKey.DBNotificationKey.dataChanged as CFString),
                                             nil, nil, true)
    }
}
