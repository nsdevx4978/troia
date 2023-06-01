//
//  PhotoDetailsView.swift
//  FlickrDemo
//
//  Created by ervinaydin on 01/06/2023.
//

import SwiftUI

struct PhotoDetailsView<Model>: View where Model: PhotoDetailsViewModelInterface {
    @ObservedObject private var viewModel: Model
    init(viewModel: Model) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 10.0) {
            ScrollView {
                Image(uiImage: (UIImage(data: (viewModel.imageData ?? Data())!) ?? UIImage(named:"img_photo_placeholder"))!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Text((viewModel.photoModel.title ?? ""))
                .h1TitleStyle()
                .shouldHide(viewModel.photoModel.title == nil)
            Text((viewModel.photoModel.datetaken ?? ""))
                .h1TitleStyle()
            Text(viewModel.photoModel.owner ?? "")
        }
        .padding()
        .navigationBarTitle(AppConstants.PageTitle.PhotoDetailView)
        .onAppear {
            viewModel.downloadPhoto()
        }
    }
}

struct PhotoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailsView(viewModel: MockPhotoDetailsViewModel(photosFetcher: PhotosAPI(), photo: Photo(id: "52935157427", owner: "53922872@N07", secret: "367c7c0ce4", server: "65535", farm: 66, title: "L1017419-Bearbeitet.jpg", ispublic: 1, isfriend: 0, isfamily: 0, datetaken: "", ownername: "ChEckFoto", iconserver: "65535", iconfarm: 66, tags: "tag1, tag2, tag3")))
    }
}
