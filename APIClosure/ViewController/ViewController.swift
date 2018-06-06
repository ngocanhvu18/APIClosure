//
//  ViewController.swift
//  APIClosure
//
//  Created by Ngọc Anh on 6/5/18.
//  Copyright © 2018 Ngọc Anh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var champs: [Champ] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.shared.loadChamps {[unowned self] champs  in
            self.champs = champs
            self.tableView.reloadData()
        }
      
    }
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return champs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.nameVnText.text =  champs[indexPath.row].nameVN_Champ
        cell.nameEnText.text = champs[indexPath.row].nameEN_Champ
        cell.leveText.text = champs[indexPath.row].level_Champ
        cell.imagePhotoView.download(urlString: champs[indexPath.row].url_Champ)
        return cell
    }
}
extension UIImageView {
    func download( urlString: String){
        if let url = URL(string: urlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}

