//
//  ContentView.swift
//  Aula 05
//
//  Created by Turma02-23 on 29/05/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            ContentView3()
                .tabItem{
                    Label("Início", systemImage: "list.bullet.clipboard.fill")
                }
            
            ContentView2()
                .tabItem{
                    Label("Rosa", systemImage: "paintbrush.fill")
                }
            ContentView4()
                .tabItem{
                    Label("Azul", systemImage: "theatermask.and.paintbrush.fill")
                }
            ContentView5()
                .tabItem{
                    Label("Cinza", systemImage: "paintpalette.fill")
                }
        }
    }
}

struct ContentView3: View{
    var body: some View{
        ZStack{
            VStack{
                Text("List")
            }
            VStack{
                List{
                    HStack{
                        Text("Azul")
                        Spacer()
                        Image(systemName: "paintbrush.fill")
                        
                    }
                    HStack{
                        Text("Rosa")
                        Spacer()
                        Image(systemName: "theatermask.and.paintbrush.fill")
                        
                    }
                    HStack{
                        Text("Cinza")
                        Spacer()
                        Image(systemName: "paintbrush.fill")
                        
                    }
                }
            }
        }
    }
}

struct ContentView2: View {
    var body: some View{
        ZStack{
            Color(.pink).ignoresSafeArea()
            Circle()
                .foregroundColor(.black)
                .padding()
            VStack{
                Image(systemName: "paintbrush")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.pink)
            }
        }
    }
}

struct ContentView4: View{
    var body: some View{
        ZStack{
            Color(.blue).ignoresSafeArea()
            Circle()
                .foregroundColor(.black)
                .padding()
            VStack{
                Image(systemName: "theatermask.and.paintbrush")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct ContentView5: View{
    var body: some View{
        ZStack{
            Color(.gray).ignoresSafeArea()
            Circle()
                .foregroundColor(.black)
                .padding()
            VStack{
                Image(systemName: "paintpalette")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    ContentView()
}
