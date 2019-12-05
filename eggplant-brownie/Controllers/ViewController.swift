//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Felipe Weber on 12/11/19.
//  Copyright © 2019 Felipe Weber. All rights reserved.
//

import UIKit

protocol AdicionaRefeicaoDelegate {
    func add(_ refeicao: Refeicao)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionarItensDelegate {
    
    // MARK: IBOutlet
    @IBOutlet weak var itensTableView: UITableView!
    
    
    
    // MARK: - Atributos
    
    var delegate: AdicionaRefeicaoDelegate?
//    var itens: [String] = ["Molho de tomate", "Queijo", "Molho apimentado", "Mangericao"]
//    var itens: [Item] = [Item(nome: "Molho de tomate", calorias: 40.0), Item(nome: "Queijo", calorias: 50.0), Item(nome: "Molho apimentado", calorias: 60.0), Item(nome: "Picanha", calorias: 70.0)]
    
    var itens: [Item] = []
    
    var itensSelecionados: [Item] = []
    
    // MARK:  - IBOutlets
    
    // Quando coloco ? quero dizer que a variavel é opcional, mas tenho que tratar mais para frente no codigo
    @IBOutlet weak var nomeTextField: UITextField?
    @IBOutlet weak var felicidadeTextField: UITextField?
    
    // MARK: - View life cycle
    
        override func viewDidLoad() {
//            super.viewDidLoad()
            let botaoAdicionarItem = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(adicionarItem))
            navigationItem.rightBarButtonItem = botaoAdicionarItem
            recuperaItens()
        }
    
    func recuperaItens(){
        itens = ItemDao().recupera()
    }
    
    @objc func adicionarItem(){
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    func add(_ item: Item ){
        itens.append(item)
        ItemDao().save(itens)
        
        if let tableView = itensTableView{
            tableView.reloadData()
        }else{
            Alerta(controller: self).exibe(titulo: "Desculpe", mensagem: "Não foi possivel atualizar a tabela")
        }
        
        
    }
    
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let linhaDaTabela = indexPath.row
        let item = itens[linhaDaTabela]
        
        celula.textLabel?.text = item.nome
        
        return celula
    }
    
    // MARK: - UITableViewDelegate
    // Implementar a captura do click do usuário
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let celula = tableView.cellForRow(at: indexPath) else { return }
        
        if celula.accessoryType == .none{
            celula.accessoryType = .checkmark
            
            let linhaDaTabela = indexPath.row
            itensSelecionados.append(itens[linhaDaTabela])
        }else{
            celula.accessoryType = .none
            
            let item = itens[indexPath.row]
            if let position = itensSelecionados.firstIndex(of: item){
                itensSelecionados.remove(at: position)
            }
            
            // Teste
//            for teste in itensSelecionados{
//                print(teste.nome)
//            }
//
        }
        
        
    }
    
    func recuperaRefeicaoDoFormulario() -> Refeicao?{
        //Essa é outra forma de tratar possiveis erros, forma segura
        guard let nomeDaRefeicao = nomeTextField?.text else {
//            Alerta(controller: self).exibe(mensagem: "Erro ao ler campo nome.")
            return nil
        }
        
        guard let felicidadeDaRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeDaRefeicao) else {
//            Alerta(controller: self).exibe(mensagem: "Erro ao ler campo felicidade.")
            return nil
        }
        
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade, itens: itensSelecionados)
        
        return refeicao
    }
    
    // MARK: - IBActions
    @IBAction func adicionar(_ sender: Any) {
        
        if let refeicao = recuperaRefeicaoDoFormulario(){
            delegate?.add(refeicao)
            //quando usado faz com o view controller saia, desapareça, eh tirado da pilha
            //volta para tela anterior
            navigationController?.popViewController(animated: true)
        }else{
            Alerta(controller: self).exibe(mensagem: "Erro ao ler dado do formulário")
        }
        
    }


}

