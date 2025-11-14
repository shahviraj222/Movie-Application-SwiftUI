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

//  Navigation Working

//  NavigationStack: It provides the navigation context. Views inside it don’t automatically “navigate,” but they can push new destinations onto the stack.

//  path (NavigationPath bound via $titleDetailPath): This is the data-driven history of the stack. You append values (like a Title) to push, and remove to pop. Because it’s data, it also lets you restore deep links by reconstructing the path.

//  navigationDestination(for: Title.self) { title in ... }: This maps a pushed Title value to the view that should be shown for it. In your case, when you do titleDetailPath.append(viewModel.heroTitle), SwiftUI looks up the registered destination for Title and builds TitleDetailView(title: title).

//  Passing data: Yes—the Title you append is passed into the destination closure, so you can hand it to TitleDetailView. That’s how data flows from one screen to the next.

//  So, in your selected line:
//  TitleDetailView(title: title)
//  you’re defining the actual screen to show for a given Title and passing along the model instance that was appended to the path.



import SwiftUI

struct HomeView: View {
    let viewModel = ViewModel()
    @State private var titleDetailPath = NavigationPath()
    
    var body: some View {
//        embed the view on navigation stack so that you can change the screen
        NavigationStack(path:$titleDetailPath) {
            GeometryReader {geo in
                ScrollView{
                    switch viewModel.homeStatus {
                    case .notStarted:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                            .frame(width: geo.size.width,height: geo.size.height)
                    case .success:
                        LazyVStack{
                            
                            AsyncImage(url:URL(string:viewModel.heroTitle.posterPath ?? "" )){ image in
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
                                    titleDetailPath.append(viewModel.heroTitle)
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
                            HorizontalListView(header: Constants.trendingTVString,titles:viewModel.trendingTV)
                            HorizontalListView(header: Constants.topRatedMovieString,titles: viewModel.topRatedMovie)
                            HorizontalListView(header: Constants.topRatedTVString,titles: viewModel.topRatedTV)
                        }
                        .navigationDestination(for:Title.self){ title in
                            TitleDetailView(title: title)
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
}

#Preview {
    HomeView()
}
