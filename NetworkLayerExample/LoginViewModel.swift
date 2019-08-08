//
//  LoginViewModel.swift
//  NetworkLayerExample
//
//  Created by Canh Tran Wizeline on 8/7/19.
//  Copyright © 2019 Canh Tran. All rights reserved.
//

import Foundation

class LoginViewModel {
    static let shared = LoginViewModel()
    
    let authService: AuthService
    
    init(authService: AuthService = AuthServiceRepository()) {
        self.authService = authService
    }
    
    func testLogin() {
        let loginRequest = LoginRequest(username: "C67D551A-A29D-4987-86A7-C0A62B6B4B3C", password: "aefiFFUB0QQwWrzdTeN/ZiAGwkKL6HbgqwxgN75wMykF0Yg4EaPgWK/wkxmo1tc3f4zWCWHebL/VpJeHC8pxwQ==")
        let movies = authService.login(loginRequest: loginRequest).sink { (result) in
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error)
            }
        }
//        movies.cancel()
        
    }
    
    
}
