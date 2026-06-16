//
//  MapaView.swift
//  FinalProjectFoundation
//

import SwiftUI
import MapKit

struct MapaPin: Identifiable {
    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapaView: View {
    @ObservedObject var viewModel: LocaisViewModel
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -3.7319, longitude: -38.5267),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var localSelecionado: Local?
    @State private var irParaDetalhes = false
    @State private var mostrarSugestoesMap = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                Map(coordinateRegion: $region, annotationItems: obterPinos()) { pino in
                    MapAnnotation(coordinate: pino.coordinate) {
                        Button(action: {
                            focarNoLocal(porNome: pino.name)
                        }) {
                            VStack(spacing: 2) {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.red)
                                    .shadow(radius: 2)
                                
                                Text(pino.name)
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 3)
                                    .background(Color.white.opacity(0.9))
                                    .foregroundColor(.black)
                                    .cornerRadius(6)
                                    .shadow(radius: 1)
                                    .lineLimit(1)
                            }
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    TextField("Pesquisar no mapa...", text: $viewModel.textoPesquisa, onCommit: {
                        if let primeiroEncontrado = filtrarLocaisSugeridos().first {
                            focarNoLocal(porNome: primeiroEncontrado.nome)
                        }
                        mostrarSugestoesMap = false
                        viewModel.textoPesquisa = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    })
                    .padding(12)
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 3)
                    .padding([.horizontal, .top])
                    .onChange(of: viewModel.textoPesquisa) { texto in
                        mostrarSugestoesMap = !texto.isEmpty
                    }
                    if mostrarSugestoesMap && !filtrarLocaisSugeridos().isEmpty {
                        VStack(alignment: .leading, spacing: 0) {
                            ScrollView {
                                VStack(alignment: .leading, spacing: 0) {
                                    ForEach(filtrarLocaisSugeridos(), id: \.id) { local in
                                        Button(action: {
                                            focarNoLocal(porNome: local.nome)
                                            
                                            mostrarSugestoesMap = false
                                            viewModel.textoPesquisa = ""
                                            
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                        }) {
                                            HStack(spacing: 12) {
                                                Image(systemName: "mappin.and.ellipse")
                                                    .foregroundColor(.verdePrincipal)
                                                Text(local.nome)
                                                    .foregroundColor(.primary)
                                                    .font(.body)
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
                        .padding(.top, 6)
                    }
                }
                
                if let local = localSelecionado {
                    NavigationLink(
                        destination: DetalhesView(local: local),
                        isActive: $irParaDetalhes
                    ) {
                        EmptyView()
                    }
                }
                VStack {
                    Spacer()
                    if let local = localSelecionado {
                        Button(action: {
                            irParaDetalhes = true
                        }) {
                            MapaCardView(local: local, localSelecionado: $localSelecionado)
                                .foregroundColor(.primary)
                        }
                        .padding(.bottom, 30)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    private func focarNoLocal(porNome nome: String) {
        if let localEncontrado = viewModel.locais.first(where: { $0.nome.localizedCaseInsensitiveContains(nome) }),
           let lat = localEncontrado.latitude, let lon = localEncontrado.longitude {
            
            withAnimation(.easeInOut(duration: 1.2)) {
                region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: lat, longitude: lon),
                    span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
                )
                localSelecionado = localEncontrado
            }
        }
    }
    
    private func filtrarLocaisSugeridos() -> [Local] {
        return viewModel.locais.filter { $0.nome.localizedCaseInsensitiveContains(viewModel.textoPesquisa) }
    }
    
    private func obterPinos() -> [MapaPin] {
        return viewModel.locais.compactMap { local in
            guard let lat = local.latitude, let lon = local.longitude else { return nil }
            return MapaPin(id: local.nome, name: local.nome, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
        }
    }
}
//#Preview {
//    MapaView()
//}
