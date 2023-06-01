//
//  ContactPhotoListView.swift
//  FlickrDemo
//
//  Created by ervinaydin on 01/06/2023.
//

import SwiftUI

struct ContctPhotoListView <Model>: View where Model:ContactPhotosListViewModelInterface {
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
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.photoList) { photo in
                    if let imageURL = viewModel.getPhotoURL(photoModel: photo) {
                        ContactPhotoCard(title: photo.ownername ?? "N/A", imageURL: imageURL, tags: photo.tags ?? "", viewModel: viewModel, photo: photo)
//                            .frame(height: height)
                    }
                    
                }
            }
            .padding()
        }
        .navigationBarTitle(viewModel.userName + " Photos")
        .onAppear {
            viewModel.fetchContactPhotoList()
        }
    }
}

struct ContctPhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView(viewModel: MockPhotoListViewModel(photosFetcher: PhotosAPI()))
    }
}
