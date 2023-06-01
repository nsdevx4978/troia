//
//  PhotoListView.swift
//  FlickrDemo
//
//  Created by ervinaydin on 01/06/2023.
//

import SwiftUI

struct PhotoListView <Model>: View where Model:PhotosListViewModelInterface {
    @StateObject private var viewModel: Model
    init (viewModel: Model) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var columns: [GridItem] = [
        GridItem(.flexible(minimum: 100.0, maximum: UIScreen.main.bounds.size.width / 2.0 )),
        GridItem(.flexible(minimum: 100.0, maximum: UIScreen.main.bounds.size.width / 2.0)),
    ]
    let height: CGFloat = 182
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.photoList) { photo in
                        if let imageURL = viewModel.getPhotoURL(photoModel: photo) {
                            PhotoCard(title: photo.ownername ?? "N/A", imageURL: imageURL, tags: photo.tags ?? "", viewModel: viewModel, photo: photo)
//                                .frame(height: height)
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle(AppConstants.PageTitle.PhotoListView)
        }
        .onAppear {
            viewModel.fetchPhotoList()
        }
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView(viewModel: MockPhotoListViewModel(photosFetcher: PhotosAPI()))
    }
}
