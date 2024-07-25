//
//  RepositoryListViewController.swift
//  GithubReposSearcher
//
//  Created by Viktor Drykin on 24.07.2024.
//

import UIKit
import Combine
import SafariServices

class RepositoryListViewController: UIViewController {
    
    enum Constant {
        static let userName = "Apple"
    }
    
    var viewModel: RepositoryListViewModel?
    var cancellables = Set<AnyCancellable>()
    var repositories = [Repository]()
    
    private lazy var navigationTitle: NavigationNameView = {
        let view = NavigationNameView()
        return view
    }()
    
    private lazy var tableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var loadingIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .gray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.searchRepositories(for: Constant.userName)
    }
    
    private func setup() {
        viewModel?.$state
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] state in
                self?.configure(with: state)
            })
            .store(in: &cancellables)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationTitle.set(title: Constant.userName)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationTitle)
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.reuseIdentifierKey)
        tableView.delegate = self
        tableView.dataSource = self
        initLayout()
    }
    
    private func configure(with state: RepositoryListViewModel.State) {
        self.repositories = []
        switch state {
        case .loading:
            tableView.isHidden = true
            startLoadingIndicator()
        case .loaded(let repositories):
            stopLoadingIndicator()
            tableView.isHidden = false
            self.repositories = repositories
            tableView.reloadData()
        case .failed(let message):
            stopLoadingIndicator()
            tableView.isHidden = true
            showAlert(with: message)
            
        }
    }
    
    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func initLayout() {
        view.addSubview(tableView)
        view.addSubview(loadingIndicatorView)
        
        tableView.pin(to: view)
        NSLayoutConstraint.activate([
            loadingIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func startLoadingIndicator() {
        loadingIndicatorView.isHidden = false
        loadingIndicatorView.startAnimating()
    }
    
    private func stopLoadingIndicator() {
        loadingIndicatorView.isHidden = true
        loadingIndicatorView.stopAnimating()
    }
}

extension RepositoryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = RepositoriesHeaderTableView(frame: .zero)
        header.set(title: "Repositories")
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.reuseIdentifierKey, for: indexPath)
        cell.selectionStyle = .none
        if let cell = cell as? RepositoryTableViewCell {
            let repository = repositories[indexPath.row]
            cell.set(title: repository.title, description: repository.description)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        guard let url = repository.url else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}
