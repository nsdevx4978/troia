//
//  PhotosAPI.swift
//  FlickrDemo
//
//  Created by ervinaydin on 01/06/2023.
//

import Foundation
import Combine

protocol PhotosFetchable {
    func fetchPhotosList() -> AnyPublisher<PhotoModel, APIError>
    func downloadPhoto(_ url: String) -> AnyPublisher<Data,APIError>
    func fetchContactPhotoList(nsid: String) -> AnyPublisher<PhotoModel, APIError>
}

class PhotosAPI {
    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
}

private extension PhotosAPI {
    struct ContactPhotosAPIComponent {
        struct PhotosAPIComponent {
            static let scheme = "https"
            static let host = try? EnvConfig.value(EnvConfig.YBS_HOST)
            //static let clientID = try? EnvConfig.value(EnvConfig.YBS_CLIENT_ID)
            static let path = "/services/rest/"
            
        }
    }
    
    func urlComponentForContactPhotosList(nsId: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = PhotosAPIComponent.scheme
        components.host = PhotosAPIComponent.host
        components.path = PhotosAPIComponent.path
        components.queryItems = [
            URLQueryItem(name: "method", value: "flickr.people.getPublicPhotos"),
            URLQueryItem(name: "api_key", value: PhotosAPIComponent.clientID ),
            URLQueryItem(name: "extras", value: "tags%2C+owner_name%2C+icon_server%2C+date_taken"),
            URLQueryItem(name: "user_id", value: nsId),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1"),
        ]
        
        return components
    }
    
    struct PhotosAPIComponent {
        static let scheme = "https"
        static let host = try? EnvConfig.value(EnvConfig.YBS_HOST)
        static let clientID = try? EnvConfig.value(EnvConfig.YBS_CLIENT_ID)
        static let path = "/services/rest/"
        
    }
    
    func urlComponentForPhotosList() -> URLComponents {
        var components = URLComponents()
        components.scheme = PhotosAPIComponent.scheme
        components.host = PhotosAPIComponent.host
        components.path = PhotosAPIComponent.path
        components.queryItems = [
            URLQueryItem(name: "method", value: "flickr.photos.getRecent"),
            URLQueryItem(name: "api_key", value: PhotosAPIComponent.clientID ),
            URLQueryItem(name: "extras", value: "tags%2C+owner_name%2C+icon_server%2C+date_taken"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1"),
        ]
        
        return components
    }
    
    func urlComponentToDownloadPhoto(_ url: String) throws -> URLComponents {
        guard var components = URLComponents(string: url) else {
            throw APIError.request(message: "Invalid URL")
        }
        components.queryItems = [
          URLQueryItem(name: "w", value: "750" ),
          URLQueryItem(name: "dpr", value: "2" ),
        ]
        return components
    }
}


extension PhotosAPI: PhotosFetchable, Fetchable, Downloadable {
    func fetchContactPhotoList(nsid: String) -> AnyPublisher<PhotoModel, APIError> {
        return fetch(with: self.urlComponentForContactPhotosList(nsId: nsid), session: self.session)
    }
    
    func fetchPhotosList() -> AnyPublisher<PhotoModel, APIError> {
        return fetch(with: self.urlComponentForPhotosList(), session: self.session)
    }
    
    func downloadPhoto(_ url: String) -> AnyPublisher<Data, APIError> {
        return downloadData(with: try? self.urlComponentToDownloadPhoto(url), session: self.session)
    }
}


