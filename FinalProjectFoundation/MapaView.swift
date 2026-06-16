//
//  MapaView.swift
//  FinalProjectFoundation
//
//  Created by Found on 02/06/26.
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
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @State private var localSelecionado: Local?
    @State private var irParaDetalhes = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                Map(coordinateRegion: $region, annotationItems: obterPinos()) { pino in
                    MapAnnotation(coordinate: pino.coordinate) {
                        Button(action: {
                            withAnimation(.spring()) {
                                localSelecionado = viewModel.locais.first { $0.nome == pino.name }
                            }
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
                
                TextField("Pesquisar por nome ou bairro...", text: $viewModel.textoPesquisa)
                    .padding(12)
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .shadow(radius: 4)
                    .padding(.horizontal)
                    .padding(.top, 10)
                
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
