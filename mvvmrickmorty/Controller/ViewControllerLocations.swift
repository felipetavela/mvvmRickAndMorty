
import Foundation
import UIKit

class ViewControllerLocations: UIViewController {
    
    private var locationVC: LocationListViewModel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setup()
        tableView.dataSource = self
        searchBar.delegate = self
        
        self.hideKeyboardWhenTappedAround() 
    }
    
    func setup () {
        
        let url = URL(string: "https://rickandmortyapi.com/api/location")!
    
        Webservice().getDataLocation(url: url) { locations in
            
            if let locations = locations {
    
            self.locationVC = LocationListViewModel (locations: locations)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewControllerLocations: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
    
        return self.locationVC == nil ? 0 : self.locationVC.numberOfSections
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.locationVC.numberOfRowsInSections(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "locationcell", for: indexPath) as? LocationTableViewCell else {
            fatalError("Cell not found")
        }
        
        let locationVC = self.locationVC.locationAtIndex(indexPath.row)
        
        cell.nameLabel.text = locationVC.name
        cell.typeLabel.text = locationVC.type
        cell.dimensionLabel.text = locationVC.dimension
        
        return cell
    }
}

extension ViewControllerLocations: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let location = searchBar.text else {return}
        
        let url = URL(string: "https://rickandmortyapi.com/api/location/?name=\(location)")!
        
        Webservice().getDataLocation(url: url) { locations in
            
            if let locations = locations {
            
                self.locationVC = LocationListViewModel(locations: locations)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
            
        }
    }
}
    }
}
