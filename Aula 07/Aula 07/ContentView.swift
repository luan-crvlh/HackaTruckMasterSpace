//
//  ContentView.swift
//  Aula 07
//
//  Created by Turma02-23 on 02/06/26.
//
import MapKit
import SwiftUI

struct location: Hashable{
    let nome: String
    let foto: String
    let descricao: String
    let latitude: Double
    let longitude: Double
}

var arrayLocations: [location] = [
    location(
        nome: "Recife",
        foto: "https://www.viagensecaminhos.com/wp-content/uploads/2014/05/recife-pe.jpg",
        descricao: "Capital de Pernambuco",
        latitude: -8.05428,
        longitude: -34.88130
    ),
    location(
        nome: "Rio Branco",
        foto: "https://blog.123milhas.com/wp-content/uploads/2022/02/BANNER-TEM-QUE-IR-RIO-BRANCO-123MILHAS.jpg",
        descricao: "Capital do Acre",
        latitude: -9.97472,
        longitude: -67.8100
    )
]

struct ContentView: View {
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -10.830, longitude: -42.730),
            span:
                MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    @State private var cidadeSelecionada: location = arrayLocations[0]
    @State private var localSelecionadoParaSheet: location? = nil
    var body: some View {
        ZStack{
            Map(position: $position){
                ForEach(arrayLocations, id: \.self){
                    local in
                    Annotation("\(local.nome)", coordinate: CLLocationCoordinate2D(latitude: local.latitude, longitude: local.longitude), anchor:.bottom){
                        AsyncImage(url: URL(string: local.foto))
                            .frame(width: 30, height: 30)
                            
                    }
                }
            }
        }.ignoresSafeArea()
        
        
    }
}


#Preview {
    ContentView()
}
