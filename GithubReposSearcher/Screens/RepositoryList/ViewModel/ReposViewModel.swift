//
//  RepositoryListViewModel.swift
//  GithubReposSearcher
//
//  Created by Viktor Drykin on 25.07.2024.
//

import Foundation

final class RepositoryListViewModel {

    enum State {
        case loading
        case loaded([Repository])
        case failed(message: String)
    }

    enum Constant {
        static let user = "Apple"
        static let noRepos = "There are no repositories"
        static let invalidStatusCodeError = "Error: invalidStatusCode"
        static let failedToDecodeError = "Error: failedToDecode"
        static let incorrectUserNameError = "Error: incorrectUserName"
        static let unknownError = "Error: something went wrong"
    }

    @Published var state: State = .loading

    private let repositoriesService: RepositoriesService

    init(repositoriesService: RepositoriesService) {
        self.repositoriesService = repositoriesService
    }

    func searchRepositories() {
        state = .loading
        Task {
            do {
                let repos = try await repositoriesService.fetchRepos(with: Constant.user)
                if repos.isEmpty {
                    state = .failed(message: Constant.noRepos)
                }
                state = .loaded(repos.map(Repository.init))
            } catch {
                state = state(for: error)
            }
        }
    }

    private func state(for error: Error) -> State {
        let errorMessage: String = {
            switch error {
            case RepositoryServiceError.invalidStatusCode:
                return Constant.invalidStatusCodeError
            case RepositoryServiceError.failedToDecode:
                return Constant.failedToDecodeError
            case RepositoryServiceError.incorrectUserName:
                return Constant.incorrectUserNameError
            default:
                return Constant.unknownError
            }
        }()
        return .failed(message: errorMessage)
    }
}
