//
//  Item.swift
//  eggplant-brownie
//
//  Created by Felipe Weber on 13/11/19.
//  Copyright © 2019 Felipe Weber. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    
    
    //Atributos
    var nome: String
    var calorias: Double
    
    //Construtor
    init(nome: String, calorias: Double) {
        self.nome = nome
        self.calorias = calorias
    }
    
    //MARK: - NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(nome, forKey: "nome")
        coder.encode(calorias, forKey: "calorias")
    }
    
    required init?(coder: NSCoder) {
        nome = coder.decodeObject(forKey: "nome") as! String
        calorias = coder.decodeDouble(forKey: "calorias")
    }
}
