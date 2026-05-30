//
//  ContentView.swift
//  Aula 05 D2
//
//  Created by Turma02-23 on 29/05/26.
//

import SwiftUI

struct TelaPrincipal: View{
    @State private var mensagem: String = ""
    var body: some View{
        NavigationStack{
            VStack{
                Text("Menu de Cores")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                Spacer().frame(height: 100)
                TextField("Digite uma mensagem", text: $mensagem).padding().multilineTextAlignment(.center)
                VStack{
                    HStack{
                        NavigationLink(destination: TelaColorida(corTela: .pink, iconeTela: "paintbrush", texto: $mensagem)){
                            ZStack{
                                Image(systemName: "paintbrush")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                                    .zIndex(1)
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(30)
                                    .foregroundColor(.pink)
                            }
                        }
                        NavigationLink(destination: TelaColorida(corTela: .blue, iconeTela: "theatermask.and.paintbrush", texto: $mensagem)){
                            ZStack{
                                Image(systemName: "theatermask.and.paintbrush")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                                    .zIndex(1)
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(30)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    HStack{
                        NavigationLink(destination: TelaColorida(corTela: .gray, iconeTela: "paintpalette", texto: $mensagem)){
                            ZStack{
                                Image(systemName: "paintpalette")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                                    .zIndex(1)
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(30)
                                    .foregroundColor(.gray)
                            }
                        }
                        NavigationLink(destination: TelaColorida(corTela: .purple, iconeTela: "list.bullet.clipboard", texto: $mensagem)){
                            ZStack{
                                Image(systemName: "list.bullet.clipboard")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                                    .zIndex(1)
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(30)
                                    .foregroundColor(.purple)
                            }
                        }
                    }
                }
                
            }
        }
    }
}

struct TelaColorida: View{
    let corTela: Color
    let iconeTela: String
    @Binding var texto: String
    var body: some View{
        ZStack{
            corTela.ignoresSafeArea()
            Circle()
                .foregroundColor(.black)
                .padding()
            VStack{
                Image(systemName: iconeTela)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(corTela)
                Text(texto).foregroundColor(.black).zIndex(1).offset(y: 140).font(.title2)
            }
        }
    }
}

#Preview {
    TelaPrincipal()
}
