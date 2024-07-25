//
//  RepositoriesServiceImpl.swift
//  GithubReposSearcher
//
//  Created by Viktor Drykin on 25.07.2024.
//

import Foundation

enum RepositoryServiceError: Error {
    case incorrectUserName
    case incorrectURL
}

class RepositoriesServiceImpl {

    private let apiService: APIServicePerformable
    private let userNamePlaceholder = "#USER_NAME#"
    private let urlPath = "https://api.github.com/users/#USER_NAME#/repos"
    init(apiService: APIServicePerformable) {
        self.apiService = apiService
    }
}

extension RepositoriesServiceImpl: RepositoriesService {

    func fetchRepos(with user: String) async throws -> [RepositoryDTO] {

        guard let encodedUser = user.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            throw RepositoryServiceError.incorrectUserName
        }

        let replacedURLPath = urlPath.replacing(userNamePlaceholder, with: encodedUser, maxReplacements: 1)

        guard let url = URL(string: replacedURLPath) else {
            throw RepositoryServiceError.incorrectURL
        }

        let request = URLRequest(url: url)
        let repositories: [RepositoryDTO] = try await apiService.perform(urlRequest: request)
        
        return repositories
    }
}
