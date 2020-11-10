//
//  UserDefaults+DataSource.swift
//  SiriShortcutAndWidget
//
//  Created by astafeev on 11/10/20.
//

import Foundation

extension UserDefaults {

    private static let AppGroup = "group.com.noegon.SiriShortcutsAndWidgets.Shared"
    
    enum StorageKeys: String {
        case words
    }
    
    static let dataSuite = { () -> UserDefaults in
        guard let dataSuite = UserDefaults(suiteName: AppGroup) else {
             fatalError("Could not load UserDefaults for app group \(AppGroup)")
        }
        
        return dataSuite
    }()
}
