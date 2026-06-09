//
//  LocaisViewModel.swift
//  FinalProjectFoundation
//
//  Created by Found on 02/06/26.
//

import Foundation
import Combine

class LocaisViewModel: ObservableObject {
    @Published var textoPesquisa: String = ""
    @Published var distanciaMaxima: Double = 20.0
    @Published var apenasAbertos: Bool = false
    
    @Published var locais: [Local] = []
    
    private var todosLocais: [Local] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        carregarDadosdoBanco()
        
        Publishers.CombineLatest3($textoPesquisa, $distanciaMaxima, $apenasAbertos)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] texto, distancia, abertos in
                self?.filtrarLocais(texto: texto, distanciaMax: distancia, abertosApenas: abertos)
            }
            .store(in: &cancellables)
    }
    
    func carregarDadosdoBanco() {
        let dadosDoBanco = DatabaseManager.shared.fetchLocais()
        self.todosLocais = dadosDoBanco
        self.locais = dadosDoBanco
    }
    
    private func filtrarLocais(texto: String, distanciaMax: Double, abertosApenas: Bool) {
        var resultado = todosLocais
        
        if !texto.isEmpty {
            resultado = resultado.filter {
                $0.nome.localizedCaseInsensitiveContains(texto) ||
                $0.bairro.localizedCaseInsensitiveContains(texto)
            }
        }
        
        if abertosApenas {
            resultado = resultado.filter { $0.abertoAgora == true }
        }
        
        resultado = resultado.filter { $0.distanciaSimulada <= distanciaMax }
        
        self.locais = resultado
    }
}


