//
//  QuestionViewController.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 18/10/2020.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    let question: String
    
    init(question: String) {
        self.question = question
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = question
    }

}
