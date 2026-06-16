//
//  AvaliacaoRowView.swift
//  FinalProjectFoundation
//
//  Created by Found on 11/06/26.
//

import SwiftUI

struct AvaliacaoRowView: View {
    let avaliacao: Avaliacao
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {

            HStack (spacing: 4){
                HStack(spacing: 1) {
                    ForEach(0..<5) { estrela in
                        Image(systemName: "star.fill")
                            .foregroundColor(Double(estrela) < avaliacao.nota_estrelas ? .orange : .gray.opacity(0.2))
                            .font(.system(size: 11))
                    }
                }
                Text(String(format: "%.1f ", avaliacao.nota_estrelas) )
                    .font(.caption)
                    .bold()
                    .foregroundColor(.orange)
                
                Spacer()
            }
            if let comentario = avaliacao.comentario, !comentario.isEmpty {
                Text(comentario)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                    .padding(.top, 2)
            }
        }
        .padding(.vertical, 6)
    }
}
