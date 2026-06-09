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

    var body: some View {
        TabView {
            NavigationView {

                VStack{
                    TextField("Pesquisar por nome ou bairro...", text: $viewModel.textoPesquisa)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    List(viewModel.locais){ local in LocalRowView(
                        nome: local.nome,
                        tipo: "Instituição",
                        logradouro: local.logradouro,
                        numero: local.numero,
                        bairro: local.bairro,
                        avaliacao: 4.7,
                        abertoAgora: local.abertoAgora,
                        distancia: local.distanciaSimulada
                        )
                    }

                }
                .navigationTitle("Lista de locais")
                .navigationBarItems(trailing: Button(action: { mostrandoFiltros = true }) {
                    Image(systemName: "line.3.horizontal.decrease.circle").font(.title2)
                })
            }
            .tabItem { Label("Locais", systemImage: "list.bullet") }
            MapaView()
                .tabItem { Label("Explorar", systemImage: "map")}
        }
        .sheet(isPresented: $mostrandoFiltros) { FiltrosView(viewModel: viewModel) }
    }
}


#Preview {
    MainView()
}
