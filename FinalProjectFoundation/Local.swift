//
//  Local.swift
//  FinalProjectFoundation
//
//  Created by Found on 02/06/26.
//

import Foundation
import GRDB

struct Contato: FetchableRecord, TableRecord, Decodable {
    let id_contato: Int64?
    let email: String?
    let telefone: String?
    let website: String?
    
    static let databaseTableName = "Contato"
}

struct HorarioFuncionamento: FetchableRecord, TableRecord, Decodable {
    let id_horario: Int64?
    let idLocal: Int64
    let dia_semana: String
    let status_dia: String?
    let hora_abertura: String?
    let hora_fechamento: String?
    
    static let databaseTableName = "Horario_Funcionamento"
}

struct Avaliacao: FetchableRecord, TableRecord, Decodable {
    let id_avaliacao: Int64?
    let idLocal: Int64
    let nota_estrelas: Double
    let comentario: String?
    
    static let databaseTableName = "Avaliacao"
}

struct Favorito: FetchableRecord, TableRecord, Decodable {
    let id_favorito: Int64?
    let idLocal: Int64
    let data_adicionar: String?
    
    static let databaseTableName = "Favorito"
}

struct Local: Identifiable, FetchableRecord, TableRecord, Decodable {
    let id: Int64?
    let nome: String
    let logradouro: String
    let numero: String
    let bairro: String
    let latitude: Double?
    let longitude: Double?
    let distancia_simulada: Double
    let aberto_agora: Bool
    
    var contato: Contato?
    var horarios: [HorarioFuncionamento] = []
    var avaliacoes: [Avaliacao] = []
    var distanciaCalculada: Double {
        return distancia_simulada
    }
    
    var mediaAvaliacao: Double {
        if avaliacoes.isEmpty { return 4.5 }
        return avaliacoes.reduce(0.0) { $0 + $1.nota_estrelas } / Double(avaliacoes.count)
    }

    static let databaseTableName = "Local"

    enum CodingKeys: String, CodingKey {
        case id = "id_local", nome, logradouro, numero, bairro, latitude, longitude, distancia_simulada, aberto_agora
    }
}
