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
        Map(coordinateRegion: $region, annotationItems: obterPinos()) { pino in
            MapAnnotation(coordinate: pino.coordinate) {
                VStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
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
