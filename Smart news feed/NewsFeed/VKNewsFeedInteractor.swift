//
//  VKNewsFeedInteractor.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 07.05.2020.
//  Copyright (c) 2020 DamirLutfullin. All rights reserved.
//

import UIKit

protocol VKNewsFeedBusinessLogic {
  func makeRequest(request: VKNewsFeed.Model.Request.RequestType)
}

class VKNewsFeedInteractor: VKNewsFeedBusinessLogic {

  var presenter: VKNewsFeedPresentationLogic?
  var service: VKNewsFeedService?
  
  func makeRequest(request: VKNewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = VKNewsFeedService()
    }
    switch request {
    case .some:
        print("interactor.some")
    case .getFeed:
        print("interactor .getFeed")
        presenter?.presentData(response: .presentNewsFeed)
    }
  }
  
}
