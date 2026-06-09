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
    

    static let databaseTableName = "Local"

    enum CodingKeys: String, CodingKey {
        case id, nome, logradouro, numero, bairro, latitude, longitude
        case distanciaSimulada
        case abertoAgora
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int64.self, forKey: .id)
        self.nome = try container.decode(String.self, forKey: .nome)
        self.logradouro = try container.decode(String.self, forKey: .logradouro)
        self.numero = try container.decode(String.self, forKey: .numero)
        self.bairro = try container.decode(String.self, forKey: .bairro)
        self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        self.distanciaSimulada = try container.decode(Double.self, forKey: .distanciaSimulada)
        
        if let abertoInt = try? container.decode(Int.self, forKey: .abertoAgora) {
            self.abertoAgora = (abertoInt == 1)
        } else {
            self.abertoAgora = try container.decode(Bool.self, forKey: .abertoAgora)
        }
    }
}
