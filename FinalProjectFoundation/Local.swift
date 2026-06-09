//
//  Local.swift
//  FinalProjectFoundation
//
//  Created by Found on 02/06/26.
//

import Foundation
import GRDB

struct Local: Identifiable, FetchableRecord, TableRecord, Decodable {
    let id: Int64?
    let nome: String
    let logradouro: String
    let numero: String
    let bairro: String
    let latitude: Double?
    let longitude: Double?
    let distanciaSimulada: Double
    let abertoAgora: Bool
    let idTipoFk: Int

    static let databaseTableName = "locais"

    enum CodingKeys: String, CodingKey {
        case id = "id_local"
        case nome, logradouro, numero, bairro, latitude, longitude
        case distanciaSimulada = "distancia_simulada"
        case abertoAgora = "aberto_agora"
        case idTipoFk = "id_tipo_fk"
    }
}


