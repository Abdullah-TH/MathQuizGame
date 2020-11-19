//
//  QuestionViewController.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 18/10/2020.
//

import UIKit

public class QuestionViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let reuseIdentifier = "OptionCell"
    
    let question: String
    let options: [String]
    private var selection: (String) -> Void
    
    public init(
        question: String,
        options: [String],
        selection: @escaping (String) -> Void
    ) {
        self.question = question
        self.options = options
        self.selection = selection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        headerLabel.text = question
    }

}

extension QuestionViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    private func dequeueCell(for tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) {
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
    }
}

extension QuestionViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection(options[indexPath.row])
    }
    
}
