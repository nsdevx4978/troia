//
//  FlickrDemoApp.swift
//  FlickrDemo
//
//  Created by ervinaydin on 01/06/2023.
//

import SwiftUI

@main
struct FlickrDemoApp: App {
    let viewModel = PhotoListViewModel(photosFetcher: PhotosAPI())
    var body: some Scene {
        WindowGroup {
            PhotoListView(viewModel: viewModel)
        }
    }
}
