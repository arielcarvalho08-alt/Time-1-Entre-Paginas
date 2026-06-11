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
            HStack {
                HStack(spacing: 2) {
                    ForEach(0..<5) { estrela in
                        Image(systemName: "star.fill")
                            .foregroundColor(Double(estrela) < avaliacao.nota_estrelas ? .orange : .gray.opacity(0.3))
                            .font(.caption)
                    }
                }
                Spacer()
                Text(String(format: "%.1f  􀋃", avaliacao.nota_estrelas) )
                    .font(.caption)
                    .bold()
                    .foregroundColor(.orange)
            }
            if let comentario = avaliacao.comentario, !comentario.isEmpty {
                Text(comentario)
                    .font(.footnote)
                    .foregroundColor(.orange)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
}
//#Preview {
//    AvaliacaoRowView()
//}
