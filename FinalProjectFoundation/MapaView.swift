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

    @State private var regiao = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -3.7318, longitude: -38.5266),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    var body: some View {
        NavigationView {
            Map(coordinateRegion: $regiao, annotationItems: viewModel.locais) { local in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: local.latitude ?? -3.7318, longitude: local.longitude ?? -38.5266)) {
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                        Text(local.nome)
                            .font(.caption)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(4)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Fortaleza")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
#Preview {
    MapaView()
}
