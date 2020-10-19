//
//  ResultsViewController.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 19/10/2020.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    private let summary: String
    
    init(summary: String) {
        self.summary = summary
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
