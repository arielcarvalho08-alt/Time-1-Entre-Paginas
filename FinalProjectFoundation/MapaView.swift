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
        span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
    )
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $regiao, annotationItems: viewModel.locais) { local in 
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: local.latitude ?? -3.7318, longitude: local.longitude ?? -38.5266)) {
                    VStack(spacing: 0) {
                        Image(systemName: "mappin")
                            .font(.title)
                            .foregroundColor(.red)
                            .shadow(radius: 2)
                        
                        // Mantém o nome completo vindo do banco dinâmico
                        Text(local.nome)
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(4)
                            .background(Color.white)
                            .cornerRadius(4)
                            .shadow(radius: 2)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Mapa de Locais")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MapaView()
}