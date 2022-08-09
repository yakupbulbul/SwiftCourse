//
//  ViewController.swift
//  SimpsonBook
//
//  Created by yakup bülbül on 9.08.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var myAngelos = [Angelo]()
    var chosenAngelo : Angelo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        
        // Angelo Objecct
        let angelo = Angelo(angeloName: "Angelo", angeloJob: "Main", angeloImage: UIImage(named: "angelo")!)
        let lola = Angelo(angeloName: "Lola", angeloJob: "Friend of Angelo", angeloImage: UIImage(named: "lola")!)
        let sherwood = Angelo(angeloName: "Sherwood", angeloJob: "Friend of Angelo", angeloImage: UIImage(named: "sherwood")!)
        let larisa = Angelo(angeloName: "Larisa", angeloJob: "Mam of Angelo", angeloImage: UIImage(named: "larisa_mom")!)
        let dave = Angelo(angeloName: "Dave", angeloJob: "Dad of Angelo", angeloImage: UIImage(named: "dave")!)
        let elena = Angelo(angeloName: "Elena", angeloJob: "Sister of Angelo", angeloImage: UIImage(named: "elena")!)
        let ethan = Angelo(angeloName: "Ethan", angeloJob: "Video Gamer", angeloImage: UIImage(named: "ethan")!)
        let monica = Angelo(angeloName: "Monika", angeloJob: "Crush of Sherwood", angeloImage: UIImage(named: "monica")!)
        let peter = Angelo(angeloName: "Peter", angeloJob: "Brother of Angelo", angeloImage: UIImage(named: "peter")!)
        let walter = Angelo(angeloName: "Walter", angeloJob: "Dangerous Boy", angeloImage: UIImage(named: "walter")!)
        
        myAngelos.append(angelo)
        myAngelos.append(lola)
        myAngelos.append(sherwood)
        myAngelos.append(larisa)
        myAngelos.append(dave)
        myAngelos.append(elena)
        myAngelos.append(ethan)
        myAngelos.append(monica)
        myAngelos.append(peter)
        myAngelos.append(walter)
        


        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myAngelos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = myAngelos[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenAngelo = myAngelos[indexPath.row]
        self.performSegue(withIdentifier: "toDetailVC", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let destinationVC = segue.destination as! DetailVC
            destinationVC.selectedAngelo = chosenAngelo
        }
          
    }


}

