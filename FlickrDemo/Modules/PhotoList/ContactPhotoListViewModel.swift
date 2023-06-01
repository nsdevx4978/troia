//
//  ContactPhotoListViewModel.swift
//  FlickrDemo
//
//  Created by ervinaydin on 01/06/2023.
//

import Foundation
import Combine

protocol ContactPhotosListViewModelInterface: ObservableObject {
    var photoList: [Photo] { get set }
    var imageList: [String: Data?] { get set }
    init(photosFetcher: PhotosFetchable, nsid: String, userName: String)
    func fetchContactPhotoList()
    func downloadPhoto(_ url: String)
    func getPhotoURL(photoModel: Photo) -> String?
    func getServerIconURL(photoModel: Photo) -> String?
    var nsid: String { get }
    var userName: String { get }
}

class ContactPhotoListViewModel {
    @Published var photoList: [Photo]
    @Published var imageList: [String : Data?]
    private let photosFetcher: PhotosFetchable
    private var disposables = Set<AnyCancellable>()
    var nsid: String
    var userName: String
    

    required init(photosFetcher: PhotosFetchable, nsid: String, userName: String) {
        self.photosFetcher = photosFetcher
        self.photoList = [Photo]()
        self.imageList = [String: Data?]()
        self.nsid = nsid
        self.userName = userName
    }
}

//MARK: - PhotosListViewModelInterface Extension

extension ContactPhotoListViewModel: ContactPhotosListViewModelInterface {
    
    func getServerIconURL(photoModel: Photo) -> String? {
        guard let iconFarm = photoModel.iconfarm, let server = photoModel.iconserver, let ownerId = photoModel.owner else {
            return nil
        }
        return "https://farm\(iconFarm).staticflickr.com/\(server)/buddyicons/\(ownerId).jpg"
    }
    
    func fetchContactPhotoList() {
        photosFetcher
            .fetchContactPhotoList(nsid: self.nsid)
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

