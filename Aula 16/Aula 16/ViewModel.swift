import SwiftUI
import Vision
import UIKit

@MainActor
func detectText(photo: UIImage?) async -> String {
    
    guard let cgImage = photo?.cgImage else { return "" }
    
    
    return await withCheckedContinuation { continuation in
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                continuation.resume(returning: "")
                return
            }
            
            var textoExtraido = ""
            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { continue }
                textoExtraido += topCandidate.string + "\n"
            }
            
    
            continuation.resume(returning: textoExtraido)
        }
        
    
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("Erro ao executar o OCR: \(error)")
            continuation.resume(returning: "")
        }
    }
}
