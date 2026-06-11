import SwiftUI

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
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Text("Endereço").font(.headline)
                    Text("\(local.logradouro), \(local.numero) - \(local.bairro)")
                        .foregroundColor(.secondary)
                    
                    if let contato = local.contato {
                        Text("Contatos").font(.headline)
                        if let tel = contato.telefone { Text("📞 Telefone: \(tel)") }
                        if let web = contato.website { Text("🌐 Site: \(web)") }
                    }
                    
                    Text("Horários de Funcionamento").font(.headline)
                    ForEach(local.horarios, id: \.id_horario) { horario in
                        HStack {
                            Text(horario.dia_semana)
                            Spacer()
                            if let abertura = horario.hora_abertura, let fechamento = horario.hora_fechamento {
                                Text("\(abertura) às \(fechamento)")
                            } else {
                                Text(horario.status_dia ?? "Fechado")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .font(.subheadline)
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
                    let url = URL(string: "http://maps.apple.com/?daddr=\(local.latitude ?? -3.7318),\(local.longitude ?? -38.5266)&dirflg=d")!
                    UIApplication.shared.open(url)
                },
                secondaryButton: .cancel(Text("Cancelar"))
            )
        }
    }
}
