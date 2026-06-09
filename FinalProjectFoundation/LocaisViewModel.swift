//
//  LocaisViewModel.swift
//  FinalProjectFoundation
//
//  Created by Found on 02/06/26.
//

import Foundation
import Combine

class LocaisViewModel: ObservableObject {
    @Published var locais: [Local] = []
    @Published var textoPesquisa: String = ""
    
    private var todosLocais: [Local] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        carregarDadosdoBanco()
        
        $textoPesquisa
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] texto in
                self?.filtrarLocais(por: texto)
            }
            .store(in: &cancellables)
    }
    
    func carregarDadosdoBanco() {
        let dadosDoBanco = DatabaseManager.shared.fetchLocais()
        self.todosLocais = dadosDoBanco
        self.locais = dadosDoBanco
    }
    
    private func filtrarLocais(por texto: String) {
        if texto.isEmpty {
            self.locais = self.todosLocais
        } else {
            self.locais = self.todosLocais.filter { local in
                // Mudamos 'endereco' para procurar no 'bairro' ou no 'nome'
                local.nome.localizedCaseInsensitiveContains(texto) ||
                local.bairro.localizedCaseInsensitiveContains(texto)
            }
        }
    }
}
