//
//  Launcher.swift
//  GithubReposSearcher
//
//  Created by Viktor Drykin on 25.07.2024.
//

import UIKit

class Launcher {
    
    let window: UIWindow?
    private let navigationController : UINavigationController?

    init(window: UIWindow?) {
        self.window = window
        navigationController = UINavigationController()
    }

    func start() {
        let viewController = RepositoryListViewController()
        let apiService = APIClient()
        let repositoriesService = RepositoriesServiceImpl(apiService: apiService)
        let viewModel = RepositoryListViewModel(repositoriesService: repositoriesService)
        viewController.viewModel = viewModel
        navigationController?.viewControllers = [viewController]
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
