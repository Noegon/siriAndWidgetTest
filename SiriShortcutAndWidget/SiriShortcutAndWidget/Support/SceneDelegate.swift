//
//  SceneDelegate.swift
//  SiriShortcunAndWidget
//
//  Created by astafeev on 11/10/20.
//

import UIKit
import Intents
import WidgetKit
import AddWordKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    // MARK: - Main logic
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        
        if userActivity.interaction?.intent is AddWordIntent {

            if let windowScene = scene as? UIWindowScene {
                self.window = UIWindow(windowScene: windowScene)
                let storyboard = UIStoryboard(name: Constants.Storyboard.Main, bundle: nil)
                let initialViewController = storyboard.instantiateViewController(withIdentifier: Constants.ViewController.WordListViewController) as! WordListViewController
                self.window!.rootViewController = initialViewController
                self.window!.makeKeyAndVisible()
            }
        }
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Allows to force widget update after re-opening Application
        WidgetCenter.shared.reloadTimelines(ofKind: Constants.widgetKindName)
    }
}

