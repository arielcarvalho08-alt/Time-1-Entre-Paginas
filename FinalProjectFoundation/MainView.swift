//
//  MainView.swift
//  FinalProjectFoundation
//
//  Created by Beatriz Leonel on 28/05/26.
//

import SwiftUI

struct MainView: View {
    @State private var mostrandoFiltros = false
    @StateObject private var viewModel = LocaisViewModel()
    @State var abaSelecionada: Int
    @State private var localSelecionadoViaSugestao: Local?
    @State private var irParaDetalhesDireto = false
    
    private var locaisFiltrados: [Local] {
        viewModel.locais.filter { local in
            viewModel.textoPesquisa.isEmpty ? true : local.nome.localizedCaseInsensitiveContains(viewModel.textoPesquisa)
        }
    }
    
    init(abaInicial: Int) {
        _abaSelecionada = State(initialValue: abaInicial)
    }
    
    var body: some View {
        TabView(selection: $abaSelecionada) {
            NavigationView {
                VStack(spacing: 0) {
                    TextField("Pesquisar por nome ou bairro...", text: $viewModel.textoPesquisa)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding([.horizontal, .top])
                        .padding(.bottom, 12)
                    
                    ZStack(alignment: .top) {
                        
                        if locaisFiltrados.isEmpty && !viewModel.textoPesquisa.isEmpty {
                            VStack(spacing: 12) {
                                Spacer()
                                Image(systemName: "magnifyingglass.circle")
                                    .font(.system(size: 64))
                                    .foregroundColor(.gray)
                                Text("Nenhum local encontrado")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text("Tente mudar os termos ou verificar a ortografia do bairro.")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 32)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            List(locaisFiltrados) { local in
                                NavigationLink(destination: DetalhesView(local: local)) {
                                    LocalRowView(local: local)
                                }
                            }
                            .listStyle(.plain)
                        }
                        
                        if let localDestino = localSelecionadoViaSugestao {
                            NavigationLink(
                                destination: DetalhesView(local: localDestino),
                                isActive: $irParaDetalhesDireto
                            ) {
                                EmptyView()
                            }
                        }
                        
                        if !viewModel.textoPesquisa.isEmpty {
                            VStack(alignment: .leading, spacing: 0) {
                                ScrollView {
                                    VStack(alignment: .leading, spacing: 0) {
                                        ForEach(viewModel.locais.filter { $0.nome.localizedCaseInsensitiveContains(viewModel.textoPesquisa) }, id: \.id) { localSugerido in
                                            Button(action: {
                                                localSelecionadoViaSugestao = localSugerido
                                                irParaDetalhesDireto = true
                                                viewModel.textoPesquisa = ""
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                            }) {
                                                HStack(spacing: 12) {
                                                    Image(systemName: "magnifyingglass")
                                                        .foregroundColor(.secondary)
                                                    Text(localSugerido.nome)
                                                        .foregroundColor(.primary)
                                                        .lineLimit(1)
                                                    Spacer()
                                                }
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 14)
                                            }
                                            
                                            Divider().padding(.horizontal, 16)
                                        }
                                    }
                                }
                                .frame(maxHeight: 180)
                            }
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
                            .padding(.horizontal)
                            .zIndex(5)
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
