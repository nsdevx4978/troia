//
//  PhotoListViewModel.swift
//  FlickrDemo
//
//  Created by ervinaydin on 01/06/2023.
//

import Foundation
import Combine

protocol PhotosListViewModelInterface: ObservableObject {
    var photoList: [Photo] { get set }
    var imageList: [String: Data?] { get set }
    init(photosFetcher: PhotosFetchable)
    func fetchPhotoList()
    func downloadPhoto(_ url: String)
    func getPhotoURL(photoModel: Photo) -> String?
    func getServerIconURL(photoModel: Photo) -> String?
}

class PhotoListViewModel {
    @Published var photoList: [Photo]
    @Published var imageList: [String : Data?]
    private let photosFetcher: PhotosFetchable
    private var disposables = Set<AnyCancellable>()

    required init(photosFetcher: PhotosFetchable) {
        self.photosFetcher = photosFetcher
        self.photoList = [Photo]()
        self.imageList = [String: Data?]()
    }
}

//MARK: - PhotosListViewModelInterface Extension

extension PhotoListViewModel: PhotosListViewModelInterface {
    func getServerIconURL(photoModel: Photo) -> String? {
        guard let iconFarm = photoModel.iconfarm, let server = photoModel.iconserver, let ownerId = photoModel.owner else {
            return nil
        }
        
        if iconFarm == 0 {
            return nil
        }
        
        return "https://farm\(iconFarm).staticflickr.com/\(server)/buddyicons/\(ownerId).jpg"
    }
    
    func fetchPhotoList() {
        photosFetcher
            .fetchPhotosList()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.photoList = []
                case .finished:
                    break
                }
                
            } receiveValue: { [weak self] photosResponse in
                self?.photoList = photosResponse.photos?.photo ?? []
            }
            .store(in: &disposables)
    }
    
    func downloadPhoto(_ url: String) {
        photosFetcher
            .downloadPhoto(url)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.imageList[url] = nil
                case .finished:
                    break
                }
            } receiveValue: { [weak self] imageData in
                self?.imageList[url] = imageData
            }
            .store(in: &disposables)

    }
    
    func getPhotoURL(photoModel: Photo) -> String? {
        guard let server = photoModel.server, let id = photoModel.id, let secret = photoModel.secret else {
            return nil
        }
        return "https://live.staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
}
