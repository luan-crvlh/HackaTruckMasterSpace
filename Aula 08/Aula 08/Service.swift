//
//  File.swift
//  Aula 08
//
//  Created by Turma02-23 on 03/06/26.
//

import Foundation
import Combine

struct Service {
    func fetchHaPo(url: URL) -> AnyPublisher<[HaPo], Error>{
        return URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: [HaPo].self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
}
