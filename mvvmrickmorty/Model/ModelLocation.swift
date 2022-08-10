import Foundation

struct ResultLocation: Codable {
    
let results: [Location]
    
}

struct Location: Codable {
    
    let name: String
    let type: String
    let dimension: String
}
