//
//  LocalRowView.swift
//  FinalProjectFoundation
//
//  Created by Found on 02/06/26.
//

import SwiftUI

struct LocalRowView: View {
    let nome: String
    let tipo: String
    let logradouro: String
    let numero: String
    let bairro: String
    let avaliacao: Double
    let abertoAgora: Bool
    let distancia: Double

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(nome.localizedCaseInsensitiveContains("Cuca") ? "cuca_mondubim" : (nome.localizedCaseInsensitiveContains("Biblioteca") || nome.localizedCaseInsensitiveContains("BECE") ? "bece" : "photo"))
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 85)
                .cornerRadius(12)
                .clipped() // Garante que a foto não mude o tamanho do quadrado cinza
            
            VStack(alignment: .leading, spacing: 4) {
                Text(nome)
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.bold)

                Text("\(tipo) • \(Int(distancia)) KM")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("\(logradouro), \(numero) - \(bairro)")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(1)

                HStack {
                    Label(String(format: "%.1f", avaliacao), systemImage: "star.fill")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

//
//#Preview {
//    LocalRowView()
//}
