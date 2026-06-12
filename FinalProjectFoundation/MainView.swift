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
    @State var abaSelecionada: Int
    
    init(abaInicial: Int) {
        _abaSelecionada = State(initialValue: abaInicial)
    }
    
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
        .accentColor(.verdePrincipal)
    }
}

#Preview {
    MainView(abaInicial: 0)
}
