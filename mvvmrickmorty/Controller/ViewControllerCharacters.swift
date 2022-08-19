import UIKit

class ViewControllerCharacters: UIViewController {

    private var characterVC: CharacterListViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
   
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setup()
        tableView.dataSource = self
        searchBar.delegate = self
        
        self.hideKeyboardWhenTappedAround()
    }

    func setup () {
        
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
    
        Webservice().getDataCharacter(url: url) { characters in
            
            if let characters = characters {
    
            self.characterVC = CharacterListViewModel(characters: characters)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewControllerCharacters: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.characterVC == nil ? 0 : self.characterVC.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.characterVC.numberOfRowsInSections(section)
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "charactercell", for: indexPath) as? CharacterTableViewCell else {
            fatalError("Cell not found")
        }
        
        let characterVC = self.characterVC.characterAtIndex(indexPath.row)
        
        switch characterVC.status {
       
        case "Dead": cell.statusLabel.text = "💀"
        case "Alive": cell.statusLabel.text = "🫀"
        case "unknown": cell.statusLabel.text = "🤷🏻"
        default: cell.statusLabel.text = ""
            
        }
        
        cell.nameLabel.text = characterVC.name
        cell.genderLabel.text = characterVC.gender
        cell.specieLabel.text = characterVC.species
        cell.myImage.layer.cornerRadius = 25
        cell.myImage.layer.borderColor = CGColor.init(red: 0, green: 1, blue: 0, alpha: 1)
        cell.myImage.layer.borderWidth = 1
        
        let dataImage = URL(string: characterVC.image)!
        let imageData: Data = try! Data(contentsOf: dataImage)
        
        cell.myImage.image = UIImage(data: imageData)
        
        return cell
    }
}

extension ViewControllerCharacters: UISearchBarDelegate {
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        guard let character = searchBar.text else {return}
            
            let url = URL(string: "https://rickandmortyapi.com/api/character/?name=\(character)")!
            
            Webservice().getDataCharacter(url: url) { characters in
                
                if let characters = characters {
        
                self.characterVC = CharacterListViewModel(characters: characters)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
            }
        }
    }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


