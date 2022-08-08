import Foundation
import UIKit

class Webservice {
    
    func showAlert (message: String) {
        
        let alert = UIAlertController(title: "Não encontrado", message: message, preferredStyle: .alert)
        
        alert.addAction(.init(title: "OK", style: .default, handler: nil))

    }
    
    func getData (url: URL, completion: @escaping ([Character]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                self.showAlert(message: "Personagem não encontrado")
                fatalError(error.localizedDescription)
            } else if let data = data {
                
                let characterResponse = try? JSONDecoder().decode(Result.self, from: data)
                
                if let characterResponse = characterResponse {
                    completion(characterResponse.results)
                }
            }
        }.resume()
    }
}
