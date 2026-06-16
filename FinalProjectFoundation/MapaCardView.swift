//
//  MapCardView.swift
//  FinalProjectFoundation
//
//  Created by Found on 12/06/26.
//

import SwiftUI

struct MapaCardView: View {
    let local: Local
    @Binding var localSelecionado: Local?
    
    var body: some View {
        HStack(spacing: 12) {
            Image(local.nome.localizedCaseInsensitiveContains("Cuca") ? "cuca_mondubim" : "bece")
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .cornerRadius(8)
                .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(local.nome)
                    .font(.headline)
                    .lineLimit(1)
                Text(local.bairro)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: { localSelecionado = nil }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 4)
        .padding()
    }
}
//#Preview {
//    MapCardView()
//}
