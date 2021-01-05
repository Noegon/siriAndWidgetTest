//
//  AddWordIntentHandler.swift
//  SiriShortcutTestExtension
//
//  Created by astafeev on 11/10/20.
//

import Foundation
import Intents
import WidgetKit
import AddWordKit
import os.log

class AddWordIntentHandler: NSObject, AddWordIntentHandling {
    
    // MARK: - Data providing methods
    
    func provideWordFromListOptionsCollection(for intent: AddWordIntent,
                                              searchTerm: String?,
                                              with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void) {
        guard intent.groupingParameterType != .unknown else {
            completion(nil, nil)
            return
        }
        
        completion(INObjectCollection<NSString>(items: Constants.predefinedWordList.map({ (word) -> NSString in
            return word as NSString
        })), nil)
        return
    }
    
    func provideWordFromTaggedListOptionsCollection(for intent: AddWordIntent,
                                                    searchTerm: String?,
                                                    with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void) {
        guard intent.groupingParameterType != .unknown else {
            completion(nil, nil)
            return
        }
        
        if let parameter = intent.taggedParameter {
            completion(INObjectCollection<NSString>(items: (Constants.taggedWordList[parameter]?.map({ (word) -> NSString in
                return word as NSString
            })) ?? [NSString]()), nil)
            return
        } else {
            completion(nil, nil)
        }
    }
    
    func provideWordFromGroupedListOptionsCollection(for intent: AddWordIntent,
                                                     searchTerm: String?,
                                                     with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void) {
        guard intent.groupingParameterType != .unknown else {
            completion(nil, nil)
            return
        }
        
        if let parameter = intent.groupingParameter {
            completion(INObjectCollection<NSString>(items: (Constants.groupedWordList[parameter]?.map({ (word) -> NSString in
                return word as NSString
            })) ?? [NSString]()), nil)
            return
        } else {
            completion(nil, nil)
        }
    }
    
    
    func provideTaggedParameterOptionsCollection(for intent: AddWordIntent, with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void) {
        completion(INObjectCollection<NSString>(items: Constants.tags.map({ (word) -> NSString in
            return word as NSString
        })), nil)
    }
    
    func provideGroupingParameterOptionsCollection(for intent: AddWordIntent, with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void) {
        completion(INObjectCollection<NSString>(items: Constants.groups.map({ (word) -> NSString in
            return word as NSString
        })), nil)
    }
    
    // MARK: - Resolving methods
    
    private func actualWordList(for intent: AddWordIntent) -> [String] {
        var list: [String] = []
        if intent.groupingParameterType == .noParameter || intent.groupingParameterType == .unknown {
            list = Constants.predefinedWordList
        } else if intent.groupingParameterType == .tag, let parameter = intent.taggedParameter {
            list = Constants.taggedWordList[parameter] ?? []
        } else if intent.groupingParameterType == .group, let parameter = intent.groupingParameter {
            list =  Constants.groupedWordList[parameter] ?? []
        }
        return list
    }
    
    private func actualSecondWord(for intent: AddWordIntent) -> String? {
        var word: String? = nil
        if intent.groupingParameterType == .noParameter || intent.groupingParameterType == .unknown {
            word = intent.wordFromList
        } else if intent.groupingParameterType == .tag, let parameter = intent.taggedParameter {
            word = intent.wordFromTaggedList
        } else if intent.groupingParameterType == .group, let parameter = intent.groupingParameter {
            word = intent.wordFromGroupedList
        }
        return word
    }
    
    private func resolveWordFromAnyList(for intent: AddWordIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        let list = actualWordList(for: intent)
        
        guard let wordListWord = actualSecondWord(for: intent),
              !wordListWord.isEmpty
        else {
            completion(INStringResolutionResult.disambiguation(with: list))
            return
        }
        
        if !list.contains(wordListWord) {
            completion(INStringResolutionResult.disambiguation(with: list))
            return
        }

        completion(INStringResolutionResult.success(with: wordListWord))
    }
    
    func resolveWordFromList(for intent: AddWordIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        resolveWordFromAnyList(for: intent, with: completion)
    }
    
    func resolveWordFromTaggedList(for intent: AddWordIntent,
                                   with completion: @escaping (INStringResolutionResult) -> Void) {
        resolveWordFromAnyList(for: intent, with: completion)
    }
    
    func resolveWordFromGroupedList(for intent: AddWordIntent,
                                    with completion: @escaping (INStringResolutionResult) -> Void) {
        resolveWordFromAnyList(for: intent, with: completion)
    }
    
    func resolveWord(for intent: AddWordIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let word = intent.word, !word.isEmpty else {
            completion(INStringResolutionResult.needsValue())
            return
        }

        completion(INStringResolutionResult.success(with: word))
    }
    
    func resolveGroupingParameterType(for intent: AddWordIntent, with completion: @escaping (GroupingParameterTypeResolutionResult) -> Void) {
        completion(GroupingParameterTypeResolutionResult.success(with: intent.groupingParameterType))
    }
    
    func resolveGroupingParameter(for intent: AddWordIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard intent.groupingParameterType != .unknown, intent.groupingParameterType != .noParameter else {
            completion(INStringResolutionResult.success(with: ""))
            return
        }
        
        if let parameter = intent.groupingParameter, Constants.groups.contains(parameter) {
            completion(INStringResolutionResult.success(with: parameter))
            return
        } else {
            completion(INStringResolutionResult.disambiguation(with: Constants.groups))
            return
        }
    }
    
    func resolveTaggedParameter(for intent: AddWordIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard intent.groupingParameterType != .unknown, intent.groupingParameterType != .noParameter else {
            completion(INStringResolutionResult.success(with: ""))
            return
        }
        
        os_log("%{public}@",
               log: OSLog(subsystem: "com.noegon.SiriShortcutsAndWidgets.SiriShortcutTestExtension",
                          category: "SiriShortcutTestExtension"),
               type: OSLogType.info,
               "Intent tagged parameter: \(intent.taggedParameter ?? "nil")")
        
        if let parameter = intent.taggedParameter, Constants.tags.contains(parameter) {
            completion(INStringResolutionResult.success(with: parameter))
            return
        } else {
            completion(INStringResolutionResult.disambiguation(with: Constants.tags))
            return
        }
    }
    
    // MARK: - Handling results methods
    
    func handle(intent: AddWordIntent, completion: @escaping (AddWordIntentResponse) -> Void) {
        guard let word = intent.word,
              let wordFromList = actualSecondWord(for: intent),
              !word.isEmpty,
              !wordFromList.isEmpty
        else {
//            completion(AddWordIntentResponse.success(resultWord: "unknown"))
            completion(AddWordIntentResponse.failure(resultWord: "unknown"))
            return
        }
        let resultWord = word + "-" + wordFromList
        WordsDataManager().addWord(resultWord)
        
//        InteroperationalNotificationEvent.post() // allows to send messages or flags between processes\
        
        // TODO: uncomment strings below if you want to complete with showing result in the Application
        let activity = NSUserActivity(activityType: NSStringFromClass(AddWordIntent.self))
        activity.addUserInfoEntries(from: ["word": intent.word ?? "",
                                           "wordFromList": intent.wordFromList ?? ""])
        completion(AddWordIntentResponse(code: .continueInApp, userActivity: activity)) // allows to open result in the app
        // TODO: uncomment string below if you want to complete with showing result in the UI extension
//        completion(AddWordIntentResponse.success(resultWord: resultWord))
    }
}
