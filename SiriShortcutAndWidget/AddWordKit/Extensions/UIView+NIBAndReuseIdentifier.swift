//
//  UIView+NIBAndReuseIdentifier.swift
//  SiriShortcutAndWidget
//
//  Created by astafeev on 11/10/20.
//

import UIKit

public extension UIView {

    static var nibName: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }

    static var reuseIdentifier: String {
        return nibName
    }
}
