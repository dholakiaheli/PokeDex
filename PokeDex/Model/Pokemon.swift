//
//  Pokemon.swift
//  PokeDex
//
//  Created by Heli Bavishi on 11/17/20.
//

import Foundation

struct Pokemon: Codable {
    
    let name: String
    let id: Int
    let sprites: Sprites
}

struct Sprites: Codable {
    
    let shiny: URL
    
    enum CodingKeys: String, CodingKey {
        case shiny = "front_shiny"
    }
}
