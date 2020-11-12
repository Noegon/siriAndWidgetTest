//
//  Constants.swift
//  SiriShortcutAndWidget
//
//  Created by astafeev on 11/10/20.
//

import Foundation

public enum Constants {
    
    public static let AppGroup = "group.com.noegon.SiriShortcutsAndWidgets.Shared"
    
    public static let defaultShortcut = "Add word"
    
    public static let widgetKindName = "TestWidget"
    
    public enum DBKey {
        public static let shortcutPhrase = "shortcutPhrase"
        public static let wordSet = "wordSet"
        
        public enum DBNotificationKey {
            public static let dataChanged = "dataChanged"
        }
    }
    
    public enum Storyboard {
        public static let Main = "Main"
    }
    
    public enum ViewController {
        public static let WordListViewController = "WordListViewController"
    }
}
