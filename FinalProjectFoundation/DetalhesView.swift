//
//  DetalhesView.swift
//  FinalProjectFoundation
//
//  Created by Found on 09/06/26.
//
import SwiftUI
struct DetalhesView: View {
    let local: Local
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(local.nome.localizedCaseInsensitiveContains("Cuca") ? "cuca_mondumbim" : (local.nome.localizedCaseInsensitiveContains("Biblioteca") || local.nome.localizedCaseInsensitiveContains("BECE") ? "bece" : "photo"))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 220)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(local.nome)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text(local.abertoAgora ? "● Aberto Agora" : "● Fechado")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                                                     .foregroundColor(local.abertoAgora ? .green : .red)
                                                 
                                                 Text("•")
                                                     .foregroundColor(.secondary)
                                                 
                                                 Text("\(Int(local.distanciaSimulada)) KM de distância")
                                                     .font(.subheadline)
                                                     .foregroundColor(.secondary)
                                             }
                                             
                                             Divider()
                                             
                                             Text("Endereço Completo")
                                                 .font(.headline)
                                                 .foregroundColor(.secondary)
                                             
                                             Text("\(local.logradouro), Nº \(local.numero)")
                                                 .font(.body)
                                             Text("Bairro: \(local.bairro)")
                                                 .font(.body)
                                                 .foregroundColor(.secondary)
                                         }
                                         .padding(.horizontal)
                                     }
                                     
                                     .navigationBarTitle("Informações")
                                     .navigationBarTitleDisplayMode(.inline)
                                 }
                             }
                             
                             //#Preview {
                             //    DetalhesView()
                             //}
                         }
