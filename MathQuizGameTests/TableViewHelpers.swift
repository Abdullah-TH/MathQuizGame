//
//  TableViewHelpers.swift
//  MathQuizGameTests
//
//  Created by Abdullah Althobetey on 19/10/2020.
//

import UIKit

extension UITableView {
    
    func cell(for row: Int) -> UITableViewCell? {
        self.dataSource?.tableView(
            self,
            cellForRowAt: IndexPath(row: row, section: 0)
        )
    }
    
    func title(for row: Int) -> String? {
        cell(for: row)?.textLabel?.text
    }
    
    func select(at row: Int) {
        let ip = IndexPath(row: row, section: 0)
        self.delegate?.tableView?(self, didSelectRowAt: ip)
    }
}
