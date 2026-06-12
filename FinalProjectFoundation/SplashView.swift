//
//  SwiftUIView.swift
//  FinalProjectFoundation
//
//  Created by Found on 12/06/26.
//

import SwiftUI

struct SplashView: View {
    @State private var exibirAlertaLocalizacao = false
    @State private var redirecionarParaApp = false
    @State private var abaInicial = 0
    
    var body: some View {
        if redirecionarParaApp {
            MainView(abaInicial: abaInicial)
        } else {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.05, green: 0.4, blue:0.15), Color(red: 0.15, green: 0.6, blue: 0.25)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    Image(systemName: "book.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                    
                    Text("CultFortiri")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .tracking(2)
                    
                    Text("Descubra o mundo ao seu redor")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Spacer()
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.2)
                        .padding(.bottom, 30)
                }
                .blur(radius: exibirAlertaLocalizacao ? 6 : 0)
                .animation(.easeInOut, value: exibirAlertaLocalizacao)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    exibirAlertaLocalizacao = true
                }
            }
            .alert(isPresented: $exibirAlertaLocalizacao) {
                Alert(
                    title: Text("Permitir Localização?"),
                    message: Text("O aplicativo precisa da sua localização para calcular a distância exata até os centros culturais."),
                    primaryButton: .default(Text("Permitir")) {
                        withAnimation {
                            abaInicial = 1
                            redirecionarParaApp = true
                        }
                    },
                    secondaryButton: .cancel(Text("Não Permitir")) {
                        withAnimation {
                            abaInicial = 0
                            redirecionarParaApp = true
                        }
                    }
                )
            }
        }
    }
}


#Preview {
    SplashView()
}
