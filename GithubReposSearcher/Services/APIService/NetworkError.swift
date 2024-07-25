//
//  NetworkError.swift
//  GithubReposSearcher
//
//  Created by Viktor Drykin on 25.07.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidStatusCode
    case failedToDecode
    case unknown
}
