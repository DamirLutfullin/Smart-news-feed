//
//  VKNewsFeedViewController.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 07.05.2020.
//  Copyright (c) 2020 DamirLutfullin. All rights reserved.
//

import UIKit

protocol VKNewsFeedDisplayLogic: class {
  func displayData(viewModel: VKNewsFeed.Model.ViewModel.ViewModelData)
}

class VKNewsFeedViewController: UIViewController, VKNewsFeedDisplayLogic {

  var interactor: VKNewsFeedBusinessLogic?
  var router: (NSObjectProtocol & VKNewsFeedRoutingLogic)?

    @IBOutlet var table: UITableView!
    
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = VKNewsFeedInteractor()
    let presenter             = VKNewsFeedPresenter()
    let router                = VKNewsFeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    table.register(UINib(nibName: "VKNewsFeedCell", bundle: nil), forCellReuseIdentifier: VKNewsFeedCell.reuseId)
  }
  
  func displayData(viewModel: VKNewsFeed.Model.ViewModel.ViewModelData) {
    switch viewModel {
    case .some:
        print("displayData from viewModel .some")
    case .displayNewsFeed:
        print("displayData from viewModel .displayNewsFeed")
    }
  }
  
}

extension VKNewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: VKNewsFeedCell.reuseId, for: indexPath) as! VKNewsFeedCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.makeRequest(request: .getFeed)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 312
    }
    
    
}
