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
            Image(obterNomeImagemManual(para: local))
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
                
                HStack(spacing: 4) {
                    Circle()
                        .fill(local.aberto_agora ? Color.green : Color.red)
                        .frame(width: 8, height: 8)
                    
                    Text(local.aberto_agora ? "Aberto agora" : "Fechado")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundColor(local.aberto_agora ? .green : .red)
                }
                .padding(.top, 2)
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
