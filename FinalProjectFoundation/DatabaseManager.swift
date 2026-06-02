//
//  DatabaseManager.swift
//  FinalProjectFoundation
//
//  Created by Found on 02/06/26.
//

import Foundation
import GRDB

class DatabaseManager {
    static let shared = DatabaseManager()
    var dbQueue: DatabaseQueue?
    
    init() {
            connectToDatabase()
        }
    
    private func connectToDatabase() {
        guard let path = Bundle.main.path(forResource: "db", ofType: "sqlite") else {
        print("Database not found")
            return
        }
        do {
            dbQueue = try DatabaseQueue(path: path)
            print("Database connected")
        } catch {
            print("Database connection error: \(error)")
        }
        }
    func fetchLocais() -> [Local] {
        guard let dbQueue = dbQueue else {return []}
        return (try? dbQueue.read { db in try Local.fetchAll(db)}) ?? []
        }
    }
        
    

