//
//  LocalRowView.swift
//  FinalProjectFoundation
//
//  Created by Found on 02/06/26.
//

import SwiftUI
import CoreLocation

struct LocalRowView: View {
    let local: Local
    
    private var isLocationAuthorized: Bool {
        let manager = CLLocationManager()
        return CLLocationManager.locationServicesEnabled() &&
            (manager.authorizationStatus == .authorizedWhenInUse ||
             manager.authorizationStatus == .authorizedAlways)
    }
        
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(obterNomeImagemManual(para: local))
                .resizable()
                .scaledToFill()
                .frame(height: 160)
                .cornerRadius(12)
                .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(local.nome)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                HStack {
                    Text(String(format: "★ %.1f", local.mediaAvaliacao))
                        .foregroundColor(.orange)
                        .font(.subheadline)
                    
                    if isLocationAuthorized {
                        Text("•")
                            .foregroundColor(.secondary)
                        
                        Text("A \(local.distanciaCalculada) km de você")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Text("•")
                        .foregroundColor(.secondary)
                    
                    Text("\(local.bairro)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(local.aberto_agora ? "Aberto" : "Fechado")
                        .font(.caption)
                        .bold()
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(local.aberto_agora ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                        .foregroundColor(local.aberto_agora ? .green : .red)
                        .cornerRadius(8)
                }
            }
            .padding(12)
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
        .padding(.vertical, 6)
    }
    
    private func obterNomeImagemManual(para local: Local) -> String {
        let nomeMinusculo = local.nome.lowercased()
        
        if nomeMinusculo.contains("cuca") {
            if nomeMinusculo.contains("mondubim") { return "cuca_mondubim" }
            if nomeMinusculo.contains("barra") { return "cuca_barra" }
            if nomeMinusculo.contains("jangurussu") { return "cuca_jangurussu" }
            if nomeMinusculo.contains("pici") { return "cuca_pici" }
            if nomeMinusculo.contains("walter") { return "cuca_josewalter" }
            return "cuca_mondubim"
        } else if nomeMinusculo.contains("bece") || nomeMinusculo.contains("estado") {
            return "foto_bece"
        } else if nomeMinusculo.contains("comunitária") {
            return "biblioteca_cuca_pici"
        } else if nomeMinusculo.contains("nordeste") || nomeMinusculo.contains("ccbnb") {
            return "foto_ccbnb"
        } else if nomeMinusculo.contains("dolor") {
            return "biblioteca_dolor"
        } else if nomeMinusculo.contains("vila") || nomeMinusculo.contains("artes") {
            return "vila_das_artes"
        }
        
        return "foto_bece"
    }
}
