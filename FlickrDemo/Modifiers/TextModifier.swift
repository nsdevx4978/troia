//
//  TextModifier.swift
//  FlickrDemo
//
//  Created by ervinaydin on 01/06/2023.
//

import Foundation
import SwiftUI

struct PhotoHeaderStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8.0)
            .font(.bold(.custom("Helvetica", size: 11.0))())
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
}

struct H1TitleStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.bold(.custom("Helvetica", size: 16.0))())
            .multilineTextAlignment(TextAlignment.leading)
            .foregroundColor(.black)
    }
}
