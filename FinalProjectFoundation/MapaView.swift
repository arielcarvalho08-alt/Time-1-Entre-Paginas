//
//  MapaView.swift
//  FinalProjectFoundation
//
//  Created by Found on 02/06/26.
//

import SwiftUI
import MapKit

struct MapaView: View {
    @StateObject private var viewModel = LocaisViewModel()
    @State private var localSelecionado: Local? = nil
    @State private var regiao = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -3.7318, longitude: -38.5266),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var body: some View {
        Map(coordinateRegion: $regiao, annotationItems: viewModel.locais) { local in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: local.latitude ?? -3.7318, longitude: local.longitude ?? -38.5266)) {
                Button(action: {
                    localSelecionado = local
                }) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundColor(.red)
                }
            }
        }
        .sheet(item: $localSelecionado) { local in
            DetalhesView(local: local)
        }
    }
}
#Preview {
    MapaView()
}
