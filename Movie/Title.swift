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


struct Title:Decodable,Identifiable{
    var id:Int?
    var title:String?
    var name:String?
    var overview:String?
    var posterPath:String?
}
