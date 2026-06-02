//
//  Local.swift
//  FinalProjectFoundation
//
//  Created by Found on 02/06/26.
//

import Foundation
import GRDB

struct Local: Identifiable, FetchableRecord, TableRecord, Decodable {
    let id: Int64
    let nome: String
    let tipo: String
    let endereco: String
    let avaliacao: Double
    let abertoAgora: Bool
    let telefone: String
    let distancia: String

    static let databaseTableName = "locais"

    enum CodingKeys: String, CodingKey {
        case id, nome, tipo, endereco, avaliacao, telefone, distancia
        case abertoAgora = "aberto_agora"
    }
}


