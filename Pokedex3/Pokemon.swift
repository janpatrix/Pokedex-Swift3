//
//  Pokemon.swift
//  Pokedex3
//
//  Created by Patrick Gross on 02/11/2016.
//  Copyright © 2016 Patrick Gross. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _pokeURL: String!
    
    var name: String {
        
        return _name
    }
    
    var pokedexId: Int {
        
        return _pokedexId
    }
    
    var description: String {
        
        if _description == nil {
            
            _description = ""
        }
        return _description
    }
    
    var type: String {
        
        if _type == nil {
            
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        
        if _defense == nil {
            
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        
        if _height == nil {
            
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        
        if _weight == nil {
            
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        
        if _attack == nil {
            
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionName: String {
        
        if _nextEvolutionName == nil {
            
            return ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionId: String {
        
        if _nextEvolutionId == nil {
            
            return ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String {
        
        if _nextEvolutionLevel == nil {
            
            return ""
        }
        return _nextEvolutionLevel
    }

    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokeURL = "http://pokeapi.co/api/v1/pokemon/" + "\(pokedexId)"

    }
    
    func getPokeDetail(completed: @escaping DownloadComplete) {
                
        Alamofire.request(self._pokeURL).responseJSON { response in
                        
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let attack = dict["attack"] as? Int {
                    
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    
                    self._defense = "\(defense)"
                }
                
                if let height = dict["height"] as? String {
                    
                    self._height = height
                }
                
                if let weight = dict["weight"] as? String {
                    
                    self._weight = weight
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                    
                        for x in 1..<types.count {
                            
                            if let name = types[x]["name"] {
                                
                                self._type! += "|\(name.capitalized)"
                            }
                        }
                    }
                } else {
                    
                    self._type = "No type"
                }
                
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String, String>] , descriptions.count > 0 {
                    
                    if let url = descriptions[0]["resource_uri"] {
                        
                        Alamofire.request("http://pokeapi.co\(url)").responseJSON { response in
                            
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    
                                    if description.contains("POKMON") {
                                        
                                        let newDesc = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                        self._description = newDesc
                                    }
                                }
                            }
                            completed()
                        }
                    }
                } else {
                    
                    self._description = "No description available"
                }
                
                if let nextEvo = dict["evolutions"] as? [Dictionary<String, AnyObject>] , nextEvo.count > 0 {
                    
                    if let evolutionName = nextEvo[0]["to"] as? String {
                        
                        if evolutionName.range(of: "mega") == nil {
                            
                            self._nextEvolutionName = evolutionName
                            print(evolutionName)
                            
                            if let uri = nextEvo[0]["resource_uri"] as? String {
                                
                                let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newString.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionId = nextEvoId
                            } else {
                                
                                self._nextEvolutionId = ""
                            }
                            
                            if let level = nextEvo[0]["level"] as? Int {
                                
                                self._nextEvolutionLevel = "\(level)"
                            } else {
                                
                                self._nextEvolutionLevel = ""
                            }
                            
                        }
                    }
                }
            }
            completed()
        }
    }
}
