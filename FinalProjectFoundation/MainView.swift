//
//  ContentView.swift
//  FinalProjectFoundation
//
//  Created by Beatriz Leonel on 28/05/26.
//

import SwiftUI

struct MainView: View {
    @State private var mostrandoFiltros = false

    var body: some View {
        TabView {
            NavigationView {
                List {
                    Text("Lista de locais")
                }
                .navigationTitle("Lista de locais")
                .navigationBarItems(trailing: Button(action: { mostrandoFiltros = true }) {
                    Image(systemName: "line.3.horizontal.decrease.circle").font(.title2)
                })
            }
            .tabItem { Label("Locais", systemImage: "list.bullet") }

            Text("Mapa")
                .tabItem { Label("Explorar", systemImage: "map") }
        }
        .sheet(isPresented: $mostrandoFiltros) { FiltrosView() }
    }
}


#Preview {
    MainView()
}
