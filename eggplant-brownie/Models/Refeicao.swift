//
//  Refeicao.swift
//  eggplant-brownie
//
//  Created by Felipe Weber on 13/11/19.
//  Copyright © 2019 Felipe Weber. All rights reserved.
//

import UIKit

class Refeicao: NSObject {
    //Atributos
    let nome: String
    let felicidade: Int
    var itens: Array<Item> = []
    
    //Construtor
    init(nome: String, felicidade: Int, itens: [Item] = []) {
        self.nome = nome
        self.felicidade = felicidade
        self.itens = itens
    }
    
    // Metodos
    func totalDeCalorias() -> Double {
        var total = 0.0
        for item in itens{
            total += item.calorias
        }
        return total
    }
    
    func detalhes() -> String{
        var mensagem = "Felicidade: \(felicidade)"
        for item in itens {
            mensagem += ", \(item.nome) - Calorias: \(item.calorias)"
        }
        return mensagem
    }
}
