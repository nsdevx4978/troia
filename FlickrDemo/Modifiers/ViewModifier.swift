//
//  ViewModifier.swift
//  FlickrDemo
//
//  Created by ervinaydin on 01/06/2023.
//

import Foundation
import SwiftUI

struct ViewHideModifier: ViewModifier {
    let flag: Bool
    func body(content: Content) -> some View {
        Group {
            if flag {
                EmptyView()
            } else {
                content
            }
        }
    }
}
