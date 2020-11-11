//
//  UserDefaults+DataSource.swift
//  SiriShortcutAndWidget
//
//  Created by astafeev on 11/10/20.
//

import Foundation

extension UserDefaults {
    
    enum StorageKeys: String {
        case words
    }
    
    static let dataSuite = { () -> UserDefaults in
        guard let dataSuite = UserDefaults(suiteName: Constants.AppGroup) else {
             fatalError("Could not load UserDefaults for app group \(Constants.AppGroup)")
        }
        
        return dataSuite
    }()
}
