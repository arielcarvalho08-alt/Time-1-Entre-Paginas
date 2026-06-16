import SwiftUI
import MapKit 

struct DetalhesView: View {
    let local: Local
    @State private var mostrarAlertaRota = false
    @State private var isFavorited: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(local.nome.localizedCaseInsensitiveContains("Cuca") ? "cuca_mondubim" : "bece")
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
                        Text("Traçar Rota")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.verdePrincipal)
                            .cornerRadius(10)
                    }
                    
                    Text("Endereço").font(.headline)
                    Text("\(local.logradouro), \(local.numero) - \(local.bairro)")
                        .foregroundColor(.secondary)
                    
                    if let contato = local.contato {
                        Text("Contatos").font(.headline)
                        if let tel = contato.telefone, !tel.isEmpty { Text("📞 Telefone: \(tel)") }
                        if let web = contato.website, !web.isEmpty { Text("🌐 Site: \(web)") }
                    }
                    
                    Text("Horários de Funcionamento")
                        .font(.headline)

                    VStack(spacing: 8) {
                        ForEach(local.horarios, id: \.id_horario) { horario in
                            HStack {
                                Text(horario.dia_semana)
                                
                                Spacer()
                                
                                if let abertura = horario.hora_abertura,
                                   let fechamento = horario.hora_fechamento,
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
}
