//
//  HomeView.swift
//  KINCLE
//
//  Created by Zedd on 2020/02/29.
//  Copyright © 2020 Zedd. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State var users = ["Hohyeon", "Gomin", "Durup"]

    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.self) { user in
                    Text(user)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct FeedView: View {
    
    @State var url: String
    var body: some View {
        Text("dd")
    }
}
