//
//  TestWidgetManager.swift
//  TestWidgetExtension
//
//  Created by astafeev on 11/11/20.
//

import Foundation

class TestWidgetManager {
    
    private let wordManager = WordsDataManager()

    static let shared = TestWidgetManager()
    
    func lastWords(amount: Int = 3) -> [String] {
        var wordArray = wordManager.words
        if amount > wordArray.count {
            let stubStrings = Array<String>(repeating: "--", count: amount - wordArray.count)
            wordArray.append(contentsOf: stubStrings)
        }
        
        return Array<String>(wordArray.dropLast(wordArray.count - amount))
    }
}
