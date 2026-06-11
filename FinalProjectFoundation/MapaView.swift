//
//  MapaView.swift
//  FinalProjectFoundation
//
//  Created by Found on 02/06/26.
//

import SwiftUI
import MapKit

struct MapaPin: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapaView: View {
    @ObservedObject var viewModel: LocaisViewModel
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -3.7319, longitude: -38.5267), // Centro de Fortaleza
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var body: some View {
        Map(coordinateRegion: $regiao, annotationItems: viewModel.locais) { local in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: local.latitude ?? -3.7318, longitude: local.longitude ?? -38.5266)) {
                Button(action: {
                    localSelecionado = local // Ativa o Card (Tela 5)
                }) {
                    Image(systemName: "mappin")
                        .font(.title)
                        .foregroundColor(.red)
                    Text(pino.name)
                        .font(.caption)
                        .bold()
                        .padding(4)
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(radius: 2)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private func obterPinos() -> [MapaPin] {
        return viewModel.locais.compactMap { local in
            guard let lat = local.latitude, let lon = local.longitude else { return nil }
            return MapaPin(name: local.nome, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
        }
    }
}
//#Preview {
//    MapaView()
//}
