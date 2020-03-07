//
//  TabBarView.swift
//  KINCLE
//
//  Created by Zedd on 2020/02/29.
//  Copyright © 2020 Zedd. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
            }
            Text("")
                .tabItem {
                    Image(systemName: "tv.fill")
                    Text("Gym")
            }
            Text("")
                .tabItem {
                    Image(systemName: "tv.fill")
                    Text("Network")
            }
            Text("")
                .tabItem {
                    Image(systemName: "tv.fill")
                    Text("Profile")
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
