//
//  IntentHandler.swift
//  SiriShortcutTestExtension
//
//  Created by astafeev on 11/10/20.
//

import Intents
import AddWordKit

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        guard intent is AddWordIntent else {
            fatalError("Unhandled intent type: \(intent)")
        }
        return AddWordIntentHandler()
    }
}
