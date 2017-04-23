//
//  CardViewController.swift
//  RecycleVision
//
//  Created by Mary Huerta on 4/22/17.
//  Copyright © 2017 Mobi. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet var materialIcon: UIImageView!
    @IBOutlet var materialName: UILabel!
    @IBOutlet var Description: UILabel!
    @IBOutlet var location: UILabel!
    
    
    // I'm too lazzzy to make an model
    var material = ("metals", "paper", "cardboard", "glass", "plastics", "bulbs", "batteries",
                    "electronic")
    
    var materialImage = ( #imageLiteral(resourceName: "radio"), #imageLiteral(resourceName: "plasticBottle"), #imageLiteral(resourceName: "cardboard") )
    
    var materialDescription = ("I'll fill this in later...maybe")
    
    var materiallocation = ("FIND IT YOURSELF!")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var name = "metals"
        switch(name){
        case material.0:
            materialIcon.image = materialImage.0
            materialName.text = material.0
        case material.1:
            materialIcon.image = materialImage.1
            materialName.text = material.1
        case material.2:
            materialIcon.image = materialImage.0
            materialName.text = material.2
        case material.3:
            materialIcon.image = materialImage.1
            materialName.text = material.3
        case material.4:
            materialIcon.image = materialImage.0
            materialName.text = material.4
        case material.5:
            materialIcon.image = materialImage.1
            materialName.text = material.5
        default:
            materialIcon.image = materialImage.1
            materialName.text = material.0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
