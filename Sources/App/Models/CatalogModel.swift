//
//  File.swift
//  
//
//  Created by Supodoco on 22.09.2022.
//

import Fluent
import Vapor

final class CatalogItem: Model, Content {
    
    static let schema = "items"
    
    @ID var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "weight")
    var weight: Int
    
    @Field(key: "price")
    var price: Int
    
    @Field(key: "image")
    var image: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "sales")
    var sales: Bool
    
    init() { }
    
    init(id: UUID? = nil, title: String, weight: Int, price: Int, image: String, description: String, sales: Bool) {
        self.id = id
        self.title = title
        self.weight = weight
        self.price = price
        self.image = image
        self.description = description
        self.sales = sales
        
    }
    
}
