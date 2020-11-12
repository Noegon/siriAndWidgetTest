//
//  WordsDataManager.swift
//  SiriShortcutAndWidget
//
//  Created by astafeev on 11/10/20.
//

import Foundation
import Intents
import WidgetKit

/// A concrete `DataManager` implementation for reading and writing data of type `[String]`.
public class WordsDataManager: DataManager<[String]> {

    public convenience init() {
        let storageInfo = UserDefaultsStorageDescriptor(key: UserDefaults.StorageKeys.words.rawValue,
                                                        keyPath: \UserDefaults.words)
        self.init(storageDescriptor: storageInfo)
    }
    
    override func deployInitialData() {
        dataAccessQueue.sync {
            // Order history is empty the first time the app is used.
            managedData = []
        }
    }
}

extension WordsDataManager {
    
    /// Convenience method to access the data with a property name that makes sense in the caller's context.
    public var words: [String] {
        return dataAccessQueue.sync {
            return managedData
        }
    }
    
    /// Stores the order in the data manager.
    public func addWord(_ word: String, compleationHandler: (() -> ())? = nil) {
        //  Access to `managedDataBackingInstance` is only valid on `dataAccessQueue`.
        dataAccessQueue.sync {
            managedData.insert(word, at: 0)
        }
        
        //  Access to UserDefaults is gated behind a separate access queue.
        writeData(compleationHandler: compleationHandler)
    }
    
    /// Deletes desired word from the data manager.
    public func removeWord(_ word: String, compleationHandler: (() -> ())? = nil) {
        // Access to `managedDataBackingInstance` is only valid on `dataAccessQueue`.
        // Filtering data to get all but unwanted entity
        dataAccessQueue.sync {
            managedData = managedData.filter({ (currentWord) in
                word.lowercased() != currentWord.lowercased()
            })
        }
        
        //  Access to UserDefaults is gated behind a separate access queue.
        writeData(compleationHandler: compleationHandler)
    }
    
    public func lastWords(amount: Int = 3) -> [String] {
        var wordArray = words
        if amount > wordArray.count {
            let stubStrings = Array<String>(repeating: "--", count: amount - wordArray.count)
            wordArray.append(contentsOf: stubStrings)
        }
        
        return Array<String>(wordArray.dropLast(wordArray.count - amount))
    }
}

/// Enables observation of `UserDefaults` for the `orderHistory` key.
private extension UserDefaults {
    
    @objc var words: Data? {
        return data(forKey: StorageKeys.words.rawValue)
    }
}

