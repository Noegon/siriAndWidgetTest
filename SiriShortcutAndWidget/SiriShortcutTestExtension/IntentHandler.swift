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
        // Add as many intent types as you need
        switch intent {
        case is AddWordIntent:
            return AddWordIntentHandler()
        default:
            fatalError("Unhandled intent type: \(intent)")
        }
    }
}
