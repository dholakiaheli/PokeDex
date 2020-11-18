//
//  PokemonViewController.swift
//  PokeDex
//
//  Created by Heli Bavishi on 11/17/20.
//

import UIKit

class PokemonViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    //MARK:- LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokeSearchBar.delegate = self
    }
    
    //MARK: - Class methods
    
    func fetchSpritesAndUpdateViews(pokemon: Pokemon) {
        
        PokemonController.fetchSpriteFor(pokemon: pokemon) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let sprite):
                    self.pokeImageView.image = sprite
                    self.nameLabel.text = pokemon.name
                    self.idLabel.text = String(pokemon.id)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

//MARK: - SearchBar Delegate
extension PokemonViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        PokemonController.fetchPokemonWith(searchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.fetchSpritesAndUpdateViews(pokemon: pokemon)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
