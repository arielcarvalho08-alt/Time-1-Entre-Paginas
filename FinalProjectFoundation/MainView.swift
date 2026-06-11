//
//  ContentView.swift
//  FinalProjectFoundation
//
//  Created by Beatriz Leonel on 28/05/26.
//

import SwiftUI

struct MainView: View {
    @State private var mostrandoFiltros = false
    @StateObject private var viewModel = LocaisViewModel()
    
    @State private var abaSelecionada = 0
    @State private var exibirAlertaLocalizacao = false
    
    var body: some View {
        TabView(selection: $abaSelecionada) {
            NavigationView {
                VStack {
                    TextField("Pesquisar por nome ou bairro...", text: $viewModel.textoPesquisa)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    List(viewModel.locais) { local in
                        NavigationLink(destination: DetalhesView(local: local)) {
                            LocalRowView(local: local)
                        }
                    }
                }
                .navigationTitle("Lista de locais")
                .navigationBarItems(trailing: Button(action: { mostrandoFiltros = true }) {
                    Image(systemName: "line.3.horizontal.decrease.circle").font(.title2)
                })
            }
            .tabItem { Label("Locais", systemImage: "list.bullet") }
            .tag(0)
            
            MapaView(viewModel: viewModel)
                .tabItem { Label("Explorar", systemImage: "map")}
                .tag(1)
        }
        .sheet(isPresented: $mostrandoFiltros) { FiltrosView(viewModel: viewModel) }
        .alert(isPresented: $exibirAlertaLocalizacao) {
            Alert(
                title: Text("Permitir Localização?"),
                message: Text("O aplicativo precisa da sua localização para calcular a distância exata até os centros culturais."),
                primaryButton: .default(Text("Permitir")) {
                    abaSelecionada = 1
                },
                secondaryButton: .cancel(Text("Não Permitir")) {
                    abaSelecionada = 0
                }
            )
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                exibirAlertaLocalizacao = true
            }
        }
    }
}

#Preview {
    MainView()
}
