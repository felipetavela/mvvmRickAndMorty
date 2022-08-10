import Foundation

struct Result: Decodable {

    let results: [Character]
}

struct Character: Decodable {
    
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    
}


