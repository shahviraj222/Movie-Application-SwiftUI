//
//  HomeView.swift
//  Movie
//
//  Created by viraj shah on 04/11/25.
//

// GeometryReader measures the space its parent gives it and hands that info to you as GeometryProxy (geo).

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
