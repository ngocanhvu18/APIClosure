//
//  ViewController.swift
//  APIClosure
//
//  Created by Ngọc Anh on 6/5/18.
//  Copyright © 2018 Ngọc Anh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var champs: [Champ] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.shared.loadChamps {[unowned self] champs  in
            self.champs = champs
            self.champs.forEach { print($0.nameVN_Champ) }
        }
        
    }

        // Do any additional setup after loading the view, typically from a nib.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

