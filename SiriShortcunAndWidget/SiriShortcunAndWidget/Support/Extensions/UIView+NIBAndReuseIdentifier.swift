//
//  UIView+NIBAndReuseIdentifier.swift
//  SiriShortcutAndWidget
//
//  Created by astafeev on 11/10/20.
//

import UIKit

extension UIView {

    public static var nibName: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }

    public static var reuseIdentifier: String {
        return nibName
    }
}
