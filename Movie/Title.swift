//
//  Title.swift
//  Movie
//
//  Created by viraj shah on 05/11/25.
//


//here our struct is implementing the decodable and identifiable

//Why Decodable?
//• You’ll likely fetch movie/TV data from a web API (like TMDB). The response is JSON.
//• Conforming to Decodable lets you do:
//let title = try JSONDecoder().decode(Title.self, from: data)
//or an array:
//let titles = try JSONDecoder().decode([Title].self, from: data)
//• Without Decodable, you’d have to manually parse dictionaries and assign properties.



import Foundation

struct APIObject:Decodable{
    var results:[Title] = []
}


struct Title:Decodable,Identifiable,Hashable{
    var id:Int?
    var title:String?
    var name:String?
    var overview:String?
    var posterPath:String?
    
    static var previewTitles = [
        Title(id: 1, title: "BeetleJuice", name: "BeetleJuice", overview: "A movie about BeetleJuice", posterPath: Constants.testTitleURL),
        Title(id: 2, title: "Pulp Fiction", name: "Pulp Fiction", overview: "A movie about Pulp Fiction", posterPath: Constants.testTitleURL2),
        Title(id: 3, title: "The Dark Knight", name: "The Dark Knight", overview: "A movie about the Dark Knight", posterPath: Constants.testTitleURL3)
    ]

}


