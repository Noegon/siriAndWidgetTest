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

class AddWordIntentHandler: NSObject, AddWordIntentHandling {
    
    func provideWordFromListOptionsCollection(for intent: AddWordIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void) {
//        var counter = 1
        print(searchTerm)
        completion(INObjectCollection<NSString>(items: Constants.predefinedWordList.map({ (word) -> NSString in
//            let result = "\(counter) - \(word)" as NSString
//            counter += 1
//            return result
            return word as NSString
        })), nil)
    }
    
//    func provideWordFromListOptionsCollection(for intent: AddWordIntent,
//                                           with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void) {
////        var counter = 1
//        completion(INObjectCollection<NSString>(items: Constants.predefinedWordList.map({ (word) -> NSString in
////            let result = "\(counter) - \(word)" as NSString
////            counter += 1
////            return result
//            return word as NSString
//        })), nil)
//    }
    
    func resolveWordFromList(for intent: AddWordIntent, with completion: @escaping (AddWordWordFromListResolutionResult) -> Void) {
        guard let wordListWord = intent.wordFromList,
              !wordListWord.isEmpty
        else {
            completion(AddWordWordFromListResolutionResult.disambiguation(with: Constants.predefinedWordList))
            return
        }
        
        if !Constants.predefinedWordList.contains(wordListWord) {
//            completion(AddWordWordFromListResolutionResult.unsupported(forReason: .noListWord))
            completion(AddWordWordFromListResolutionResult.disambiguation(with: Constants.predefinedWordList))
            return
        }

        completion(AddWordWordFromListResolutionResult.success(with: wordListWord))
    }
    
    func resolveWord(for intent: AddWordIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let word = intent.word, !word.isEmpty else {
            completion(INStringResolutionResult.needsValue())
            return
        }

        completion(INStringResolutionResult.success(with: word))
    }
    
    func handle(intent: AddWordIntent, completion: @escaping (AddWordIntentResponse) -> Void) {
        guard let word = intent.word,
              let wordFromList = intent.wordFromList,
              !word.isEmpty,
              !wordFromList.isEmpty
        else {
            completion(AddWordIntentResponse.success(resultWord: "unknown"))
            return
        }
        let resultWord = word + "-" + wordFromList
        WordsDataManager().addWord(resultWord)
        
//        InteroperationalNotificationEvent.post() // allows to send messages or flags between processes
        
        completion(AddWordIntentResponse.success(resultWord: resultWord))
    }
}
