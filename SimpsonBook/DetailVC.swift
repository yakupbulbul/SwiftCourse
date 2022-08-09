//
//  DetailVC.swift
//  SimpsonBook
//
//  Created by yakup bülbül on 9.08.2022.
//

import UIKit

class DetailVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var selectedAngelo : Angelo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = selectedAngelo?.name
        jobLabel.text = selectedAngelo?.job
        imageView.image = selectedAngelo?.image
        

        // Do any additional setup after loading the view.
    }
    

}
