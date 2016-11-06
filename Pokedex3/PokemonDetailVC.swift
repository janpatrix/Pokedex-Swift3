//
//  PokemonDetailVC.swift
//  Pokedex3
//
//  Created by Patrick Gross on 04/11/2016.
//  Copyright © 2016 Patrick Gross. All rights reserved.
//

import UIKit


class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        currentEvoImg.image = UIImage(named: "\(pokemon.pokedexId)")
        nameLbl.text = pokemon.name.capitalized
        
        pokemon.getPokeDetail{
            
            self.updateUI()
        }
    }
    
    func updateUI() {
        
        pokedexLbl.text = "\(pokemon.pokedexId)"
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        if pokemon.nextEvolutionId == "" {
            
            evoLbl.text = "No next Evolution"
        } else {
            
            evoLbl.text = "Next Evolution: \(pokemon.nextEvolutionName) LVL \(pokemon.nextEvolutionLevel)"
        }
        nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
    }
    
    @IBAction func backBtnPressed(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
}
