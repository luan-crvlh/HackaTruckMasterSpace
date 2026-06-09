//
//  ContentView.swift
//  Aula 14
//
//  Created by Turma02-23 on 09/06/26.
//

import SwiftUI
import GoogleGenerativeAI

import Foundation


struct Pergunta: Codable, Hashable {
    let enunciado: String
    let alternativas: [String]
    let respostaCorreta: String
    let explicacao: String
}


struct QuizContainer: Codable {
    let perguntas: [Pergunta]
}

struct ContentView: View {
    
    let model = GenerativeModel(
        name: "gemini-2.5-flash",
        apiKey: APIKey.default,
        generationConfig: GenerationConfig(responseMIMEType: "application/json")
    )
    
    @State private var temaInput = ""
    @State private var quantidadePerguntas = 3
    @State private var isLoading = false
    
    @State private var quizGerado: [Pergunta]? = nil
    @State private var errorMessage = ""
    
    func sendMessage() {
        errorMessage = ""
        isLoading = true
        
        
        let prompt = """
        Crie um quiz com \(quantidadePerguntas) perguntas sobre o tema: "\(temaInput)".
        Você deve responder estritamente no formato JSON abaixo, sem textos adicionais antes ou depois:
        {
          "perguntas": [
            {
              "enunciado": "Texto da pergunta aqui?",
              "alternativas": ["Opção A", "Opção B", "Opção C", "Opção D"],
              "respostaCorreta": "Texto exato da alternativa correta",
              "explicacao": "Uma breve explicação do porquê esta resposta está correta."
            }
          ]
        }
        """
        
        Task {
            do {
                let response = try await model.generateContent(prompt)
                
                guard let jsonText = response.text, let data = jsonText.data(using: .utf8) else {
                    errorMessage = "Erro ao processar os dados da IA."
                    isLoading = false
                    return
                }
                
                
                let quizContainer = try JSONDecoder().decode(QuizContainer.self, from: data)
                
                await MainActor.run {
                    self.quizGerado = quizContainer.perguntas
                    self.isLoading = false
                    self.temaInput = ""
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Falha ao gerar o Quiz. Tente usar outros termos."
                    print(error)
                    isLoading = false
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                
                VStack(spacing: 8) {
                    Image(systemName: "brain.head.profile")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    
                    Text("AI Quiz Gen")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("Escolha um tema com quantas palavras quiser!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)
                
                Spacer()
                
                
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Qual será o tema?")
                            .font(.headline)
                        
                        TextField("Ex: Segunda Guerra Mundial, Programação em Swift...", text: $temaInput)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Quantidade de perguntas")
                            .font(.headline)
                        
                        Picker("Perguntas", selection: $quantidadePerguntas) {
                            Text("3 Perguntas").tag(3)
                            Text("5 Perguntas").tag(5)
                        }
                        .pickerStyle(.segmented)
                    }
                }
                .padding(.horizontal)
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                Spacer()
                
                
                if isLoading {
                    VStack(spacing: 12) {
                        ProgressView()
                        Text("A IA está formulando suas questões...")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                } else {
                    Button(action: sendMessage) {
                        Text("Iniciar Desafio")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(temaInput.isEmpty ? Color.gray : Color.blue)
                            .cornerRadius(12)
                    }
                    .disabled(temaInput.isEmpty)
                    .padding(.horizontal)
                }
            }
            .padding()
            .navigationDestination(item: $quizGerado) { perguntas in
                QuizPlayView(perguntas: perguntas)
            }
        }
    }
}
struct QuizPlayView: View {
    let perguntas: [Pergunta]
    
    @State private var indiceAtual = 0
    @State private var alternativaSelecionada: String? = nil
    @State private var respondeu = false
    @State private var mostrarPontuacaoFinal = false
    @State private var acertos = 0
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            if mostrarPontuacaoFinal {
                
                VStack(spacing: 20) {
                    Image(systemName: "trophy.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.yellow)
                    
                    Text("Quiz Concluído!")
                        .font(.title)
                        .bold()
                    
                    Text("Você acertou \(acertos) de \(perguntas.count) perguntas.")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Button("Voltar ao Início") {
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 20)
                }
                .padding()
            } else {
                
                let perguntaAtual = perguntas[indiceAtual]
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    HStack {
                        Text("Pergunta \(indiceAtual + 1) de \(perguntas.count)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        ProgressView(value: Double(indiceAtual + 1), total: Double(perguntas.count))
                            .frame(width: 120)
                    }
                    
                    
                    Text(perguntaAtual.enunciado)
                        .font(.title3)
                        .bold()
                        .padding(.vertical, 10)
                    
                    
                    VStack(spacing: 12) {
                        ForEach(perguntaAtual.alternativas, id: \.self) { alternativa in
                            Button(action: {
                                if !respondeu {
                                    alternativaSelecionada = alternativa
                                }
                            }) {
                                HStack {
                                    Text(alternativa)
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    
                                    
                                    if respondeu {
                                        if alternativa == perguntaAtual.respostaCorreta {
                                            Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                                        } else if alternativa == alternativaSelecionada {
                                            Image(systemName: "xmark.circle.fill").foregroundColor(.red)
                                        }
                                    } else if alternativaSelecionada == alternativa {
                                        Image(systemName: "checkmark.circle").foregroundColor(.blue)
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(corDoCard(para: alternativa, correta: perguntaAtual.respostaCorreta))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(alternativaSelecionada == alternativa ? Color.blue : Color.clear, lineWidth: 2)
                                )
                            }
                            .disabled(respondeu)
                        }
                    }
                    
                    
                    if respondeu {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Explicação:")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                
                                Text(perguntaAtual.explicacao)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        .transition(.opacity)
                    }
                    
                    Spacer()
                    
                    
                    if !respondeu {
                        Button(action: {
                            validarResposta(correta: perguntaAtual.respostaCorreta)
                        }) {
                            Text("Confirmar Resposta")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(alternativaSelecionada == nil ? Color.gray : Color.blue)
                                .cornerRadius(12)
                        }
                        .disabled(alternativaSelecionada == nil)
                    } else {
                        Button(action: proximaPergunta) {
                            Text(indiceAtual + 1 == perguntas.count ? "Ver Resultados" : "Próxima Pergunta")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(12)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    func corDoCard(para alternativa: String, correta: String) -> Color {
        guard respondeu else {
            return alternativaSelecionada == alternativa ? Color.blue.opacity(0.1) : Color(.systemGray6)
        }
        
        if alternativa == correta {
            return Color.green.opacity(0.2)
        }
        if alternativa == alternativaSelecionada {
            return Color.red.opacity(0.2)
        }
        return Color(.systemGray6)
    }
    
    func validarResposta(correta: String) {
        withAnimation {
            respondeu = true
            if alternativaSelecionada == correta {
                acertos += 1
            }
        }
    }
    
    func proximaPergunta() {
        withAnimation {
            if indiceAtual + 1 < perguntas.count {
                indiceAtual += 1
                alternativaSelecionada = nil
                respondeu = false
            } else {
                mostrarPontuacaoFinal = true
            }
        }
    }
}

#Preview {
    ContentView()
}
