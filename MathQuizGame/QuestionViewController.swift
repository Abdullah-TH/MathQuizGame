//
//  QuestionViewController.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 18/10/2020.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let question: String
    let options: [String]
    
    init(question: String, options: [String]) {
        self.question = question
        self.options = options
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self 
        headerLabel.text = question
    }

}

extension QuestionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    
}
