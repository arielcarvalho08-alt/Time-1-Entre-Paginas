//
//  MapaView.swift
//  FinalProjectFoundation
//
//  Created by Found on 02/06/26.
//

import SwiftUI
import MapKit

struct MapaView: View{
    @State private var regiao = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -3.7318, longitude: -38.5266),
               span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
               )
    var body: some View {
            NavigationView {
                ZStack {
                Map(coordinateRegion: $regiao)
                    .edgesIgnoringSafeArea(.bottom)
            }
            .navigationTitle("Fortaleza")
            .navigationBarTitleDisplayMode(.inline)
            }
        }
    }

#Preview {
    MapaView()
}
