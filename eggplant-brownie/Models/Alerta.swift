//
//  Alerta.swift
//  eggplant-brownie
//
//  Created by Felipe Weber on 20/11/19.
//  Copyright © 2019 Felipe Weber. All rights reserved.
//

import UIKit

class Alerta{
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func exibe(titulo: String = "Atenção", mensagem: String) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerta.addAction(ok)
        controller.present(alerta, animated: true, completion: nil)
    }
}
