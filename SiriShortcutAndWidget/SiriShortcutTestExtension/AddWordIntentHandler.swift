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
    
    func resolveWord(for intent: AddWordIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let word = intent.word, !word.isEmpty else {
            completion(INStringResolutionResult.needsValue())
            return
        }

        completion(INStringResolutionResult.success(with: word))
    }
    
    func handle(intent: AddWordIntent, completion: @escaping (AddWordIntentResponse) -> Void) {
        WordsDataManager().addWord(intent.word!)
        
//        InteroperationalNotificationEvent.post() // allows to send messages or flags between processes
        
        completion(AddWordIntentResponse.success(resultWord: intent.word!))
    }
}
