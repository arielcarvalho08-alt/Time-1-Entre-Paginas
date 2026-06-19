//
//  DatabaseManager.swift
//  FinalProjectFoundation
//
//  Created by Found on 11/06/26.
//

import Foundation
import GRDB

class DatabaseManager {
    static let shared = DatabaseManager()
    var dbQueue: DatabaseQueue?
    
    private init() {
        configurarBanco()
    }
    
    private func configurarBanco() {
        do {
            guard let path = Bundle.main.path(forResource: "db", ofType: "sqlite") else {
                print("❌ ERRO CRÍTICO: O arquivo db.sqlite não foi encontrado no Bundle do Xcode!")
                return
            }
            
            self.dbQueue = try DatabaseQueue(path: path)
            print(" caneta_azul Conexão com o banco estabelecida com sucesso no caminho: \(path)")
        } catch {
            print("❌ Erro ao conectar ao banco de dados GRDB: \(error)")
        }
    }
    
    func fetchLocais() -> [Local] {
        guard let dbQueue = dbQueue else {
            print("❌ ERRO: dbQueue está nulo ao tentar buscar dados!")
            return []
        }
        
        do {
            return try dbQueue.read { db in
                var listaDeLocais = try Local.fetchAll(db)
                
                for i in 0..<listaDeLocais.count {
                    if let id = listaDeLocais[i].id {
                        listaDeLocais[i].contato = try Contato.fetchOne(db, sql: "SELECT * FROM Contato WHERE id_contato = (SELECT idContato FROM Local WHERE id_local = ?)", arguments: [id])
                        listaDeLocais[i].horarios = try HorarioFuncionamento.fetchAll(db, sql: "SELECT * FROM Horario_Funcionamento WHERE idLocal = ?", arguments: [id])
                        listaDeLocais[i].avaliacoes = try Avaliacao.fetchAll(db, sql: "SELECT * FROM Avaliacao WHERE idLocal = ?", arguments: [id])
                    }
                }
                return listaDeLocais
            }
        } catch {
            print("❌ Erro na query de busca de locais: \(error)")
            return []
        }
    }
    
    func favoritarLocal(idLocal: Int64) {
        guard let dbQueue = dbQueue else { return }
        let dataAtual = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        
        try? dbQueue.write { db in
            let existe = try Int.fetchOne(db, sql: "SELECT COUNT(*) FROM Favorito WHERE idLocal = ?", arguments: [idLocal]) ?? 0
            if existe == 0 {
                try db.execute(sql: "INSERT INTO Favorito (idLocal, data_adicionar) VALUES (?, ?)", arguments: [idLocal, dataAtual])
            }
            else {
                try db.execute(sql: "DELETE FROM Favorito WHERE idLocal = ?", arguments: [idLocal])
            }
        }
    }
    
    func verificarSeEFavorito(idLocal: Int64) -> Bool {
        guard let dbQueue = dbQueue else { return false }
        let quantidade = try? dbQueue.read { db in
            try Int.fetchOne(db, sql: "SELECT COUNT(*) FROM Favorito WHERE idLocal = ?", arguments: [idLocal])
        }
        return (quantidade ?? 0) > 0
    }
}
