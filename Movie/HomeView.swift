//
//  HomeView.swift
//  Movie
//
//  Created by viraj shah on 04/11/25.
//

//  .overlay is a SwiftUI view modifier that lets you place another view on top of the view it’s modifying, aligned to the same bounds.

//When to use .overlay

//• To darken/lighten parts of an image or view (e.g., with a gradient).
//• To draw strokes/borders using overlays that match the view’s shape.
//• To add badges or icons on top of thumbnails.
//• To place interactive elements over content (e.g., a play button over a poster).

// Gradients
//  The stops define that from 80% of the height (location: 0.8) downwards, the gradient transitions from .clear to .gradient (likely a custom Color defined elsewhere).

//  GeometryReader measures the space its parent gives it and hands that info to you as GeometryProxy (geo).

//  AsyncImage download image asychronusly and the clouser run when image is downloaded and the placeholder define what happen when image is loading from server.

//  Button first closuer what happen when button tapped second clouser is about styling of button

// The .task modifier you've added to the ScrollView is a SwiftUI modifier that automatically executes an asynchronous task when the view appears, and cancels it when the view disappears. It's similar to .onAppear but designed specifically for async work.

import SwiftUI

struct HomeView: View {
    var heroTestTitle = Constants.testTitleURL
    let viewModel = ViewModel()
    
    var body: some View {
        GeometryReader {geo in
            ScrollView{
                switch viewModel.homeStatus {
                case .notStarted:
                    EmptyView()
                case .fetching:
                    ProgressView()
                case .success:
                    LazyVStack{
                        
                        AsyncImage(url:URL(string:heroTestTitle)){ image in
                            image
                                .resizable()
                                .scaledToFit()
                                .overlay{
                                    LinearGradient(
                                        stops: [Gradient.Stop(color:.clear,location:0.8),
                                                Gradient.Stop(color: .gradient, location: 1)],
                                        startPoint: .top,
                                        endPoint: .bottom)
                                }
                        }placeholder: {
                            ProgressView()
                        }
                        .frame(width: geo.size.width,height: geo.size.height * 0.85)
                        
                        HStack{
                            Button{
                                
                            } label:{
                                Text(Constants.playString)
                                    .ghostButton()
                            }
                            Button{
                                
                            } label:{
                                Text(Constants.downloadString)
                                    .ghostButton()
                            }
                        }
                        
                        HorizontalListView(header: Constants.trendingMovieString, titles: viewModel.trendingMoveis)
    //                    HorizontalListView(header: Constants.trendingTVString,titles: Title.previewTitles)
    //                    HorizontalListView(header: Constants.trendingMovieString,titles: Title.previewTitles)
    //                    HorizontalListView(header: Constants.trendingTVString,titles: Title.previewTitles)
                    }
                case .failed(let error):
                    Text("Error:\(error)")
                }
                
            }
            .task {
                await viewModel.getTitles()
            }
        }
    }
}

#Preview {
    HomeView()
}
