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
    private var feedViewModel = FeedViewModel(cells: [])
    private var titleView = TitleView()
    
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
    setupTopBars()
    table.register(UINib(nibName: "VKNewsFeedCell", bundle: nil), forCellReuseIdentifier: VKNewsFeedCell.reuseId)
    table.register(NewsFeedCodeCell.self, forCellReuseIdentifier: NewsFeedCodeCell.reuseId)
    table.separatorStyle = .none
    table.backgroundColor = .clear
    view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
    
    interactor?.makeRequest(request: .getNewsFeed)
    interactor?.makeRequest(request: .getUserPhotoUrl)
    }
    
    private func setupTopBars() {
        self.navigationController?.hidesBarsOnSwipe = true // скрываем бар при листании вниз
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.titleView = titleView
    }
    
    func displayData(viewModel: VKNewsFeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayNewsFeed(feedViewModel: let feedViewModel):
            self.feedViewModel = feedViewModel
            table.reloadData()
        case .displayUsersPhoto(photoUrl: let photoUrl):
            print(".displayUsersPhoto")
            self.titleView.myAvatarView.set(imageURL: photoUrl)
        }
    }
}

extension VKNewsFeedViewController: UITableViewDelegate, UITableViewDataSource, ShowFullTextButtonDelegate {
    
    func revealText(cell: NewsFeedCodeCell) {
        guard let indexPath = table.indexPath(for: cell) else { return }
        let cellViewModel = feedViewModel.cells[indexPath.row]
        interactor?.makeRequest(request: .revealCellFromPostId(postId: cellViewModel.postId))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = table.dequeueReusableCell(withIdentifier: VKNewsFeedCell.reuseId, for: indexPath) as! VKNewsFeedCell
//        cell.set(viewModel: feedViewModel.cells[indexPath.row])
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCodeCell.reuseId, for: indexPath) as! NewsFeedCodeCell
        cell.showFullTextDelegate = self
        cell.set(viewModel: feedViewModel.cells[indexPath.row])
        cell.backgroundColor = .clear
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cellViewModel = feedViewModel.cells[indexPath.row]
//        return cellViewModel.sizes.totalHeight
        feedViewModel.cells[indexPath.row].sizes.totalHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         feedViewModel.cells[indexPath.row].sizes.totalHeight
    }
}
