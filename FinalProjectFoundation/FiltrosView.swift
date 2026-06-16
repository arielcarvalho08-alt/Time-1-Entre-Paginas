import SwiftUI

struct FiltrosView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: LocaisViewModel
    
    @State private var localApenasAbertos: Bool
    @State private var localAvaliacaoSelecionada: String
    @State private var localDistanciaMaxima: Double
    @State private var localContatoDisponivel: Bool
    @State private var localTiposSelecionados: [String: Bool]
    
    let opcoesAvaliacao = ["Todas", "+4,5 ★", "+4,0 ★", "+3,5 ★", "+3,0 ★"]
    
    init(viewModel: LocaisViewModel) {
        self.viewModel = viewModel
        _localApenasAbertos = State(initialValue: viewModel.apenasAbertos)
        _localAvaliacaoSelecionada = State(initialValue: viewModel.avaliacaoSelecionada)
        _localDistanciaMaxima = State(initialValue: viewModel.distanciaMaxima)
        _localContatoDisponivel = State(initialValue: viewModel.contatoDisponivel)
        _localTiposSelecionados = State(initialValue: viewModel.tiposSelecionados)
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Filtros")) {
                    Toggle("Aberto Agora", isOn: $localApenasAbertos)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Avaliação")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(opcoesAvaliacao, id: \.self) { opcao in
                                    Button(action: {
                                        localAvaliacaoSelecionada = opcao // Atualiza localmente
                                    }) {
                                        Text(opcao)
                                            .font(.footnote)
                                            .fontWeight(.medium)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .background(localAvaliacaoSelecionada == opcao ? Color.verdePrincipal : Color(.systemGray5))
                                            .foregroundColor(localAvaliacaoSelecionada == opcao ? .white : .primary)
                                            .clipShape(Capsule())
                                    }
                                }
                            }
                        }
                    }
                    .padding(.vertical, 4)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Distância Máxima")
                            Spacer()
                            Text("\(Int(localDistanciaMaxima)) KM")
                                .foregroundColor(.secondary)
                                .fontWeight(.bold)
                        }
                        Slider(value: $localDistanciaMaxima, in: 1...20, step: 1)
                            .accentColor(.verdePrincipal)
                    }
                    
                    Toggle("Contato disponível", isOn: $localContatoDisponivel)
                }
                
                Section(header: Text("Tipo de instituição")) {
                    ForEach(localTiposSelecionados.keys.sorted(), id: \.self) { tipo in
                        HStack {
                            Text(tipo)
                            Spacer()
                            if localTiposSelecionados[tipo] == true {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.verdePrincipal)
                                    .fontWeight(.bold)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            localTiposSelecionados[tipo]?.toggle() // Altera localmente
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Filtros", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancelar") {
                    dismiss()
                },
                trailing: HStack(spacing: 16) {
                    Button("Limpar") {
                        localApenasAbertos = false
                        localDistanciaMaxima = 20.0
                        localAvaliacaoSelecionada = "Todas"
                        localContatoDisponivel = false
                        for key in localTiposSelecionados.keys {
                            localTiposSelecionados[key] = true
                        }
                    }
                    .foregroundColor(.secondary)
                    
                    Button("Aplicar") {
                        viewModel.apenasAbertos = localApenasAbertos
                        viewModel.avaliacaoSelecionada = localAvaliacaoSelecionada
                        viewModel.distanciaMaxima = localDistanciaMaxima
                        viewModel.contatoDisponivel = localContatoDisponivel
                        viewModel.tiposSelecionados = localTiposSelecionados
                        
                        dismiss()
                    }
                    .foregroundColor(.verdePrincipal)
                    .fontWeight(.bold)
                }
            )
        }
    }
}
