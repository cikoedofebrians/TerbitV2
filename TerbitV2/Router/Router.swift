//
//  Router.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 13/05/25.
//

import Observation

@Observable
class Router {
    var isOnRoot: Bool = true
    
    
    
    var path: [Routes] = [] {
        didSet {
            isOnRoot = path.isEmpty
        }
    }
    
    func push(_ route: Routes) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popAll() {
        path.removeAll()
    }
}
