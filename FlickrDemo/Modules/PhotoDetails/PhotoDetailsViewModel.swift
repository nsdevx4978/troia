//
//  PhotoDetailsViewModel.swift
//  FlickrDemo
//
//  Created by ervinaydin on 01/06/2023.
//

import Foundation
import Combine

protocol PhotoDetailsViewModelInterface: ObservableObject {
    var imageData: Data? { get set }
    var photoModel: Photo { get }
    func downloadPhoto()
    init(photosFetcher: PhotosFetchable, photo: Photo)
    func getPhotoURL(photoModel: Photo) -> String?
}

class PhotoDetailsViewModel {
    @Published var imageData: Data?
    var photoModel: Photo
    private let photosFetcher: PhotosFetchable
    private var disposables = Set<AnyCancellable>()

    required init(photosFetcher: PhotosFetchable, photo: Photo) {
        self.photosFetcher = photosFetcher
        self.photoModel = photo
    }
}

extension PhotoDetailsViewModel: PhotoDetailsViewModelInterface {
    func getPhotoURL(photoModel: Photo) -> String?  {
        guard let server = photoModel.server, let id = photoModel.id, let secret = photoModel.secret else {
            return nil
        }
        return "https://live.staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
    
    
    func downloadPhoto() {
        photosFetcher
            .downloadPhoto(getPhotoURL(photoModel: photoModel) ?? "https://live.staticflickr.com/65535/52935051477_c662c3ea84_640.jpg")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.imageData = nil
                case .finished:
                    break
                }
            } receiveValue: { [weak self] imageData in
                self?.imageData = imageData
            }
            .store(in: &disposables)

    }
}
