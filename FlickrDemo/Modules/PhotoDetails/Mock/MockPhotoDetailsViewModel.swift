//
//  MockPhotoDetailsViewModel.swift
//  FlickrDemo
//
//  Created by ervinaydin on 01/06/2023.
//

import Foundation
import Combine
import UIKit

class MockPhotoDetailsViewModel {
    @Published var imageData: Data?
    var photoModel: Photo
    private let photosFetcher: PhotosFetchable
    private var disposables = Set<AnyCancellable>()

    required init(photosFetcher: PhotosFetchable, photo: Photo) {
        self.photosFetcher = photosFetcher
        self.photoModel = photo
    }
}

extension MockPhotoDetailsViewModel: PhotoDetailsViewModelInterface {
    func getPhotoURL(photoModel: Photo) -> String? {
        return nil
    }
    
    func downloadPhoto() {}
}
