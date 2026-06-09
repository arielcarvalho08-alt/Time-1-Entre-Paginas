//
//  FiltrosView.swift
//  FinalProjectFoundation
//
//  Created by Found on 02/06/26.
//

import SwiftUI

struct FiltrosView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var abertoAgora = false
    @State private var distanciaMaxima: Double = 5.0
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
                Section(header: Text("Filtros")) {
                    Toggle("Aberto Agora", isOn: $abertoAgora)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Avaliação")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(opcoesAvaliacao, id: \.self) { opcao in
                                    Button(action: {
                                        avaliacaoSelecionada = opcao
                                    }) {
                                        Text(opcao)
                                            .font(.footnote)
                                            .fontWeight(.medium)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .background(avaliacaoSelecionada == opcao ? Color.blue : Color(.systemGray5))
                                            .foregroundColor(avaliacaoSelecionada == opcao ? .white : .primary)
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
                            Text("\(Int(distanciaMaxima)) KM")
                                .foregroundColor(.secondary)
                        }
                        Slider(value: $distanciaMaxima, in: 1...20, step: 1)
                    }
                    
                    Toggle("Contato disponível", isOn: $contatoDisponivel)
                }
                
                Section(header: Text("Tipo de instituição")) {
                    ForEach(tiposSelecionados.keys.sorted(), id: \.self) { tipo in
                        HStack {
                            Text(tipo)
                            Spacer()
                            if tiposSelecionados[tipo] == true {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            tiposSelecionados[tipo]?.toggle()
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Filtros", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancelar") { dismiss() },
                trailing: Button("Limpar Tudo") {
                    abertoAgora = false
                    distanciaMaxima = 5.0
                    contatoDisponivel = false
                    avaliacaoSelecionada = "Todas"
                    for key in tiposSelecionados.keys { tiposSelecionados[key] = true }
                }
            )
        }
    }
}
    //#Preview {
    //    FiltrosView()
    //}

