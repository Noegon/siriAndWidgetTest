//
//  AddWordIntentHandler.swift
//  SiriShortcutAndWidget
//
//  Created by astafeev on 11/10/20.
//

import Foundation
import Intents

class AddWordIntentHandler: NSObject, AddWordIntentHandling {
    func resolveWord(for intent: AddWordIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let word = intent.word, !word.isEmpty else {
            completion(INStringResolutionResult.needsValue())
            return
        }

        completion(INStringResolutionResult.success(with: word))
    }
    
    func handle(intent: AddWordIntent, completion: @escaping (AddWordIntentResponse) -> Void) {
        let wordManager = WordsDataManager()
        wordManager.addWord(intent.word!)
        
        completion(AddWordIntentResponse.success(resultWord: intent.word!))
    }
}
