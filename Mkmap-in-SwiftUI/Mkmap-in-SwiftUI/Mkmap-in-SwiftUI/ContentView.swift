//
//  ContentView.swift
//  Mkmap-in-SwiftUI
//
//  Created by Colantonio Raffaele on 24/03/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        We can reclaim MapView() as a normal SwiftUI View
MapView()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
