//
//  ContentView.swift
//  Aula 16
//
//  Created by Turma02-23 on 11/06/26.
//

import SwiftUI
import AVFoundation
import PhotosUI

let sintetizador = AVSpeechSynthesizer()

//NiceButtonView(title: "Escutar Texto", color: .indigo){
//    let enunciado = AVSpeechUtterance(string: viewModel.detectedText)
//    enunciado.voice = AVSpeechSynthesisVoice(language: "pt-BR")
//    enunciado.rate = 0.3
//    sintetizador.speak(enunciado)
//}

struct ContentView: View {
    @State private var photoPicked: PhotosPickerItem?
    @State private var imageToAnalise: UIImage?
//    private var reserva: UIImage {
//        UIImage(named: "progress") ?? UIImage()
//    }
    var body: some View {
        ZStack{
            Color(.black).ignoresSafeArea()
            VStack{
                Text("Study Test").foregroundColor(.white).font(.title)
                
                if let uImage = imageToAnalise ?? UIImage(named: "progress") {
                    Image(uiImage: uImage)
                        .resizable()
                        .scaledToFit()
                }
                
                PhotosPicker(selection: $photoPicked,
                             matching: .images,
                             photoLibrary: .shared()){
                    Text("Pegar da Galeria")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.indigo))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .padding(.horizontal)
                }
                             .onChange(of: photoPicked){ oldValue, newValue in
                                 if let newPhoto = newValue{
                                     Task{
                                         if let data = try? await newPhoto.loadTransferable(type: Data.self),
                                            let image = UIImage(data: data){
                                             imageToAnalise = image
                                         }
                                     }
                                 }
                             }
                             .padding()
                Button("Escutar Texto") {
                    Task {
                        let textoExtraido = await detectText(photo: imageToAnalise)
                        
                        guard !textoExtraido.isEmpty else {
                            print("Nenhum texto encontrado para falar.")
                            return
                        }
                        
                        let enunciado = AVSpeechUtterance(string: textoExtraido)
                        enunciado.voice = AVSpeechSynthesisVoice(language: "pt-BR")
                        enunciado.rate = 0.4
                        
                        sintetizador.speak(enunciado)
                    }
                }
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.indigo))
                .foregroundColor(.white)
                .cornerRadius(25)
                .padding(.horizontal)
                Button("Analisar Texto"){
                    Task{
                        let textoExtraido = await detectText(photo: imageToAnalise)
                        
                        guard !textoExtraido.isEmpty else {
                            print("Nenhum texto encontrado para falar.")
                            return
                        }
                        ScrollView{
                            Text("\(textoExtraido)")
                        }
                    }
                }
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.indigo))
                .foregroundColor(.white)
                .cornerRadius(25)
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ContentView()
}
