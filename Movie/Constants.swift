//
//  Constants.swift
//  Movie
//
//  Created by viraj shah on 04/11/25.
//

//  static is used so that we can access the varibles without creating the instance
//  inout keywor is used so to define the parameter passed to function is call by reference so that we can directly change the parameter
//  where you passed parameter add &a so it passed by address
import Foundation
import SwiftUI

struct Constants{
    static let homeString = "Home"
    static let upcomingString = "Upcoming"
    static let searchString = "Search"
    static let downloadString = "Download"
    static let playString = "Play"
    
    
    
    static let homeIconString = "house"
    static let upcomingIconString = "play.circle"
    static let searchIconString = "magnifyingglass"
    static let downloadIconString = "arrow.down.to.line"
    static let trendingMovieString = "Trending Movies"
    static let trendingTVString = "Trending TV"
    static let topRatedMovieString = "Top Rated Movies"
    static let topRatedTVString = "Top Rated TV"
    
    static let testTitleURL = "https://image.tmdb.org/t/p/w500/nnl6OWkyPpuMm595hmAxNW3rZFn.jpg"
    static let testTitleURL2 = "https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg"
    static let testTitleURL3 = "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg"
    
    static let posterURLStart = "https://image.tmdb.org/t/p/w500"
    
    static func addPosterPath(to titles:inout[Title]){
        for index in titles.indices {
            if let path = titles[index].posterPath{
                titles[index].posterPath = posterURLStart + path
            }
        }
    }
}


//this is modifires dry concept

//here we are extending text Add new functionality to an existing type — without modifying the original source code.
//So you’re adding your own custom method ghostButton() to Text.
//here self is the referes to the Text instances.

extension Text {
    func ghostButton() -> some View{
        self
            .frame(width: 200,height: 50)
            .foregroundStyle(.buttonText)
            .bold()
            .background{
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.buttonBorder,lineWidth: 5)
            }
    }
}
