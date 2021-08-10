//
//  ContentView.swift
//  SwiftUIAsyncImage
//
//  Created by Mixko on 10/8/2564 BE.
//

import SwiftUI

extension Image {
    func ImageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 256)
    }
    
    func iconModifier() -> some View {
        self
            .ImageModifier()
            .foregroundColor(.purple)
            .opacity(0.5)
    }
}

struct ContentView: View {
    private let imageURL: String = "https://iconape.com/wp-content/files/zy/291859/png/291859.png"
    
    var body: some View {
        ///MARK 1. Basic
        
        //AsyncImage(url: URL(string: imageURL))
        
        ///MARK 2 - Scale AsyncImage
        //Default is 1.0
        //AsyncImage(url: URL(string: imageURL), scale: 3.0)
        
        //MARK 3 - Placeholder
//        AsyncImage(url: URL(string: imageURL)) { image in
//            image
//                .ImageModifier()
            ///if ImageURL is can't show the image. Placeholder will showed instead
//        } placeholder: {
//            Image(systemName: "photo.circle.fill")
//                .iconModifier()
//        }
//        .padding(40)
//        AsyncImage(url: URL(string: imageURL)) { phase in
            ///Success: Image loaded
            ///Failure: Image fail with error message
            ///EMPTY: No image is loaded
//            if let image = phase.image {
//                image.ImageModifier()
//            } else if phase.error != nil {
//                Image(systemName:"ant.circle.fill").iconModifier()
//            } else {
//                Image(systemName: "photo.circle.fill").iconModifier()
//            }
//        }.padding(40)
        AsyncImage(url: URL(string: imageURL), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
            switch phase {
            case .success(let image):
                image.ImageModifier()
//                    .transition(.move(edge: .top))
//                    .transition(.slide)
                    .transition(.scale)
            case .failure(_):
                Image(systemName: "ant.circle.fill").iconModifier()
            case .empty:
                Image(systemName: "photo.circle.fill").iconModifier()
            @unknown default:
                ProgressView()
            }
        }.padding(40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
