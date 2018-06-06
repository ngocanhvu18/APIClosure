//
//  DataService.swift
//  APIClosure
//
//  Created by Ngọc Anh on 6/5/18.
//  Copyright © 2018 Ngọc Anh. All rights reserved.
//

import UIKit
class DataService {
    static let shared: DataService = DataService()
    

    // sun dung  Closure
    func loadChamps(complete: @escaping ([Champ])->Void) {
        var champs: [Champ] = []
        guard let url = URL(string: "http://infomationchampion.pe.hu/showInfo.php?index=1&number=20") else {return}
        let urlRequest = URLRequest(url: url)
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, _, error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                guard let aData = data else { return }
                
                do {
                    let result = try JSONSerialization.jsonObject(with: aData, options: .mutableContainers)
                    
                    guard let champsObj = result as? [DICT] else { return }
                    
                    for champObj in champsObj {
                        if let champ = Champ(dict: champObj) {
                            champs.append(champ)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        complete(champs)
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
                
            })
            task.resume()
        }
    }
}
