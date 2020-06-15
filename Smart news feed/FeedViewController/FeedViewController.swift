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
    
    private  let dataFetcher = NetworkDataFetcher(networking: NetworkService())
    private  let params = ["filters" : "post, photo"]
    
    @IBOutlet var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2512482107, green: 0.512022078, blue: 0.7402173281, alpha: 1)
    }
}

