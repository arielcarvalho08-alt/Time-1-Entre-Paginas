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
    
    
    var distanciaSimulada: Double {
        return Double.random(in: 1...15)
    }
    
    var abertoAgora: Bool {
        return true
    }
    
    static let databaseTableName = "Local"

    enum CodingKeys: String, CodingKey {
        case id, nome, logradouro, numero, bairro, latitude, longitude
    }
}
