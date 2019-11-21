//
//  RefeicoesTableViewController.swift
//  eggplant-brownie
//
//  Created by Felipe Weber on 18/11/19.
//  Copyright © 2019 Felipe Weber. All rights reserved.
//

import Foundation
import UIKit

class RefeicoesTableViewController: UITableViewController, AdicionaRefeicaoDelegate{
    
    var refeicoes = [Refeicao (nome: "Macarrão", felicidade: 4, itens: []), Refeicao (nome: "Pizza", felicidade: 5), Refeicao (nome: "Comida Japonesa", felicidade: 3, itens: []), Refeicao(nome: "Picanha Express", felicidade: 5)]
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        let refeicao = refeicoes[indexPath.row]
        
        celula.textLabel?.text = refeicao.nome
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhes(_:)))
        celula.addGestureRecognizer(longPress)
        return celula
    }
    
    @objc func mostrarDetalhes(_ gesture: UILongPressGestureRecognizer){
        if gesture.state == .began{
            let celula = gesture.view as! UITableViewCell
            
            guard let indexPath = tableView.indexPath(for: celula) else {
                return
            }
            let refeicao = refeicoes[indexPath.row]
            
            RemoveRefeicaoViewController(controller: self).exibe(refeicao, handler: {alert in
                self.refeicoes.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
            
//            func removeRefeicao(alerta: UIAlertAction){
//                print("Remover refeicao: \(refeicao.nome)")
//                refeicoes.remove(at: indexPath.row)
//                tableView.reloadData()
//            }
            
        }
    }
    
    
    func add(_ refeicao: Refeicao){
        refeicoes.append(refeicao)
        tableView.reloadData()
        print("Refeicao add: \(refeicao.nome) ")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "adicionar"{
            if let viewController = segue.destination as? ViewController{
                viewController.delegate = self
            }
        }
    }
}
