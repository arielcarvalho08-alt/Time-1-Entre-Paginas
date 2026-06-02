//
//  FiltrosView.swift
//  FinalProjectFoundation
//
//  Created by Found on 02/06/26.
//

import SwiftUI

struct FiltrosView: View {
    @Environment(\.dismiss) var dismiss
    @State private var abertoAgora = false
    @State private var distanciaMaxima : Double = 5.0
    @State private var contatoDisponivel = false
    
    var body: some View{
        NavigationView{
            List{
                Section(header: Text("Filtros")){
                    Toggle("Aberto agora", isOn: $abertoAgora)
                    VStack(alignment: .leading, spacing: 8){
                        HStack{
                            Text("Distância máxima")
                            Spacer()
                            Text("\(Int(distanciaMaxima))KM")
                                .foregroundColor(.secondary)
                        }
                        Slider(value: $distanciaMaxima, in: 1...20, step: 1)}
                    Toggle("Contato disponível", isOn: $contatoDisponivel)}
                Section(header: Text("Tipo de instituição")){
                    HStack{
                        Text("Bibliotecas comunitárias")
                        Spacer()
                        Image(systemName: "checkmark") .foregroundColor (.blue)
                    }
                    HStack{
                        Text("Cucas(Rede Cuca)")
                        Spacer()
                        Image(systemName: "checkmark")
                    .foregroundColor (.blue)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(Text("Filtros"), displayMode: .inline)
        .navigationBarItems(
        leading: Button("Cancelar") { dismiss() },
        trailing: Button ("Limpar tudo"){
                abertoAgora = false
                distanciaMaxima = 5
                contatoDisponivel = false
                
            }
        )
        }
    }

    
    
    
    
    
    
    
    
    
    
    
}

#Preview {
    FiltrosView()
}
