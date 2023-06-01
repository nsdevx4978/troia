//
//  FetchAPI.swift
//  FlickrDemo
//
//  Created by ervinaydin on 01/06/2023.
//

import Foundation
import Combine

protocol Fetchable {
    func fetch<T>(with urlComponent: URLComponents, session: URLSession) -> AnyPublisher<T,APIError> where T: Decodable
}

extension Fetchable {
    func fetch<T>(with urlComponent: URLComponents, session: URLSession) -> AnyPublisher<T,APIError> where T: Decodable {
        guard let urlString = urlComponent.url?.absoluteString.removingPercentEncoding, let url = URL(string: urlString) else {
            return Fail(error: APIError.request(message: "Invalid URL")).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
          .mapError { error in
             APIError.network(message: error.localizedDescription)
          }
          .flatMap(maxPublishers: .max(1)) { pair in
            decode(pair.data)
          }
          .eraseToAnyPublisher()
    }
}

