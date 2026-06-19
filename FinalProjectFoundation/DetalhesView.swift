//
//  DetalhesView.swift
//  FinalProjectFoundation
//
//  Created by Found on 11/06/26.
//

import SwiftUI
import MapKit

struct DetalhesView: View {
    let local: Local
    @State private var mostrarAlertaRota = false
    @State private var isFavorited: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(obterNomeImagemManual(para: local))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 220)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .center) {
                        Text(local.nome)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {
                            if let id = local.id {
                                DatabaseManager.shared.favoritarLocal(idLocal: id)
                                isFavorited.toggle()
                            }
                        }) {
                            Image(systemName: isFavorited ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                                .font(.title2)
                                .padding(8)
                                .background(Color(.systemGray6))
                                .clipShape(Circle())
                        }
                    }
                    
                    Button(action: { mostrarAlertaRota = true }) {
                        HStack {
                            Spacer()
                            Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                            Text("Traçar Rota")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.vertical, 16)
                        .foregroundColor(.white)
                        .background(Color.verdePrincipal)
                        .cornerRadius(10)
                    }
                    
                    Text("Endereço").font(.headline)
                    Text("\(local.logradouro), \(local.numero) - \(local.bairro)")
                        .foregroundColor(.secondary)
                    
                    if let contato = local.contato {
                        Text("Contatos").font(.headline)
                        
                        if let tel = contato.telefone, !tel.isEmpty {
                            Button(action: {
                                let fixo = tel.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                                if let url = URL(string: "tel://\(fixo)") {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                HStack {
                                    Text("📞 Telefone: \(tel)")
                                        .foregroundColor(.verdePrincipal)
                                        .underline()
                                    Spacer()
                                }
                            }
                        }
                        
                        if let web = contato.website, !web.isEmpty {
                            let urlString = web.lowercased().hasPrefix("http") ? web : "https://\(web)"
                            if let url = URL(string: urlString) {
                                Link(destination: url) {
                                    HStack {
                                        Text("🌐 Site: \(web)")
                                            .foregroundColor(.verdePrincipal)
                                            .underline()
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                    
                    Text("Horários de Funcionamento")
                        .font(.headline)

                    VStack(spacing: 8) {
                        ForEach(local.horarios, id: \.id_horario) { teammate in
                            HStack {
                                Text(teammate.dia_semana)
                                
                                Spacer()
                                
                                if let abertura = teammate.hora_abertura,
                                   let fechamento = teammate.hora_fechamento,
                                   !abertura.isEmpty,
                                   !fechamento.isEmpty {
                                    Text("\(abertura) às \(fechamento)")
                                } else {
                                    Text("Fechado")
                                        .foregroundColor(.secondary)
                                }
                            }
                            .font(.subheadline)
                        }
                    }
                    Divider().padding(.vertical, 8)
                    
                    Text("Avaliações do Google")
                        .font(.headline)
                    
                    if local.avaliacoes.isEmpty {
                        Text("Nenhum comentário enviado.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    } else {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(local.avaliacoes, id: \.id_avaliacao) { avaliacao in
                                AvaliacaoRowView(avaliacao: avaliacao)
                                
                                if avaliacao.id_avaliacao != local.avaliacoes.last?.id_avaliacao {
                                    Divider().opacity(0.4)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            if let id = local.id {
                isFavorited = DatabaseManager.shared.verificarSeEFavorito(idLocal: id)
            }
        }
        .alert(isPresented: $mostrarAlertaRota) {
            Alert(
                title: Text("Você está saindo do App"),
                message: Text("Deseja abrir o Apple Maps para traçar a rota até \(local.nome)?"),
                primaryButton: .default(Text("Sim")) {
                    if let lat = local.latitude, let lon = local.longitude {
                        let destinoCoordenadas = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                        let placemark = MKPlacemark(coordinate: destinoCoordenadas)
                        let mapItem = MKMapItem(placemark: placemark)
                        mapItem.name = local.nome
                        
                        let opcoesLancamento = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                        mapItem.openInMaps(launchOptions: opcoesLancamento)
                    }
                },
                secondaryButton: .cancel(Text("Cancelar"))
            )
        }
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
