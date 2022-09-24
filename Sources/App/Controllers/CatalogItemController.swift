import Fluent
import Vapor


struct CatalogItemController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let items = routes.grouped("api", "catalog")
        items.get(use: getAllhandler)
        items.post(use: createHadler)
        items.group(":id") { items in
            items.get(use: getHandler)
            items.put(use: updateHadler)
            items.delete(use: deleteHandler)
        }
    }
    
    
    func getAllhandler(_ req: Request) async throws -> [CatalogItem] {
        try await CatalogItem.query(on: req.db).all()
    }
    
    func getHandler(_ req: Request) async throws -> CatalogItem {
        guard let item = try await CatalogItem.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        return item
    }
    
    func createHadler(_ req: Request) async throws -> CatalogItem {
        let item = try req.content.decode(CatalogItem.self)
        try await item.save(on: req.db)
        return item
    }
    
    func updateHadler(_ req: Request) async throws -> CatalogItem {
        let pushItem = try req.content.decode(CatalogItem.self)
        guard let findIitem = try await CatalogItem.find(req.parameters.get("id"), on: req.db)
        else { throw Abort(.notFound) }
        findIitem.price = pushItem.price
        findIitem.weight = pushItem.weight
        findIitem.image = pushItem.image
        findIitem.description = pushItem.description
        findIitem.title = pushItem.title
        findIitem.sales = pushItem.sales
        try await findIitem.save(on: req.db)
        return pushItem
    }
    func deleteHandler(_ req: Request) async throws -> HTTPStatus {
        guard let item = try await CatalogItem.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await item.delete(on: req.db)
        return .noContent
    }
}
