import Foundation

struct CharacterListViewModel {
    let characters: [Character]
    
}

extension CharacterListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSections(_ section: Int) -> Int {
        
        return self.characters.count
    }
    
    func characterAtIndex (_ index: Int) -> CharacterViewModel {
        
        let character = self.characters[index]
        return CharacterViewModel(character)
    }
    
}

struct CharacterViewModel {
    
    private let character: Character
}

extension CharacterViewModel {
    init (_ character: Character) {
        self.character = character
    }
}

extension CharacterViewModel {
 
    
    var name: String {
        return self.character.name
    }
    
    var status: String {
        return self.character.status
    }
    
    var species: String {
        return self.character.species
    }
    
    var gender: String {
        return self.character.gender
    }
    
    var image: String {
        return self.character.image
    }
}
