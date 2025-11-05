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



import SwiftUI

struct HomeView: View {
    var heroTestTitle = Constants.testTitleURL
    
    var body: some View {
        GeometryReader {geo in
            ScrollView{
                
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
                    
                    HorizontalListView(header: Constants.trendingMovieString)
                    HorizontalListView(header: Constants.trendingTVString)
                    HorizontalListView(header: Constants.trendingMovieString)
                    HorizontalListView(header: Constants.trendingTVString)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
