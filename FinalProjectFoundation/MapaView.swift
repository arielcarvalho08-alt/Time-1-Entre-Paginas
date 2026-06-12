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
        center: CLLocationCoordinate2D(latitude: -3.7319, longitude: -38.5267),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @State private var localSelecionado: Local?
    
    var body: some View {
        ZStack(alignment: .bottom){
            Map(coordinateRegion: $region, annotationItems: obterPinos()) { pino in
                MapAnnotation(coordinate: pino.coordinate) {
                    Button(action: {
                        withAnimation{
                            localSelecionado = viewModel.locais.first { $0.nome == pino.name}
                        }
                    }) {
                        Image(systemName: "mappin")
                            .font(.title)
                            .foregroundColor(.red)
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            if let local = localSelecionado {
                MapaCardView(local: local, localSelecionado: $localSelecionado)
                    .padding(.bottom, 60)
            }
        }
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
