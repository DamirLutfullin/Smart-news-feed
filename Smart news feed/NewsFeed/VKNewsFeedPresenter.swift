//
//  VKNewsFeedPresenter.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 07.05.2020.
//  Copyright (c) 2020 DamirLutfullin. All rights reserved.
//

import UIKit

protocol VKNewsFeedPresentationLogic {
  func presentData(response: VKNewsFeed.Model.Response.ResponseType)
}

class VKNewsFeedPresenter: VKNewsFeedPresentationLogic {
  weak var viewController: VKNewsFeedDisplayLogic?
  
  func presentData(response: VKNewsFeed.Model.Response.ResponseType) {
    switch response {
    case .some:
        print("presentor .some")
    case .presentNewsFeed:
         print("presentor .presentNewsFeed")
         viewController?.displayData(viewModel: .displayNewsFeed)
    }
  }
  
}
