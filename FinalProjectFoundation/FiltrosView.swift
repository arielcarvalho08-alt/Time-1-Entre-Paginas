//
//  FiltrosView.swift
//  FinalProjectFoundation
//
//  Created by Found on 11/06/26.
//

import SwiftUI

struct FiltrosView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: LocaisViewModel
    
    let opcoesAvaliacao = ["Todas", "+4,5 ★", "+4,0 ★", "+3,5 ★", "+3,0 ★"]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Filtros")) {
                    Toggle(isOn: $viewModel.apenasFavoritos) {
                        HStack(spacing: 12) {
                            Text("Apenas Favoritos")
                        }
                    }
                    
                    Toggle("Aberto Agora", isOn: $viewModel.apenasAbertos)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Avaliação")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(opcoesAvaliacao, id: \.self) { opcao in
                                    Button(action: {
                                        viewModel.avaliacaoSelecionada = opcao
                                    }) {
                                        Text(opcao)
                                            .font(.footnote)
                                            .fontWeight(.medium)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .background(viewModel.avaliacaoSelecionada == opcao ? Color.verdePrincipal : Color(.systemGray5))
                                            .foregroundColor(viewModel.avaliacaoSelecionada == opcao ? .white : .primary)
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
                            Text("\(Int(viewModel.distanciaMaxima)) KM")
                                .foregroundColor(.secondary)
                                .fontWeight(.bold)
                        }
                        Slider(value: $viewModel.distanciaMaxima, in: 1...20, step: 1)
                            .accentColor(.verdePrincipal)
                    }
                    
                    Toggle("Contato disponível", isOn: $viewModel.contatoDisponivel)
                }
                
                Section(header: Text("Tipo de instituição")) {
                    ForEach(viewModel.tiposSelecionados.keys.sorted(), id: \.self) { tipo in
                        HStack {
                            Text(tipo)
                            Spacer()
                            if viewModel.tiposSelecionados[tipo] == true {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.verdePrincipal)
                                    .fontWeight(.bold)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.tiposSelecionados[tipo]?.toggle()
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
                trailing: HStack(spacing:16) {
                    Button("Limpar") {
                        viewModel.apenasFavoritos = false 
                        viewModel.apenasAbertos = false
                        viewModel.distanciaMaxima = 20.0
                        viewModel.avaliacaoSelecionada = "Todas"
                        viewModel.contatoDisponivel = false
                        for key in viewModel.tiposSelecionados.keys {
                            viewModel.tiposSelecionados[key] = true
                        }
                    }
                    .foregroundColor(.secondary)
                    
                    Button("Aplicar") {
                        dismiss()
                    }
                    .foregroundColor(.verdePrincipal)
                    .fontWeight(.bold)
                }
            )
        }
    }
}
