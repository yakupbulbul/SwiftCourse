//
//  DetailsVC.swift
//  ArtBook
//
//  Created by yakup bülbül on 9.08.2022.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var chosenPainting = ""
    var chosenUUID : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if chosenPainting != ""{
            //Core Data
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchReguest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            
            let idString = chosenUUID?.uuidString
            
            fetchReguest.predicate = NSPredicate(format: "id = %@", idString!)
            
            fetchReguest.returnsObjectsAsFaults = false
            
            do{
                let result = try context.fetch(fetchReguest)
                if result.count > 0{
                    for result in result as! [NSManagedObject] {
                        if let name = result.value(forKey: "name") as? String{
                            nameText.text = name
                        }
                        if let artist = result.value(forKey: "artist") as? String{
                            artistText.text = artist
                        }
                        if let year = result.value(forKey: "year") as? Int{
                            yearText.text = String(year)
                        }
                        if let imageData = result.value(forKey: "image") as? Data {
                            let image = UIImage(data: imageData)
                            imageView.image = image
                        }
                    }
                }
            }catch{
                
            }
            
        }else{
            
        }
        
        
        let gestureRecognizer = UITapGestureRecognizer( target: self, action:   #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        
        
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)

        // Do any additional setup after loading the view.
    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveButton(_ sender: Any) {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        newPainting.setValue(nameText.text!, forKey: "name")
        newPainting.setValue(artistText.text!, forKey: "artist")
        newPainting.setValue(UUID(), forKey: "id")


        if let year = Int(yearText.text!){
            newPainting.setValue(year, forKey: "year")
        }
        
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        
        do{
            try context.save()
            print("Sucess")
        }catch {
            print("Error")
        }
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
        

    }
    

}
