//
//  LocalRowView.swift
//  FinalProjectFoundation
//
//  Created by Found on 02/06/26.
//

import SwiftUI

struct LocalRowView: View {
    let local: Local
        
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(local.nome.localizedCaseInsensitiveContains("Cuca") ? "cuca_mondubim" : "bece")
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
                    Text(String(format: "􀋃 %.1f", local.mediaAvaliacao))
                        .foregroundColor(.orange)
                        .font(.subheadline)
                    Text("•")
                    Text("\(local.bairro)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(local.aberto_agora ? "aberto" : "fechado")
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
        .padding(.vertical, 6)
            }
        }

//#Preview {
//    LocalRowView()
//}
