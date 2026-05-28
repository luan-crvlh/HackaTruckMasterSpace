//
//  ContentView.swift
//  Aula 04
//
//  Created by Turma02-23 on 28/05/26.
//

import SwiftUI

struct ContentView: View {
    @State private var dist: Double = 0
    @State private var tempo: Double = 1
    @State private var speed: Double = 0
    @State private var corFundo: String = "standard"
    @State private var imagem: String = "lobisomem"
    @State private var calculo: Bool = false
    var body: some View {
            VStack {
                Color(corFundo).ignoresSafeArea()
                Spacer().frame(height: 80)
                Text("Digite a distância (km)").padding()
                TextField("Digite o valor em km", value: $dist, format: .number)
                    .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                        .textContentType(.oneTimeCode)
                        .padding()
                        .background(Color.black.opacity(0.15))
                        .cornerRadius(20)
                        .frame(width: 250)
                
                Text("Digite o tempo (h)").padding()
                
                TextField("Digite o valor em horas", value: $tempo, format: .number)
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
                    .textContentType(.oneTimeCode)
                    .padding()
                    .background(Color.black.opacity(0.15))
                    .cornerRadius(20)
                    .frame(width: 250)
                Button("Calcular"){
                    calculo = true
                    speed = dist/tempo
                    if speed < 9.5{
                        imagem = "tartaruga"
                    }
                    else if speed >= 9.5 && speed < 29.5{
                        imagem = "elefante"
                    }
                    else if speed >= 29.5 && speed < 69.5{
                        imagem = "avestruz"
                    }
                    else if speed >= 69.5 && speed < 89.5{
                        imagem = "leao"
                    }
                    else if speed >= 89.5 && speed < 129.5{
                        imagem = "guepardo"
                    }
                    else{
                        imagem = "lobisomem"
                    }
                }
                .font(.title)
                .foregroundColor(.red)
                .padding()
                .background(.black)
                .cornerRadius(20)
            }
            VStack{
                Text("\(speed, specifier: "%.2f") KM/H").font(.title2)
                Image(imagem)
                    .resizable()
                    .frame(width: 250, height: 250)
                    .cornerRadius(300)
            }
        Spacer()
                VStack{
                    Text("Tartaruga: 0 - 9.5 km/h").foregroundColor(.lowest)
                    Text("Elefante: 9.5 - 29.5 km/h").foregroundColor(.low)
                    Text("Avestruz: 29.5 - 69.5 km/h").foregroundColor(.mid)
                    Text("Leão: 69.5 - 89.5 km/h").foregroundColor(.high)
                    Text("Guepardo: 89.5 - 129.5 km/h").foregroundColor(.highest)
                }.zIndex(1)
                    .padding()
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 300, height: 150)
                        .offset(y: -150)
                }

    }
}

#Preview {
    ContentView()
}
