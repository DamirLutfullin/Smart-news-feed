//
//  FeedViewController.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 06.05.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    
    let networkService = NetworkService()
    let params = ["filters" : "post, photo"]
    
    @IBOutlet var mainLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2512482107, green: 0.512022078, blue: 0.7402173281, alpha: 1)
        networkService.request(path: VKAPI.newsFeed, params: params) { (data, error) in
            switch error {
            case .none:
                print("Ошибка при networkService.request case .none, ошибка: " + (error?.localizedDescription ?? "отсутствует"))
            case .some(_):
                print("Ошибка при networkService.request case .some, ошибка: " + (error?.localizedDescription ?? "отсутствует"))
            }
            guard let data = data else { print("data is nil"); return }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print(json)
            
        }
    }
}
