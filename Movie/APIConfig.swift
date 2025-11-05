//
//  APIConfig.swift
//  Movie
//
//  Created by viraj shah on 05/11/25.
//

//here we are using singleton design patter it is good for centralise resource management
//link of understaing code:https://chatgpt.com/share/690b2d80-dc3c-8004-84e1-759f8d43c7c2

import Foundation

struct APIConfig:Decodable{

    let tmdbBaseURL:String
    let tmdbAPIKey:String
    
    static let shared:APIConfig? = {
        do{
            return try loadConfig()
        }
        catch{
            print("Failed to load APIConfig: \(error.localizedDescription)")
            return nil
        }
    }()
    
    private static func loadConfig() throws -> APIConfig{
        guard let url = Bundle.main.url(forResource: "APIConfig", withExtension: "json")else{
            throw APIConfigError.fileNotFound
        }
        do{
            let data = try Data(contentsOf:url)
            return try JSONDecoder().decode(APIConfig.self, from: data)
        }catch let error as DecodingError{
            throw APIConfigError.dataLoadingFailed(underlyingError: error)
        }catch {
            throw APIConfigError.dataLoadingFailed(underlyingError: error)
        }

    }
}
