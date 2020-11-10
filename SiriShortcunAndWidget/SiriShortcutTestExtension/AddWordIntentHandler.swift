//
//  AddWordIntentHandler.swift
//  SiriShortcutAndWidget
//
//  Created by astafeev on 11/10/20.
//

import Foundation
import Intents
import os.log

class AddWordIntentHandler: NSObject, AddWordIntentHandling {
    func resolveWord(for intent: AddWordIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let word = intent.word, !word.isEmpty else {
            os_log("Nothing happens!")
            completion(INStringResolutionResult.needsValue())
            return
        }

        completion(INStringResolutionResult.success(with: word))
    }
    
    func handle(intent: AddWordIntent, completion: @escaping (AddWordIntentResponse) -> Void) {
        os_log("Add new word: %@", intent.word!)
        let wordManager = WordsDataManager()
        wordManager.addWord(intent.word!)
        
        completion(AddWordIntentResponse.success(resultWord: intent.word!))
    }
}
