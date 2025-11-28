//
//  ContentView.swift
//  AtlysProject
//
//  Created by Keertika on 28/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            CarouselView(images: ["Canada", "Tokyo", "London", "HongKong", "Paris"])

            Text("Get Visas On Time")
                .font(.largeTitle)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
