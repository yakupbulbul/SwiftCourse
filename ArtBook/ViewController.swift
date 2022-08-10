//
//  ViewController.swift
//  ArtBook
//
//  Created by yakup bülbül on 9.08.2022.
//

import UIKit
import CoreData
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var nameArray = [String]()
    var idArray = [UUID]()
    var selectedPainting = ""
    var selectedPaintingId : UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        getData()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    @objc func getData() {
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        let appDelegete = UIApplication.shared.delegate as! AppDelegate
        let context  = appDelegete.persistentContainer.viewContext
        
        let fetchReguest = NSFetchRequest <NSFetchRequestResult> (entityName: "Paintings")
        
        fetchReguest.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(fetchReguest)
            if result.count > 0{
                for result in result as! [NSManagedObject] {
                    if let name = result.value(forKey: "name") as? String {
                        self.nameArray.append(name)
                    }
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArray.append(id)
                    }
                    
                    self.tableView.reloadData()
                }
            }
           
            
        }
        catch{
            print("Eror")
        }
    }
    
    @objc func addButtonClicked () {
        selectedPainting = ""
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            let destionationVC = segue.destination as! DetailsVC
            destionationVC.chosenPainting = selectedPainting
            destionationVC.chosenUUID = selectedPaintingId
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPainting = nameArray[indexPath.row]
        selectedPaintingId = idArray[indexPath.row]

        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }

    
    func tableView(_ tableView: UITableView,   commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let appDelegete = UIApplication.shared.delegate as! AppDelegate
            let context  = appDelegete.persistentContainer.viewContext
            
            let fetchReguest = NSFetchRequest <NSFetchRequestResult> (entityName: "Paintings")
            
            let idString = idArray[indexPath.row].uuidString
            
            fetchReguest.predicate = NSPredicate(format: "id = %@", idString)
            
            
            
            fetchReguest.returnsObjectsAsFaults = false
            
            do {
                let result = try context.fetch(fetchReguest)
                if result.count > 0{
                    for result in result as! [NSManagedObject] {
                   
                        if let id = result.value(forKey: "id") as? UUID {
                            if id == idArray[indexPath.row] {
                                context.delete(result)
                                nameArray.remove(at: indexPath.row)
                                idArray.remove(at: indexPath.row)
                                self.tableView.reloadData()
                               
                                
                                do{
                                    try  context.save()
                                }catch{
                                    print("Error")
                                }
                                
                                break
                            }
                        }
                       
                        
                    }
                }
               
                
            }
            catch{
                print("Eror")
            }
        }

    }
    

}

