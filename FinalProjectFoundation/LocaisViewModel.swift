//
//  LocaisViewModel.swift
//  FinalProjectFoundation
//
//  Created by Found on 11/06/26.
//

import Foundation
import Combine

class LocaisViewModel: ObservableObject {
    @Published var locais: [Local] = []
    @Published var textoPesquisa: String = ""
    @Published var distanciaMaxima: Double = 20.0
    @Published var apenasAbertos: Bool = false
    @Published var avaliacaoSelecionada: String = "Todas"
    @Published var contatoDisponivel: Bool = false
    @Published var tiposSelecionados: [String: Bool] = [
        "Bibliotecas Comunitárias": true,
        "Cucas (Rede Cuca)": true,
        "Escolas Públicas": true,
        "Pontos de Leitura": true
    ]
    
    private var todosLocais: [Local] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        carregarDadosdoBanco()
        Publishers.CombineLatest4($textoPesquisa, $distanciaMaxima, $apenasAbertos, $avaliacaoSelecionada)
            .combineLatest($contatoDisponivel, $tiposSelecionados)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] primeiroBloco, contato, tipos in
                let (texto, distancia, abertos, avaliacao) = primeiroBloco
                self?.filtrarLocais(texto: texto, distanciaMax: distancia, abertosApenas: abertos, avaliacaoMin: avaliacao, contatoApenas: contato, tipos: tipos)
            }
            .store(in: &cancellables)
    }
    
    func carregarDadosdoBanco() {
        let dadosDoBanco = DatabaseManager.shared.fetchLocais()
        print("====== TESTE DE BANCO ======")
        print("Quantidade de locais encontrados: \(dadosDoBanco.count)")
        print("============================")
        self.todosLocais = dadosDoBanco
        self.locais = dadosDoBanco
    }
    
    private func filtrarLocais(texto: String, distanciaMax: Double, abertosApenas: Bool, avaliacaoMin: String, contatoApenas: Bool, tipos: [String: Bool]) {
        var filtrados = todosLocais
        
        if !texto.isEmpty {
            filtrados = filtrados.filter {
                $0.nome.localizedCaseInsensitiveContains(texto) ||
                $0.bairro.localizedCaseInsensitiveContains(texto)
            }
        }
        
        if abertosApenas {
            filtrados = filtrados.filter { $0.aberto_agora == true }
        }
        
        filtrados = filtrados.filter { $0.distancia_simulada <= distanciaMax }
        
        if avaliacaoMin != "Todas" {
            let apenasNumeros = avaliacaoMin.replacingOccurrences(of: "+", with: "")
                                             .replacingOccurrences(of: " ★", with: "")
                                             .replacingOccurrences(of: ",", with: ".")
            if let notaMinima = Double(apenasNumeros) {
                filtrados = filtrados.filter { $0.mediaAvaliacao >= notaMinima }
            }
        }
        
        if contatoApenas {
            filtrados = filtrados.filter { local in
                if let contato = local.contato {
                    return (contato.telefone != nil && !contato.telefone!.isEmpty) ||
                           (contato.website != nil && !contato.website!.isEmpty)
                }
                return false
            }
        }
        
        filtrados = filtrados.filter { local in
            let ehCuca = local.nome.localizedCaseInsensitiveContains("Cuca")
            let ehBiblioteca = local.nome.localizedCaseInsensitiveContains("Biblioteca") || local.nome.localizedCaseInsensitiveContains("BECE")
            
            if ehCuca && tipos["Cucas (Rede Cuca)"] == false { return false }
            if ehBiblioteca && tipos["Bibliotecas Comunitárias"] == false { return false }
            
            return true
        }
        
        self.locais = filtrados
    }
}
