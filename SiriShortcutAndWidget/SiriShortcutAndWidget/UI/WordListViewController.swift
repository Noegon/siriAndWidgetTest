//
//  WordListViewController.swift
//  SiriShortcunAndWidget
//
//  Created by astafeev on 11/10/20.
//

import UIKit
import IntentsUI
import AddWordKit

/// Implemented as usual MVC (or MVVM with minimal functionality) because current App is very tiny and Controller takes less than 200 rows
final class WordListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var siriButtonWrapperView: UIView!
    
    private var notificationToken: NSObjectProtocol?
    
    let wordManager = WordsDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add observer to update ViewController after changing Model value
        notificationToken = NotificationCenter.default.addObserver(
            forName: NSNotification.Name(rawValue: Constants.DBKey.DBNotificationKey.dataChanged),
            object: wordManager,
            queue: OperationQueue.main) { [weak self] (notification) in
                self?.tableView.reloadData()
            }

        addSiriButton(to: siriButtonWrapperView)
        
        // Register tableView cells
        tableView.registerNibForCell(WordCell.self)
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func addSiriButton(to view: UIView) {
        
        let button = INUIAddVoiceShortcutButton(style: .whiteOutline)
        button.shortcut = INShortcut(intent: intent)
        button.delegate = self
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        
        let leftConstraint = NSLayoutConstraint(item: button,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .left,
                                                multiplier: 1.0, constant: 15)
        let rightConstraint = NSLayoutConstraint(item: button,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .right,
                                                 multiplier: 1.0, constant: -15)
        view.addConstraints([leftConstraint, rightConstraint])
        leftConstraint.isActive = true
        rightConstraint.isActive = true
    }
}

extension WordListViewController: INUIAddVoiceShortcutButtonDelegate {
    
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController,
                 for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        addVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(addVoiceShortcutViewController, animated: true, completion: nil)
    }
    
    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController,
                 for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self
        editVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(editVoiceShortcutViewController, animated: true, completion: nil)
    }
}

extension WordListViewController: INUIAddVoiceShortcutViewControllerDelegate {
    
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController,
                                        didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension WordListViewController: INUIEditVoiceShortcutViewControllerDelegate {
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController,
                                         didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController,
                                         didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate implementation

extension WordListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 44 }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(actions: [makeDeleteContextualAction(forRowAt: indexPath)])
    }

    //MARK: - Contextual Actions helpers
    
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, swipeButtonView, completion) in
            if let word = self?.wordManager.words[indexPath.row] {
                self?.wordManager.removeWord(word)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}

// MARK: - UITableViewDataSource implementation

extension WordListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordManager.words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordCell.reuseIdentifier, for: indexPath) as! WordCell
        cell.configure(withTitle: wordManager.words[indexPath.row])
        return cell
    }
}

// MARK: - Private helper extension

private extension WordListViewController {
    var intent: AddWordIntent {
        let testIntent = AddWordIntent()
        testIntent.word = nil
        testIntent.suggestedInvocationPhrase = Constants.defaultShortcut
        return testIntent
    }
}
