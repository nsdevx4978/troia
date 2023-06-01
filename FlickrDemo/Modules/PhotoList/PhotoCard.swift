//
//  PhotoCard.swift
//  FlickrDemo
//
//  Created by ervinaydin on 01/06/2023.
//

import Foundation
import SwiftUI

struct PhotoCard<Model>: View where Model: PhotosListViewModelInterface {
    private var title: String
    private var imageURL: String
    private var tags: String
    private var photo: Photo
    @ObservedObject private var viewModel: Model

    
    init(title: String, imageURL: String, tags: String, viewModel: Model, photo: Photo) {
        self.title = title
        self.imageURL = imageURL
        self.tags = tags
        self.viewModel = viewModel
        self.photo = photo
    }
    
    var body: some View {
        VStack {
            Spacer()
            NavigationLink {
                PhotoListRouter.makePhotoDetailsView(photo: photo)
            } label: {
                Image(uiImage: (UIImage(data: (viewModel.imageList[imageURL] ?? Data())!) ?? UIImage(named:"img_photo_placeholder"))!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 110)
            }
            
            ZStack {
                NavigationLink {
                    if let nsId = photo.owner, let userName = photo.ownername {
                        PhotoListRouter.makeContactPhotoListView(nsid: nsId, userName: userName)
                    }
                } label: {
                    HStack(spacing: 10) {
                        AsyncImage(url: URL(string: viewModel.getServerIconURL(photoModel: photo) ?? "")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 32, height: 32)
                                    .clipShape(Circle())
                            case .failure:
                                Image(systemName: "photo")
                            @unknown default:
                                EmptyView()
                            }
                        }
                        Text(title)
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                    }
                }
                
            }
            
            Spacer()
    
            Text(tags)
                .frame(height: 40)
                .font(.system(size: 12))
                .foregroundColor(.blue)
            
            
        }.onAppear {
            if viewModel.imageList[imageURL] == nil {
                viewModel.downloadPhoto(imageURL)

            }
        }
    }
}

struct PhotoCard_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCard(title: "Photo Title", imageURL: "https://", tags: "tag1 tag2 tag3", viewModel: MockPhotoListViewModel(photosFetcher: PhotosAPI()), photo: Photo(id: "52935157427", owner: "53922872@N07", secret: "367c7c0ce4", server: "65535", farm: 66, title: "L1017419-Bearbeitet.jpg", ispublic: 1, isfriend: 0, isfamily: 0, datetaken: "", ownername: "ChEckFoto", iconserver: "65535", iconfarm: 66, tags: ""))
    }
}
