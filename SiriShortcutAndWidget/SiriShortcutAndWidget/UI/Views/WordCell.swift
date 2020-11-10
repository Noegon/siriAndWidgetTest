//
//  WordCell.swift
//  SiriShortcutAndWidget
//
//  Created by astafeev on 11/10/20.
//

import UIKit

class WordCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    func configure(withTitle title: String?) {
        titleLabel.text = title
        titleLabel.textColor = UIColor.mainTextColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
    }
}
