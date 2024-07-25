//
//  NavigationNameView.swift
//  GithubReposSearcher
//
//  Created by Viktor Drykin on 25.07.2024.
//

import UIKit

class NavigationNameView: UIView {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.navigationBarTitle
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
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
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        nameLabel.pin(to: self, edgeInset: .init(top: 0, left: 4, bottom: 0, right: 0))
    }
    
    func set(title: String) {
        nameLabel.text = title
    }
    
}
