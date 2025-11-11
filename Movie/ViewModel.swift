//
//  ViewModel.swift
//  Movie
//
//  Created by viraj shah on 08/11/25.
//

//  here Obeservalbe keep update all propety in view.
//  here private(set) make only read propety

//  here the problem is we have to wait until the first call over
//  trendingMoveis = try await dataFetcher.fetchTitles(for: "movie",by:"trending")
//  trendingTV = try await dataFetcher.fetchTitles(for: "tv", by: "trending")

//  let async make multiple call in parallel

import Foundation


@Observable
class ViewModel{
    enum FetchStatus{
        case notStarted
        case fetching
        case success
        case failed(underlyingError:Error)
    }
    private(set) var homeStatus:FetchStatus = .notStarted
    private let dataFetcher = DataFetcher()
    var trendingMoveis:[Title] = []
    var trendingTV:[Title] = []
    var topRatedMovie:[Title] = []
    var topRatedTV:[Title] = []
    
    func getTitles() async {
        homeStatus = .fetching
        
        if trendingMoveis.isEmpty {
            do{
                
                
                async let tMovies =  dataFetcher.fetchTitles(for: "movie",by:"trending")
                async let tTV = dataFetcher.fetchTitles(for: "tv", by: "trending")
                async let tRMovies = dataFetcher.fetchTitles(for: "movie", by: "top_rated")
                async let tRTV = dataFetcher.fetchTitles(for: "tv", by: "top_rated")
                
                trendingMoveis = try await tMovies
                trendingTV = try await tTV
                topRatedTV = try await tRTV
                topRatedMovie = try await tRMovies
                
                homeStatus = .success
            }catch{
                print(error)
                homeStatus = .failed(underlyingError: error)
            }
        }else{
            homeStatus = .success
        }
    }
}
