//
//  RepositoriesHeaderTableView.swift
//  GithubReposSearcher
//
//  Created by Viktor Drykin on 25.07.2024.
//

import UIKit

class RepositoriesHeaderTableView: UIView {

    private lazy var nameLabel = {
        let label = UILabel()
        label.textColor = Colors.sectionHeader
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        backgroundColor = .white
        addSubview(nameLabel)
        nameLabel.pin(to: self, edgeInset: .init(top: 0, left: 20, bottom: 0, right: 0))
    }

    func set(title: String) {
        nameLabel.text = title
    }
}
