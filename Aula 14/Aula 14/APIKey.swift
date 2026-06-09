//
//  File.swift
//  Aula 14
//
//  Created by Turma02-23 on 09/06/26.
//

import Foundation
enum APIKey{
    static var `default` : String{
        let value = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
        return value
    }
}
