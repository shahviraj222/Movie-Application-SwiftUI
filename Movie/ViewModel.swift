//
//  ViewModel.swift
//  Movie
//
//  Created by viraj shah on 08/11/25.
//

//here Obeservalbe keep update all propety in view.
//here private(set) make only read propety

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
    
    func getTitles() async {
        homeStatus = .fetching
        
        do{
            trendingMoveis = try await dataFetcher.fetchTitles(for: "movie",by:"treding")
            homeStatus = .success
        }catch{
            print(error)
            homeStatus = .failed(underlyingError: error)
        }
    }
}
