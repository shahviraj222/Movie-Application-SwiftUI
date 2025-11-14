//
//  TitleDetailView.swift
//  Movie
//
//  Created by viraj shah on 14/11/25.
//

//  GeometryReader is a SwiftUI container view that gives you access to the size and position of its parent container.GeometryReader takes up all the space offered by its parent unless you constrain it (e.g., with a frame).

//


import SwiftUI

struct TitleDetailView: View {
    let title:Title
    var body: some View {
        GeometryReader{ geometry in
            ScrollView{
                LazyVStack(alignment:.leading){
                    AsyncImage(url: URL(string: title.posterPath ?? "")){image in
                        image
                            .resizable()
                            .scaledToFit()
                    }placeholder: {
                        ProgressView()
                    }
                    .frame(width: geometry.size.width,height: geometry.size.height * 0.85)
                    
                    Text((title.name ?? title.title) ?? "")
                        .bold()
                        .font(.title2)
                        .padding(.top,-20)
                    
                    Text(title.overview ?? "")
        
                        .padding(5)
                    
                }
            }
        }
    }
}

#Preview {
    TitleDetailView(title: Title.previewTitles[0])
}
