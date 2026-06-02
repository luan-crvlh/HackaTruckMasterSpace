//
//  ContentView.swift
//  Aula 06
//
//  Created by Turma02-23 on 01/06/26.
//

import SwiftUI

struct Conteudo: Hashable{
    let categoria: String
    let nome : String
    let capa : String
    let ano: String
    let genero: String
    let pais : String
    let imdb : Double
}

var arrayConteudos: [Conteudo] = [
    Conteudo(
        categoria: "Série",
        nome: "Breaking Bad",
        capa: "https://m.media-amazon.com/images/M/MV5BMzU5ZGYzNmQtMTdhYy00OGRiLTg0NmQtYjVjNzliZTg1ZGE4XkEyXkFqcGc@._V1_QL75_UX190_CR0,2,190,281_.jpg",
        ano: "2008",
        genero: "Drama",
        pais: "EUA",
        imdb: 9.5
    ),
    Conteudo(
        categoria: "Série",
        nome: "Stranger Things",
        capa: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtW_fEtl3nUNKYfCyQxAA0Z9DhdSvjQzj9gg&s.jpg",
        ano: "2016",
        genero: "Ficção Científica",
        pais: "EUA",
        imdb: 8.7
    ),
    Conteudo(
        categoria: "Série",
        nome: "Succession",
        capa: "https://m.media-amazon.com/images/M/MV5BZjZhZDc4N2QtZTEzYS00ZmY5LWE2ODctYTA0MWRjMDBmZTFiXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg",
        ano: "2018",
        genero: "Drama",
        pais: "EUA",
        imdb: 8.8
    ),
    Conteudo(
        categoria: "Série",
        nome: "Dark",
        capa: "https://m.media-amazon.com/images/I/A1liQf7C9LL._UF1000,1000_QL80_.jpg",
        ano: "2017",
        genero: "Mistério",
        pais: "Alemanha",
        imdb: 8.7
    ),
    Conteudo(
        categoria: "Série",
        nome: "The Crown",
        capa: "https://upload.wikimedia.org/wikipedia/pt/thumb/e/e2/The-Crown-Poster-S2.jpg/250px-The-Crown-Poster-S2.jpg.jpg",
        ano: "2016",
        genero: "Biografia",
        pais: "Reino Unido",
        imdb: 8.6
    ),
    Conteudo(
        categoria: "Filme",
        nome: "O Lado Bom da Vida",
        capa: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTn6sdVTjsc97K2OaLA6E5Pib47mrMhYENePQ&s.jpg",
        ano: "2012",
        genero: "Romance",
        pais: "EUA",
        imdb: 7.7
    ),
    Conteudo(
        categoria: "Filme",
        nome: "Interestelar",
        capa: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlVAvOBnL9yHn6f-PlI2-w7eibdrORtRsCFQ&s.jpg",
        ano: "2014",
        genero: "Ficção Científica",
        pais: "EUA",
        imdb: 8.7
    ),
    Conteudo(
        categoria: "Filme",
        nome: "Parasita",
        capa: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZrXu26D9I61d5cdzolbda9JvpB-zpcNmVzQ&s.jpg",
        ano: "2019",
        genero: "Thriller",
        pais: "Coreia do Sul",
        imdb: 8.5
    ),
    Conteudo(
        categoria: "Filme",
        nome: "O Labirinto do Fauno",
        capa: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXNM1Q1nTQOMhe_MgxyBpK8JPaBpTiPyr28Q&s.jpg",
        ano: "2006",
        genero: "Fantasia",
        pais: "México",
        imdb: 8.2
    ),
    Conteudo(
        categoria: "Filme",
        nome: "Cidade de Deus",
        capa: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmeeUoDnlw-qH03dFIbSAA3QwzrLzTXFLgvw&s.jpg",
        ano: "2002",
        genero: "Crime",
        pais: "Brasil",
        imdb: 8.6
    )
]

struct ContentView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [.green, .gray],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    ).ignoresSafeArea()
                ScrollView{
                    VStack{
                        Text("FILMES")
                            .foregroundColor(.black)
                            .font(.title)
                        ForEach(arrayConteudos, id: \.self){e in
                            if e.categoria == "Filme"{
                                NavigationLink(destination: FotoFilme(content : e)){
                                    HStack{
                                        AsyncImage(url: URL(string: e.capa)){
                                            image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 60, height: 60)
                                        }placeholder: {
                                            ProgressView()
                                                .frame(width: 30, height: 30)
                                        }
                                        HStack{
                                            Text("\(e.nome) ")
                                                .padding()
                                                .frame(minWidth: 100, minHeight: 40)
                                                .background(.white)
                                                .foregroundStyle(.black)
                                            Text(e.pais)
                                                .foregroundColor(.black)
                                        }
                                    }
                                }
                            }
                        }
                    }.padding()
                    VStack{
                        Text("SÉRIES").foregroundColor(.black).font(.title)
                        ForEach(arrayConteudos, id: \.self){e in
                            if e.categoria == "Série"{
                                NavigationLink(destination: FotoFilme(content : e)){
                                    HStack{
                                        AsyncImage(url: URL(string: e.capa)){
                                            image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 60, height: 60)
                                        }placeholder: {
                                            ProgressView()
                                                .frame(width: 30, height: 30)
                                        }
                                        
                                        Text(e.nome)
                                            .padding()
                                            .frame(minWidth: 100, minHeight: 40)
                                            .background(.white)
                                            .foregroundStyle(.black)
                                        Text(e.pais)
                                            .foregroundColor(.black)
                                    }
                                }
                                
                            }
                        }
                    }.padding()
                    VStack{
                        Text("Recomendados").foregroundColor(.black).font(.title)
                        ScrollView(.horizontal){
                            HStack(spacing: 15){
                                ForEach(arrayConteudos, id: \.self){e in
                                    
                                    NavigationLink(destination: FotoFilme(content : e)){
                                        VStack(){
                                            AsyncImage(url: URL(string: e.capa)){
                                                image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 200, height: 200)
                                            }placeholder: {
                                                ProgressView()
                                                    .frame(width: 30, height: 30)
                                            }
                                        }
                                    }
                                    
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


struct FotoFilme: View{
    var content: Conteudo
    var body: some View{
        ZStack{
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [.green, .gray],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                ).ignoresSafeArea()
            ScrollView{
                VStack{
                    AsyncImage(url: URL(string: content.capa))
                        .padding()
                    Text(content.nome).font(.title3)
                        .padding()
                    HStack{
                        Text("Categoria: ")
                        Text(content.categoria)
                    }
                    HStack{
                        Text("Ano: ")
                        Text(content.ano)
                    }
                    HStack{
                        Text("Gênero: ")
                        Text(content.genero)
                    }
                    HStack{
                        Text("País: ")
                        Text(content.pais)
                    }
                    .padding()
                    HStack{
                        Text("IMDB: \(content.imdb)")
                            .font(.title)
                            .foregroundColor(.yellow)
                            .background(.black)
                            .cornerRadius(20)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
