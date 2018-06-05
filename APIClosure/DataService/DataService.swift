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
    
    
    private var _champs: [Champ]?
    var champs: [Champ] {
        get {
            if _champs == nil {
                getDataAPI()
            }
            return _champs ?? []
        }
    }
    
    func getDataAPI() {
        _champs = []
        
        guard let urlString = URL(string: "http://infomationchampion.pe.hu/showInfo.php?index=1&number=20") else {return}
        
        let urlRequest = URLRequest(url: urlString )
        DispatchQueue.global().async {
            let champs = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                
                guard error == nil else{
                    print(error!.localizedDescription)
                    return
                }
                guard let dataChampe = data else{return}
                do {
                    let result = try JSONSerialization.jsonObject(with:dataChampe , options: .mutableContainers)
                    guard let champsObject = result as? [DICT] else { return }
                    for champObj in champsObject {
                        if let champ = Champ(dict: champObj) {
                            self._champs?.append(champ)
                        }
                    }
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name.init("EndUpdateData"), object: nil)
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
                
            })
            champs.resume()
        }
    }
    
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
