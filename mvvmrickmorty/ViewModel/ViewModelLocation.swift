import Foundation

struct LocationListViewModel {
    
    let locations: [Location]
}

extension LocationListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSections(_ section: Int) -> Int {
        
        return self.locations.count
    }
    
    func locationAtIndex (_ index: Int) -> LocationViewModel {
        
        let location = self.locations[index]
        return LocationViewModel(location)
    }
    
}

struct LocationViewModel {
    
    private let location: Location
}

extension LocationViewModel {
    init (_ location: Location) {
        self.location = location
    }
}

extension LocationViewModel {
 
    var name: String {
        return self.location.name
    }
    
    var type: String {
        return self.location.type
    }
    
    var dimension: String {
        return self.location.dimension
    }

}
