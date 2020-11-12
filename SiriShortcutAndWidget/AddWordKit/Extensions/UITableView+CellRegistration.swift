//
//  UITableView+CellRegistration.swift
//  SiriShortcutAndWidget
//
//  Created by astafeev on 11/10/20.
//

import UIKit

public extension UITableView {

    /// Dequeue a cell whose identifier is `Cell.identifier`. Traps if the table is unable to deque a cell with the
    /// correct type.
    public func dequeueReusableCell<Cell: UITableViewCell>(_ cell: Cell.Type, for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Unable to deque cell of type \(Cell.self) with identifier \(Cell.reuseIdentifier)")
        }

        return cell
    }

    public func registerClassForCell(_ cell: UITableViewCell.Type) {
        register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
    }

    public func registerNibForCell(_ cell: UITableViewCell.Type, from bundle: Bundle? = nil) {
        register(UINib(nibName: cell.nibName, bundle: bundle), forCellReuseIdentifier: cell.reuseIdentifier)
    }
}
