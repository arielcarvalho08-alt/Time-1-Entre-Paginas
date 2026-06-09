//
//  FiltrosView.swift
//  FinalProjectFoundation
//
//  Created by Found on 02/06/26.
//

import SwiftUI

struct FiltrosView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: LocaisViewModel
    @State private var contatoDisponivel = false
    @State private var avaliacaoSelecionada: String = "Todas"
    @State private var tiposSelecionados: [String: Bool] = [
        "Bibliotecas Comunitárias": true,
        "Cucas (Rede Cuca)": true,
        "Escolas Públicas": true,
        "Pontos de Leitura": true
    ]
    
    let opcoesAvaliacao = ["Todas", "+4,5 ★", "+4,0 ★", "+3,5 ★", "+3,0 ★"]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Status e Distância")) {
                    Toggle("Aberto Agora", isOn: $viewModel.apenasAbertos)
                        .tint(.blue)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Distância Máxima")
                            Spacer()
                            Text("\(Int(viewModel.distanciaMaxima)) KM")
                                .foregroundColor(.secondary)
                                .fontWeight(.bold)
                        }
                        Slider(value: $viewModel.distanciaMaxima, in: 1...30, step: 1)
                    }
                    .padding(.vertical, 4)
                }
                
                Section(header: Text("Avaliação Mínima")) {
                    Picker("Avaliação", selection: $avaliacaoSelecionada) {
                        ForEach(opcoesAvaliacao, id: \.self) { opcao in
                            Text(opcao)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Categorias de Locais")) {
                    ForEach(tiposSelecionados.keys.sorted(), id: \.self) { chave in
                        Toggle(chave, isOn: Binding(
                            get: { tiposSelecionados[chave] ?? false },
                            set: { tiposSelecionados[chave] = $0 }
                        ))
                        .tint(.blue)
                    }
                }
                
                Section(header: Text("Opções Adicionais")) {
                    Toggle("Contato disponível", isOn: $contatoDisponivel)
                        .tint(.blue)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Filtros", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancelar") {
                    dismiss()
                },
                trailing: Button("Limpar Tudo") {
                    viewModel.apenasAbertos = false
                    viewModel.distanciaMaxima = 20.0
                    
                    contatoDisponivel = false
                    avaliacaoSelecionada = "Todas"
                    for chave in tiposSelecionados.keys {
                        tiposSelecionados[chave] = true
                    }
                }
                .foregroundColor(.red)
            )
        }
    }
}




    //#Preview {
    //    FiltrosView()
    //}

