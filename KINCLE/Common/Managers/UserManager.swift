//
//  UserManager.swift
//  KINCLE
//
//  Created by Zedd on 2020/08/22.
//  Copyright © 2020 Zedd. All rights reserved.
//

import Foundation

class UserManager {
    
    static var shared: UserManager = UserManager()
    
    var accessToken: String? {
          get { return UserDefaults.standard.string(forKey: "accessToken") }
          set { UserDefaults.standard.set(newValue, forKey: "accessToken") }
      }
      
}
