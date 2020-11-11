//
//  Constants.swift
//  SiriShortcutAndWidget
//
//  Created by astafeev on 11/10/20.
//

import Foundation

enum Constants {
    static let defaultShortcut = "Add word"
    
    static let widgetKindName = "TestWidget"
    
    enum DBKey {
        static let shortcutPhrase = "shortcutPhrase"
        static let wordSet = "wordSet"
        
        enum DBNotificationKey {
            static let dataChanged = "dataChanged"
        }
    }
    
    enum Storyboard {
        static let Main = "Main"
    }
    
    enum ViewController {
        static let WordListViewController = "WordListViewController"
    }
}
