//
//  ContentView.swift
//  Aula 08
//
//  Created by Turma02-23 on 03/06/26.
//

import SwiftUI

struct HaPo: Codable, Identifiable{
    let id: String
    let name: String?
    let alternate_names: [String?]
    let species: String?
    let gender: String?
    let house: String?
    let dateOfBirth: String?
    let yearOfBirth: String?
    let wizard: Bool?
    let ancestry: String?
    let eyeColour: String?
    let hairColour: String?
    let wand: Wand
    let patronus: String?
    let hogwartsStudent: Bool?
    let hogwartsStaff: Bool?
    let actor: String?
    let alternate_actors: String?
    let alive: Bool?
    let image: String?
}
struct Wand: Codable{
    let wood: String?
    let core: String?
    let length: Double?
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                Color(.fundo).background().ignoresSafeArea()
                AsyncImage(url: URL(string: "https://wallpapers.com/images/featured/ravenclaw-0biazn74ja08p3un.jpg"), scale: 4)
                    .scaledToFill()
                
                ScrollView{
                    VStack{
                        ForEach(viewModel.personagens){ model in
                            HStack{
                                if let imageUrlString = model.image, let url = URL(string: imageUrlString) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                } else {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.gray)
                                }
                                Text("\(model.name)")
                            }
                            .padding()
                        }
                    }
                }
                .onAppear(){
                    viewModel.fetch()
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
