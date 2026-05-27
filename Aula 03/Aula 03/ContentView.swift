//
//  ContentView.swift
//  Aula 03
//
//  Created by Turma02-23 on 27/05/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20){
            HStack{
                Rectangle()
                    .fill(.red)
                    .frame(width: 100, height: 100)
                Spacer()
                    .frame(width: 150)
                Rectangle()
                    .fill(.blue)
                    .frame(width: 100, height: 100)
            }
            Spacer().frame(height:500)
            HStack{
                Rectangle()
                    .fill(.green)
                    .frame(width: 100, height: 100)
                Spacer()
                    .frame(width: 150)
                Rectangle()
                    .fill(.yellow)
                    .frame(width: 100, height: 100)
            }
        }
    }
}

struct ContentView2: View{
    var body: some View{
        HStack{
            AsyncImage(url: URL(string: "https://images.seeklogo.com/logo-png/27/1/batman-logo-png_seeklogo-272686.png"), scale: 4)
            Spacer().frame(width: 30)
            VStack{
                Text("HackaTruck")
                .foregroundColor(.red)
                Spacer().frame(height: 5)
                Text("77 Universidades")
                .foregroundColor(.blue)
                Spacer().frame(height: 5)
                Text("5 regiões do Brasil")
                .foregroundColor(.yellow)
                Spacer().frame(height: 5)
            }
        }
    }
}

#Preview {
    //ContentView()
    ContentView2()
}
