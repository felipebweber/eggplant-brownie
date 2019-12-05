//
//  Refeicao.swift
//  eggplant-brownie
//
//  Created by Felipe Weber on 13/11/19.
//  Copyright © 2019 Felipe Weber. All rights reserved.
//

import UIKit

class Refeicao: NSObject, NSCoding {
    
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
    
    
    // MARK: - NSCoding
    // "transformar" meu dados em bytes, serialização dos dados
    func encode(with coder: NSCoder) {
        coder.encode(nome, forKey: "nome")
        coder.encode(felicidade, forKey: "felicidade")
        coder.encode(itens, forKey: "itens")
    }
    
    // agora é feita a desserialização dos dados
    required init?(coder: NSCoder) {
        nome = coder.decodeObject(forKey: "nome") as! String
        felicidade = coder.decodeInteger(forKey: "felicidade")
        itens = coder.decodeObject(forKey: "itens") as! Array<Item>
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
