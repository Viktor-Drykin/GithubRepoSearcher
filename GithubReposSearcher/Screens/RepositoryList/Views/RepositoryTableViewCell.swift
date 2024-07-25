//
//  RepositoryTableViewCell.swift
//  GithubReposSearcher
//
//  Created by Viktor Drykin on 25.07.2024.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    static let reuseIdentifierKey = "RepositoryTableViewCell"
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.textColor = Colors.title
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = Colors.subtitle
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10;
        view.layer.masksToBounds = true;
        return view
    }()

    private lazy var containerStackViewView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 8
        view.axis = .vertical
        //view.backgroundColor = Colors.background
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.layer.cornerRadius = 10;
        //view.layer.masksToBounds = true;
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        descriptionLabel.text = ""
    }
    
    private func setup() {
        contentView.addSubview(containerView)
        containerView.addSubview(containerStackViewView)
        containerStackViewView.addArrangedSubview(nameLabel)
        containerStackViewView.addArrangedSubview(descriptionLabel)
        
        containerView.pin(to: contentView, edgeInset: .init(top: 16, left: 20, bottom: 0, right: 20))
        containerStackViewView.pin(to: containerView, edgeInset: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    func set(title: String, description: String?) {
        nameLabel.text = title
        descriptionLabel.text = description
        descriptionLabel.isHidden = description == nil ? true : false
    }
}
