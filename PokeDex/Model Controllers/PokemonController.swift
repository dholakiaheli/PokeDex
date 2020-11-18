//
//  PokemonController.swift
//  PokeDex
//
//  Created by Heli Bavishi on 11/17/20.
//

import Foundation
import UIKit

class PokemonController {
    
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/")
    static let pokemonComponent = "pokemon"
    
    static func fetchPokemonWith(searchTerm: String, completion: @escaping (Result<Pokemon,PokemonError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        let pokemonURL = baseURL.appendingPathComponent(pokemonComponent)
        let finalURL = pokemonURL.appendingPathComponent(searchTerm.lowercased())
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                return completion(.success(pokemon))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        } .resume()
    }
    
    static func fetchSpriteFor(pokemon: Pokemon, completion: @escaping (Result<UIImage,PokemonError>) -> Void) {
        let url = pokemon.sprites.shiny
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            
            return completion(.success(image))
        } .resume()
    }
}
