import Foundation
import Combine

class LocaisViewModel: ObservableObject {
    @Published var locais: [Local] = []
    @Published var textoPesquisa: String = ""
    @Published var distanciaMaxima: Double = 20.0
    @Published var apenasAbertos: Bool = false
    @Published var avaliacaoSelecionada: String = "Todas"
    
    private var todosLocais: [Local] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        carregarDadosdoBanco()
        Publishers.CombineLatest4($textoPesquisa, $distanciaMaxima, $apenasAbertos, $avaliacaoSelecionada)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] texto, distancia, abertos, avaliacao in
                self?.filtrarLocais(texto: texto, distanciaMax: distancia, abertosApenas: abertos, avaliacaoMin: avaliacao)
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
    
    private func filtrarLocais(texto: String, distanciaMax: Double, abertosApenas: Bool, avaliacaoMin: String) {
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
        
        if avaliacaoMin != "Todas", let notaMinima = Double(avaliacaoMin) {
            filtrados = filtrados.filter { $0.mediaAvaliacao >= notaMinima }
        }
        
        self.locais = filtrados
    }
}
