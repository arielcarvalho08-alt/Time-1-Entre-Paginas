//
//  DetalhesView.swift
//  FinalProjectFoundation
//
//  Created by Found on 09/06/26.
//

import SwiftUI

struct DetalhesView: View {
    let nome: String
    let logradouro: String
    let numero: String
    let bairro: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(nome.localizedCaseInsensitiveContains("Cuca") ? "cuca_mondumbim" : (nome.localizedCaseInsensitiveContains("Biblioteca") || nome.localizedCaseInsensitiveContains("BECE") ? "bece" : "photo"))
                .resizable()
                .scaledToFill()
                .frame(height: 220)
                .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(nome)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Divider()
                
                Text("Endereço Completo")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("\(logradouro), Nº \(numero)")
                    .font(.body)
                Text("Bairro: \(bairro)")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding()
            
            Spacer()
        }
        
        .navigationBarTitle("Informações")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    DetalhesView()
//}
