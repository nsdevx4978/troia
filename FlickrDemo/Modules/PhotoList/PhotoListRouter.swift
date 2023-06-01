//
//  PhotoListRouter.swift
//  FlickrDemo
//
//  Created by ervinaydin on 01/06/2023.
//

import SwiftUI

enum PhotoListRouter {
    static func makePhotoDetailsView(photo: Photo) -> some View {
        let viewModel = PhotoDetailsViewModel(photosFetcher: PhotosAPI(), photo: photo)
        let view = PhotoDetailsView(viewModel: viewModel)
        return view
    }
    
    static func makeContactPhotoListView(nsid: String, userName: String) -> some View {
        let viewModel = ContactPhotoListViewModel(photosFetcher: PhotosAPI(), nsid: nsid, userName: userName)
        let view = ContctPhotoListView(viewModel: viewModel)
        return view
    }
}
