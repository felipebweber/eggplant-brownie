//
//  Item.swift
//  eggplant-brownie
//
//  Created by Felipe Weber on 13/11/19.
//  Copyright © 2019 Felipe Weber. All rights reserved.
//

import UIKit

class Item: NSObject {
    //Atributos
    var nome: String
    var calorias: Double
    
    //Construtor
    init(nome: String, calorias: Double) {
        self.nome = nome
        self.calorias = calorias
    }
}
