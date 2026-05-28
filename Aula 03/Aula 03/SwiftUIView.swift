//
//  SwiftUIView.swift
//  Aula 03
//
//  Created by Turma02-23 on 27/05/26.
//

import SwiftUI
struct SwiftUIView: View {
    @State private var nome: String = ""
    @State private var alerta: Bool = false
    var body: some View {
            VStack{
                HStack{
                    Text("Bem vindo, Luanderson")
                        .font(.title)
                }
                .padding()
                HStack{
                    TextField("Digite aqui", text: $nome)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .multilineTextAlignment(.center)
                }
            }
            Spacer()
            VStack{
                ZStack{
                    AsyncImage(url: URL(string: "https://preview.redd.it/i-absolutely-love-the-yellow-disc-on-batman-but-man-that-v0-jh8aa2dij3c71.jpg?width=640&crop=smart&auto=webp&s=12ff6b7a2dbd6ee2147822936a55c8412798d676")).opacity(0.7)
                    Image("batman")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .offset(x:10, y: 110)
                }
            }
            .offset(y: -30)
            .padding()
            Spacer()
            VStack{
                Button("Entrar"){
                    alerta = true
                }
                .padding()
                .alert("ALERTA", isPresented: $alerta){
                    Button("Vamos lá", role: .cancel){}
                }
                message: {
                    Text("Voce irá iniciar o desafio agora!")
                }
            }
    }
}

#Preview {
    SwiftUIView()
}
