//
//  DataManager.swift
//  SiriShortcutAndWidget
//
//  Created by astafeev on 11/10/20.
//

import Foundation


class DataManager {
    
    static let shared = DataManager()
    
    private init() { }
    
    private var databaseQueue = DispatchQueue(label: "UserDefaults",
                                              qos: .userInitiated,
                                              attributes: [.concurrent])
    
    private let userDefaults: UserDefaults = UserDefaults(suiteName: Constants.appGroup)!
    
    var shortCut: String {
        get {
            databaseQueue.sync {
                return userDefaults.string(forKey: Constants.DBKey.shortcutPhrase) ?? Constants.defaultShortcut
            }
        }
        set {
            databaseQueue.async(flags: [.barrier]) { [weak self] in
                self?.userDefaults.setValue(newValue, forKey: Constants.DBKey.shortcutPhrase)
            }
        }
    }
    
    var words: Array<String> {
        get {
            return databaseQueue.sync {
                userDefaults.stringArray(forKey: Constants.DBKey.wordSet) ?? []
            }
        }
        set {
            databaseQueue.async(flags: [.barrier]) { [weak self] in
                self?.userDefaults.set(Array<String>(newValue), forKey: Constants.DBKey.wordSet)
            }
        }
    }
    
    func addWord(_ word: String) {
        var wordsArray = words
        wordsArray.append(word)
        words = wordsArray
        notifyClientsDataChanged()
    }
    
    /// Notifies clients the data changed by posting a `Notification` with the key `Constants.DBKey.DBNotificationKey.dataChanged`
    private func notifyClientsDataChanged() {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: Constants.DBKey.DBNotificationKey.dataChanged),
                                                     object: self))
    }
}
