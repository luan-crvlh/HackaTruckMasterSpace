//
//  ContentView.swift
//  Aula 17
//
//  Created by Turma02-23 on 12/06/26.
//

import SwiftUI
import Translation


struct Item: Hashable{
    let nome: String
    let valor: Double
    let photo: String
    let categoria: String
}

private var arrayItem: [Item] = [
    Item(nome: "Paçoca",
         valor: 0.99,
         photo: "https://s2-receitas.glbimg.com/AhtBIyuVzt5YYHpshXK-9lAKU7U=/0x0:1000x668/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_1f540e0b94d8437dbbc39d567a1dee68/internal_photos/bs/2023/U/w/0LFdpVS76dG4bPB9KsVw/round-pressed-pacoca-rustic-wooden-table-remember-june-party.jpg",
         categoria: "SOBREMESA"),
    Item(nome: "Bolinho de costela",
         valor: 9.90,
         photo: "https://www.guiadasemana.com.br/contentFiles/image/opt_w320h200/2018/06/FEA/38924_bolinho-de-costela-shutterstockk.jpg",
         categoria: "ENTRADA"),
    Item(nome: "Filé Mignon 500g",
         valor: 119.90,
         photo: "https://cdn.shoppub.io/cdn-cgi/image/w=1000,h=1000,q=80,f=auto/beirario/media/uploads/produtos/foto/bb5b2bb6a6757file.png",
         categoria: "PRINCIPAL"),
    Item(nome: "Lagoa Azul",
         valor: 25.90,
         photo: "https://www.acidadeon.com/tudoep/wp-content/uploads/sites/10/2024/02/pexels-nerfee-mirandilla-3186752-1-scaled.jpg",
         categoria: "BEBIDA")
]

struct ComponentView: View{
    @State private var showTranslation: Bool = false
    @State private var textoParaTraduzir: String = ""
    @State var categoria: String
    var body: some View {
        Text(categoria).font(.largeTitle).bold().padding(.horizontal).padding(.top, 10)
        ForEach(arrayItem, id: \.self){ m in
            if m.categoria == categoria{
                HStack{
                    AsyncImage(url: URL(string: m.photo)){
                        p in
                        if let image = p.image {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 120, maxHeight: 120)
                                .cornerRadius(8)
                        }
                        else{
                            ProgressView().frame(width: 120, height: 120)
                        }
                    }
                    VStack{
                        Text(m.nome).bold()
                        Text("R$: \(m.valor, specifier: "%.2f")").bold()
                    }
                    Spacer()
                    
                    Button(action: {
                                                textoParaTraduzir = m.nome // 1. Define o texto deste item
                                                showTranslation = true     // 2. Dispara a Sheet
                                            }) {
                                                Image(systemName: "translate") // Ícone nativo de tradução
                                                    .font(.title3)
                                                    .foregroundColor(.white)
                                                    .padding(10)
                                                    .background(Color.indigo)
                                                    .clipShape(Circle())
                                            }
                }
            }
        }
        .background(Color("azul"))
            .translationPresentation(isPresented: $showTranslation, text: textoParaTraduzir)
    }
}

struct ContentView: View {
    private var categorias = ["ENTRADA", "SOBREMESA", "PRINCIPAL", "BEBIDA"]
    var body: some View {
        ZStack{
            Color(.white).ignoresSafeArea()
            ScrollView{
                Text("HackaTruck GastroBar").font(.title)
                ForEach(categorias, id: \.self){m in
                    ComponentView(categoria: m)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
