//
//  GameResultViewController.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 19/10/2020.
//

import UIKit

public class GameResultViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let summary: String
    public let answers: [Answer]
    
    public init(summary: String, answers: [Answer]) {
        self.summary = summary
        self.answers = answers
        super.init(nibName: nil, bundle: Bundle(for: Self.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CorrectAnswerCell.self, bundle: Bundle(for: Self.self))
        tableView.register(WrongAnswerCell.self, bundle: Bundle(for: Self.self))
        headerLabel.text = summary
    }

}

extension GameResultViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        return answer.wrongAnswer == nil ? correctAnswerCell(for: answer) : wrongAnswerCell(for: answer)
    }
    
    private func correctAnswerCell(for answer: Answer) -> UITableViewCell {
        let cell = tableView.dequeue(CorrectAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.answer
        return cell
    }
    
    private func wrongAnswerCell(for answer: Answer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WrongAnswerCell") as! WrongAnswerCell
        cell.questionLabel.text = answer.question
        cell.correctAnswerLabel.text = answer.answer
        cell.wrongAnswerLabel.text = answer.wrongAnswer
        return cell
    }
}

extension GameResultViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90 // just an estimation
    }
}
