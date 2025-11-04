//
//  ContentView.swift
//  Movie
//
//  Created by viraj shah on 04/11/25.
//

//control + shift + l  == to open library

import SwiftUI

struct ContentView: View {
    var body: some View {
        
//        for navigation in our file
        TabView{
            Tab(Constants.homeString,systemImage:Constants.homeIconString){
                HomeView()
            }
            Tab(Constants.upcomingString,systemImage:Constants.upcomingIconString){
                UpcomingView()
            }
            Tab(Constants.searchString,systemImage:Constants.searchIconString){
                SearchView()
            }
            Tab(Constants.downloadString,systemImage:Constants.downloadIconString ){
                DownloadView()
            }
        }
    }
}

#Preview {
    ContentView()
}
