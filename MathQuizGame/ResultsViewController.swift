//
//  ResultsViewController.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 19/10/2020.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let summary: String
    private let answers: [String]
    
    init(summary: String, answers: [String]) {
        self.summary = summary
        self.answers = answers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = summary
    }

}
