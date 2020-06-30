//
//  VKNewsFeedWorker.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 07.05.2020.
//  Copyright (c) 2020 DamirLutfullin. All rights reserved.
//

import UIKit

class VKNewsFeedService {
    
    var authService: AuthService
    var networking: Networking
    var fetcher: DataFetcher
    
    private var revealdedPostsIds = [Int]()
    private var feedResponse: FeedResponse?
    private var newFromInProcess: String?
    
    init() {
        self.authService = SceneDelegate.shared.authService
        self.networking = NetworkService(authService: authService)
        self.fetcher = NetworkDataFetcher(networking: networking)
        
    }
    
    func getUser(completion: @escaping (UserResponse?) -> Void) {
        fetcher.getUser { (userResponse) in
            completion(userResponse)
        }
    }
    
    func getFeed(completion: @escaping ([Int], FeedResponse) -> Void) {
        fetcher.getFeed(nextBatchFrom: nil) {[weak self](feed) in
            self?.feedResponse = feed
            guard let feedResponse = self?.feedResponse else { return }
            completion(self!.revealdedPostsIds, feedResponse)
        }
    }
    
    func revealedPostIds(forPostIds postIds: Int, completion: ([Int], FeedResponse)->()) {
        revealdedPostsIds.append(postIds)
        guard let feedResponse = self.feedResponse else { return }
        completion(revealdedPostsIds, feedResponse)
    }
    
    func getNewsBatch(completion: @escaping ([Int], FeedResponse) -> Void) {
        newFromInProcess = feedResponse?.nextFrom
        fetcher.getFeed(nextBatchFrom: newFromInProcess) { [weak self] (feed) in
            guard let feed = feed else { return }
            guard self?.feedResponse?.nextFrom != feed.nextFrom else { return }
            
            if self?.feedResponse == nil {
                self?.feedResponse = feed
            } else {
                self?.feedResponse?.items.append(contentsOf: feed.items)
                self?.feedResponse?.nextFrom = feed.nextFrom
                
                var profiles = feed.profiles
                if let oldProfiles = self?.feedResponse?.profiles {
                    let oldProfileFiltered = oldProfiles.filter { (oldProfile) -> Bool in
                        !feed.profiles.contains(where: {$0.id == oldProfile.id })
                    }
                    profiles.append(contentsOf: oldProfileFiltered)
                }
                self?.feedResponse?.profiles = profiles
                
                var groups = feed.groups
                if let oldGroups = self?.feedResponse?.groups {
                    let _ = oldGroups.filter { (oldGroup) -> Bool in
                        !feed.groups.contains(where: {$0.id == oldGroup.id })
                    }
                    groups.append(contentsOf: oldGroups)
                }
                self?.feedResponse?.groups = groups
            }
            
            guard let feedResponse = self?.feedResponse else { return }
            
            completion(self!.revealdedPostsIds, feedResponse)
        }
    }
}
