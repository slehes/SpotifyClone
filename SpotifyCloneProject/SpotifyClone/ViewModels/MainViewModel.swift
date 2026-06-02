//
//  MainViewModel.swift
//  SpotifyClone
//
//  Created by Gabriel on 9/14/21.
//

import Foundation

class MainViewModel: ObservableObject {
  private var api = MainViewModelAPICalls()
  @Published private(set) var authKey: AuthKey?
  @Published var currentPage: Page = .home
  @Published var currentPageWasRetapped = false
  @Published private(set) var homeScreenIsReady = true
  @Published var showBottomMediaPlayer = true
  @Published private(set) var currentUserProfileInfo: SpotifyModel.CurrentUserProfileInfo?
  @Published var isAuthenticated = false

  func finishAuthentication(authKey: AuthKey) {
    self.authKey = authKey
    self.isAuthenticated = true
    homeScreenIsReady = true
  }

  func getCurrentUserInfo() {
    guard let accessToken = authKey?.accessToken else { return }
    api.getCurrentUserInfo(with: accessToken) { [unowned self] userInfo in
      self.currentUserProfileInfo = userInfo
    }
  }

  func logout() {
    authKey = nil
    isAuthenticated = false
  }

  enum Page {
    case home
    case search
    case myLibrary
  }

}
