//
//  Router.swift
//  GithubReposSearcher
//
//  Created by Viktor Drykin on 25.07.2024.
//

import UIKit

class Router {
    
    let window: UIWindow?
    private let navigationController : UINavigationController?

    init(window: UIWindow?) {
        self.window = window
        navigationController = UINavigationController()
    }

    func start() {
        let viewController = ViewController()
        navigationController?.viewControllers = [viewController]
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }

    func runUserInputScreen() {
        let viewController = ViewController()
        navigationController?.viewControllers = [viewController]
    }
}
