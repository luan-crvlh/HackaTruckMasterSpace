//
//  ContentView.swift
//  Aula 15
//
//  Created by Turma02-23 on 10/06/26.
//
import CoreML
import Vision
import SwiftUI

struct ContentView: View {
    @State private var classificationLabel = "Nenhuma imagem analisada ainda"
    @State private var selectedImage: UIImage? = UIImage(named: "b80119127cd173b5460cd8268d1fb0fe")
    func classifyImage(){
        guard let uiImage = selectedImage,
              let ciImage = CIImage(image: uiImage) else {
            classificationLabel = "Erro ao converter imagem"
            return
        }
        do{
            let model = try VNCoreMLModel(
                for: MobileNetV2(configuration: MLModelConfiguration()).model
            )
            
            let request = VNCoreMLRequest(model: model){ request, error in
                if let results = request.results as? [VNClassificationObservation],
                   let topResult = results.first {
                    DispatchQueue.main.async{
                        classificationLabel = "Identificado: \(topResult.identifier) ( \(String(format: "%.2f", topResult.confidence * 100)) %)"
                    }
                }
                else{
                    classificationLabel = "Nenhum resultado encontrado"
                }
            }
            let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
            DispatchQueue.global().async{
                do{
                    try handler.perform([request])
                } catch{
                    classificationLabel = "Erro na classificação: \(error.localizedDescription)"
                }
            }
        }
        catch {
            classificationLabel = "Falha ao carregar modelo ML"
        }
    }
    
    var body: some View {
        VStack {
            Text("Classificador de Imagens").font(.title).padding()
            Spacer()
            if let image = selectedImage{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            List{
                Text("Resultado da análise: ").font(.title)
                Text("Identificado \(classificationLabel)").font(.title2)
            }
            
            Button(action: {classifyImage()}) {
                Text("Analisar agora")
            }.font(.title)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
