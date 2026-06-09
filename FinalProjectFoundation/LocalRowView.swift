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
        let endereco: String
        let avaliacao: Double
        let abertoAgora: Bool
        let distancia: String
        
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray5))
                .frame(width: 100, height: 100)
                .overlay(Image(systemName: "photo").foregroundColor(.gray))
            VStack(alignment: .leading, spacing: 4) {
                Text(nome)
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.bold)
                Text("\(tipo), \(endereco)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                HStack {
                    Label(String(format: "%.1f", avaliacao), systemImage: "star.fill")
                        .font(.caption)
                        .foregroundColor(.orange)
                    
                    Spacer()
                Text(abertoAgora ? "Aberto agora" : "Fechado")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.horizontal,8)
                        .padding(.vertical, 4)
                        .background(abertoAgora ? Color.green.opacity(0.15) : Color.red.opacity(0.15))
                        .foregroundColor(abertoAgora ? .green : .red)
                        .clipShape(Capsule())
                }
            }
        }
        .padding(.vertical, 4)
    }
}


//#Preview {
//    LocalRowView()
//}
