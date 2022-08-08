import UIKit

class ViewController: UIViewController {

    private var characterVC: CharacterListViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setup()
        tableView.dataSource = self
        searchBar.delegate = self

    }

    func setup () {
        
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
    
        Webservice().getData(url: url) { characters in
            
            if let characters = characters {
    
            self.characterVC = CharacterListViewModel(characters: characters)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
        }
        }
    }
    
    func showAlert (message: String) {
        
        let alert = UIAlertController(title: "Não encontrado", message: message, preferredStyle: .alert)
        
        alert.addAction(.init(title: "OK", style: .default, handler: nil))

    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.characterVC == nil ? 0 : self.characterVC.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.characterVC.numberOfRowsInSections(section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CharacterTableViewCell else {
            fatalError("Cell not found")
        }
        
        let characterVC = self.characterVC.characterAtIndex(indexPath.row)
        
        cell.nameLabel.text = characterVC.name
        cell.genderLabel.text = characterVC.gender
        cell.specieLabel.text = characterVC.species
        cell.statusLabel.text = characterVC.status
        cell.myImage.layer.cornerRadius = 36
        cell.myImage.layer.borderColor = CGColor.init(red: 0, green: 1, blue: 0, alpha: 1)
        cell.myImage.layer.borderWidth = 1
        
        let dataImage = URL(string: characterVC.image)!
        let imageData: Data = try! Data(contentsOf: dataImage)
        
        cell.myImage.image = UIImage(data: imageData)
        
        return cell
    }
     
    
}

extension ViewController: UISearchBarDelegate {
   

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        guard let character = searchBar.text else {return showAlert(message: "Digite Algo")}
            
            let url = URL(string: "https://rickandmortyapi.com/api/character/?name=\(character)")!
            Webservice().getData(url: url) { characters in
                
                if let characters = characters {
        
                self.characterVC = CharacterListViewModel(characters: characters)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                
            }
        }
    }
    }
}


