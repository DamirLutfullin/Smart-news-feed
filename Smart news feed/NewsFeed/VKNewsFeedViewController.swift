//
//  VKNewsFeedViewController.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 07.05.2020.
//  Copyright (c) 2020 DamirLutfullin. All rights reserved.
//

import UIKit

protocol VKNewsFeedDisplayLogic: AnyObject {
    func displayData(viewModel: VKNewsFeed.Model.ViewModel.ViewModelData)
}

class VKNewsFeedViewController: UIViewController, VKNewsFeedDisplayLogic {
    
  var interactor: VKNewsFeedBusinessLogic?
  var router: (NSObjectProtocol & VKNewsFeedRoutingLogic)?
    private var feedViewModel = FeedViewModel(cells: [], footerTitle: nil)
    private var titleView = TitleView()
    private lazy var footerView = FooterView()
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
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
    setupTableView()
    
    interactor?.makeRequest(request: .getNewsFeed)
    interactor?.makeRequest(request: .getUserPhotoUrl)
    }
    
    private func setupTopBars() {
        let rectForTopBar = view.window?.windowScene?.statusBarManager?.statusBarFrame
        let topBar = UIView(frame: rectForTopBar ?? CGRect.zero)
        self.view.addSubview(topBar)
        topBar.backgroundColor = .white
        topBar.layer.shadowColor = UIColor.black.cgColor
        topBar.layer.shadowOpacity = 0.3
        topBar.layer.shadowOffset = CGSize.zero
        topBar.layer.shadowRadius = 8
        self.navigationController?.hidesBarsOnSwipe = true // скрываем бар при листании вниз
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.titleView = titleView
        
        
    }
    
    @objc private func refresh() {
        interactor?.makeRequest(request: .getNewsFeed)
    }
    
    private func setupTableView() {
        table.register(UINib(nibName: "VKNewsFeedCell", bundle: nil), forCellReuseIdentifier: VKNewsFeedCell.reuseId)
        table.register(NewsFeedCodeCell.self, forCellReuseIdentifier: NewsFeedCodeCell.reuseId)
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.refreshControl = refreshControl
        table.tableFooterView = footerView
    }
    
    func displayData(viewModel: VKNewsFeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayNewsFeed(feedViewModel: let feedViewModel):
            self.feedViewModel = feedViewModel
            table.reloadData()
            footerView.setTitle(title: feedViewModel.footerTitle)
            refreshControl.endRefreshing()
        case .displayUsersPhoto(photoUrl: let photoUrl):
            print(".displayUsersPhoto")
            self.titleView.myAvatarView.set(imageURL: photoUrl)
        case .displayFooterLoader:
            footerView.showLoader()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
            interactor?.makeRequest(request: .getNewsBatch)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCodeCell.reuseId, for: indexPath) as! NewsFeedCodeCell
        cell.showFullTextDelegate = self
        cell.set(viewModel: feedViewModel.cells[indexPath.row])
        cell.backgroundColor = .clear
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        feedViewModel.cells[indexPath.row].sizes.totalHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         feedViewModel.cells[indexPath.row].sizes.totalHeight
    }
}
