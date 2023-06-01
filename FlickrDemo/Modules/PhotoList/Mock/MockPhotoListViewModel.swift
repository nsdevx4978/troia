//
//  MockPhotoListViewModel.swift
//  FlickrDemo
//
//  Created by ervinaydin on 01/06/2023.
//

import Foundation

class MockPhotoListViewModel: PhotosListViewModelInterface {
    func getServerIconURL(photoModel: Photo) -> String? {
        return "https://live.staticflickr.com/65535/52935051477_c662c3ea84_640.jpg"
    }
    
    
    func getPhotoURL(photoModel: Photo) -> String? {
        return "https://live.staticflickr.com/65535/52935051477_c662c3ea84_640.jpg"
    }
    
    
    @Published var photoList: [Photo]
    @Published var imageList: [String : Data?]
    private let photosFetcher: PhotosFetchable
    required init(photosFetcher: PhotosFetchable) {
        self.photosFetcher = photosFetcher
        self.photoList = [
            Photo(id: "52935157427", owner: "53922872@N07", secret: "367c7c0ce4", server: "65535", farm: 66, title: "L1017419-Bearbeitet.jpg", ispublic: 1, isfriend: 0, isfamily: 0, datetaken: "", ownername: "ChEckFoto", iconserver: "65535", iconfarm: 66, tags: "")
            
        ]
        self.imageList = ["https://imageurl.com":Data()]
    }
    func fetchPhotoList() {}
    func downloadPhoto(_ url: String) {}

}
