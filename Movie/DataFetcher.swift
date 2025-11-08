//
//  DataFetcher.swift
//  Movie
//
//  Created by viraj shah on 05/11/25.
//

//  Async function works on mutiple thread here

//  URLSession.shared The shared property comes from URLSession itself - it's a built-in singleton instance provided by Apple's Foundation framework.

//  NSError is nextstep error in that we have 3 paramtere domain , code, userInfo

//  Decoding stategy    TMDB API (like many REST APIs) uses snake_case naming convention Swift conventionally uses camelCase for property names This strategy bridges the gap automatically
                       



import Foundation

struct DataFetcher{
    let tmdbBaseURL = APIConfig.shared?.tmdbBaseURL
    let tmdbAPIKey = APIConfig.shared?.tmdbAPIKey
    
    
    //https://api.themoviedb.org/3/trending/movie/day?api_key=YOUR_API_KEY
    //https://api.themoviedb.org/3/movie/top_rated?api_key=YOUR_API_KEY
    //https://api.themoviedb.org/3/movie/upcoming?api_key=YOUR_API_KEY
    //https://api.themoviedb.org/3/search/movie?api_key=YourKey&query=PulpFiction
    
    func fetchTitles(for media:String,by type:String) async throws -> [Title]{
     
        let fetchTitlesURL = try buildURL(media: media, type:type)
        guard let fetchTitlesURL = fetchTitlesURL else{
            throw NetworkError.urlBuildFailed
        }
        
        let(data,urlResponse) = try await URLSession.shared.data(from:fetchTitlesURL)
        
        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else{
            throw NetworkError.badURLResponse(underlyingError: NSError(
                domain: "DataFetcher",
                code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                userInfo: [NSLocalizedDescriptionKey:"Invalid Http Resoponse"]))
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var titles =  try decoder.decode(APIObject.self, from: data).results
        Constants.addPosterPath(to: &titles)                // passing the address
        return titles
    }
    
    private func buildURL(media:String,type:String) throws -> URL? {
        guard let baseURL = tmdbBaseURL else{
            throw NetworkError.missingConfig
        }
        guard let apiKey = tmdbAPIKey else{
            throw NetworkError.missingConfig
        }
        var path:String
        
        if type == "trending"{
            path = "3/trending/\(media)/day"
        } else if type == "top_rated"{
            path = "3/\(media)/top_rated"
        }else{
            throw NetworkError.urlBuildFailed
        }
        
        guard let url = URL(string:baseURL)?
            .appending(path:path)
            .appending(queryItems: [
                URLQueryItem(name:"api_key",value: apiKey)
            ])else{
            throw NetworkError.urlBuildFailed
        }
        
        return url
    }
    
}
