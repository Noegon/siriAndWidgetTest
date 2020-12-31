//
//  ResultViewController.swift
//  AddWordUIExtension
//
//  Created by astafeev on 11/10/20.
//

import UIKit
import AddWordKit

class ResultViewController: UIViewController {
    
    private let intent: AddWordIntent

    @IBOutlet var resultView: ResultView!

    init(for addWordIntent: AddWordIntent) {
        intent = addWordIntent
        super.init(nibName: "ResultViewController", bundle: Bundle(for: ResultViewController.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultView.addedWordLabel.text = "\((intent.word ?? "unknown") + "-" + (intent.wordFromList ?? "unknown"))"
    }
}

class ResultView: UIView {
    @IBOutlet weak var addedWordLabel: UILabel!
}
