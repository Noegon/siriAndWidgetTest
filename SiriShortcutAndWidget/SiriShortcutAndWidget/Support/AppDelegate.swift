//
//  AppDelegate.swift
//  SiriShortcunAndWidget
//
//  Created by astafeev on 11/10/20.
//

import UIKit
import AddWordKit
import WidgetKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let interoperationalNotificationListener = InteroperationalNotificationListener()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

//final public class InteroperationalNotificationListener1: NSObject {
//    
//    // the inter-process NotificationCenter
//    private let center = CFNotificationCenterGetDarwinNotifyCenter()
//    private var listenersStarted = false
//    
//    public override init() {
//        super.init()
//        // listen for an action in the Share Extension
//        startListeners()
//    }
//
//    deinit {
//        // don't listen anymore
//        stopListeners()
//    }
//
//    //    MARK: listening
//    fileprivate func startListeners() {
//        if !listenersStarted {
//            self.listenersStarted = true
//            CFNotificationCenterAddObserver(center, Unmanaged.passRetained(self).toOpaque(),
//            { (center, observer, name, object, userInfo) in
//                // send the equivalent internal notification
//                WidgetCenter.shared.reloadTimelines(ofKind: Constants.widgetKindName)
//            }, Constants.DBKey.DBNotificationKey.dataChanged as CFString
//            , nil
//            , .deliverImmediately)
//        }
//    }
//
//    fileprivate func stopListeners() {
//        if listenersStarted {
//            CFNotificationCenterRemoveEveryObserver(center, Unmanaged.passRetained(self).toOpaque())
//            listenersStarted = false
//        }
//    }
//}
