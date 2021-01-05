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
    
    public static let predefinedWordList = ["Apple", "Behemoth", "Cooler", "Drowned maid", "Equity",
                                            "Falcon", "Giant", "Herecy", "Ice", "Jorney", "Khung-Fu",
                                            "Lammoth", "Mammoth", "Nostromo", "Pineapple", "Quarter",
                                            "Rogue", "Sticker", "Troubleshooting", "Universum", "Valor",
                                            "Woodpecker", "Xenophobia", "Yippiee-Yaee", "Zanzibarh"]
    
    public static let tags: [String] = ["common", "additional", "special"]
    
    public static let groups: [String] = ["myGroup", "catalinGroup", "mariusGroup", "commonGroup"]
    
    public static let taggedWordList: [String: [String]] =
        ["common": ["Yippiee-Yaee", "Zanzibarh", "Herecy", "Ice", "Jorney", "Khung-Fu"],
         "additional": ["Quarter", "Rogue", "Sticker", "Troubleshooting", "Universum", "Valor", "Woodpecker", "Equity","Falcon", "Giant"],
         "special": ["Lammoth", "Mammoth", "Nostromo", "Pineapple", "Xenophobia", "Apple", "Behemoth", "Cooler", "Drowned maid"]]
    
    public static let groupedWordList: [String: [String]] =
        ["myGroup": ["Apple", "Behemoth", "Cooler", "Drowned maid", "Equity","Falcon"],
         "catalinGroup": ["Giant", "Herecy", "Ice", "Jorney", "Khung-Fu"],
         "mariusGroup": ["Lammoth", "Mammoth", "Nostromo", "Pineapple", "Quarter", "Rogue"],
         "commonGroup": ["Sticker", "Troubleshooting", "Universum", "Valor", "Woodpecker", "Xenophobia", "Yippiee-Yaee", "Zanzibarh"]]
    
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
