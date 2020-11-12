//
//  InteroperationalNotificationListener.swift
//  TestWidgetExtension
//
//  Created by astafeev on 11/12/20.
//

import Foundation
import CoreFoundation
import WidgetKit

final public class InteroperationalNotificationListener: NSObject {
    
    // the inter-process NotificationCenter
    private let center = CFNotificationCenterGetDarwinNotifyCenter()
    private var listenersStarted = false
    
    public override init() {
        super.init()
        // listen for an action in the Share Extension
        startListeners()
    }

    deinit {
        // don't listen anymore
        stopListeners()
    }

    //    MARK: listening
    fileprivate func startListeners() {
        if !listenersStarted {
            self.listenersStarted = true
            CFNotificationCenterAddObserver(center, Unmanaged.passRetained(self).toOpaque(),
            { (center, observer, name, object, userInfo) in
                // send the equivalent internal notification
                WidgetCenter.shared.reloadTimelines(ofKind: Constants.widgetKindName)
            }, Constants.DBKey.DBNotificationKey.dataChanged as CFString
            , nil
            , .deliverImmediately)
        }
    }

    fileprivate func stopListeners() {
        if listenersStarted {
            CFNotificationCenterRemoveEveryObserver(center, Unmanaged.passRetained(self).toOpaque())
            listenersStarted = false
        }
    }
}
