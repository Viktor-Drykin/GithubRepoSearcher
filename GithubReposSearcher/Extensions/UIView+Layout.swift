//
//  UIView+Layout.swift
//  GithubReposSearcher
//
//  Created by Viktor Drykin on 25.07.2024.
//

import UIKit

extension UIView {
    func pin(to containerView: UIView, edgeInset: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: containerView.topAnchor, constant: edgeInset.top),
            bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -edgeInset.bottom),
            trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -edgeInset.right),
            leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: edgeInset.left)
        ])
    }
}
