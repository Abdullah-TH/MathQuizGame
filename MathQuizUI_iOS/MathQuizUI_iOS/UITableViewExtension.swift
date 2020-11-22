//
//  UITableViewExtension.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 20/10/2020.
//

import UIKit

extension UITableView {
    
    func register(_ type: UITableViewCell.Type, bundle: Bundle) {
        let className = String(describing: type)
        register(UINib(nibName: className, bundle: bundle), forCellReuseIdentifier: className)
    }
    
    func dequeue<T>(_ type: T.Type) -> T? {
        let className = String(describing: type)
        return dequeueReusableCell(withIdentifier: className) as? T
    }
}
