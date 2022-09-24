//
//  File.swift
//  
//
//  Created by Supodoco on 22.09.2022.
//

import Fluent
import Vapor

struct CreateCatalogItems: AsyncMigration {
    func revert(on database: Database) async throws {
        try await database.schema("items").delete()
    }
    
    func prepare(on database: Database) async throws {
       try await database.schema("items")
            .id()
            .field("title", .string, .required)
            .field("weight", .int, .required)
            .field("price", .int, .required)
            .field("image", .string, .required)
            .field("description", .string, .required)
            .field("sales", .bool, .required)
            .create()
    }
}
