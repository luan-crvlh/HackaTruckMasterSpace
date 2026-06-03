//
//  ViewModel.swift
//  Aula 08
//
//  Created by Turma02-23 on 03/06/26.
//

import Foundation
import Combine

class ViewModel: ObservableObject{
    @Published var personagens: [HaPo] = []
    
    private let service = Service()
    private var cancellables = Set<AnyCancellable>()
    
    
    func fetch(){
        guard let url = URL(string: "https://hp-api.onrender.com/api/characters/house/ravenclaw") else {
            return
        }
        service.fetchHaPo(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in}) {
                personagens in
                self.personagens = personagens
            }
            .store(in: &cancellables)
    }
}
