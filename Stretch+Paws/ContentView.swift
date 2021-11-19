//
//  ContentView.swift
//  Stretch+Paws
//
//  Created by Luke McEwan on 11/19/21.
//

import SwiftUI



struct ContentView: View {
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(named: "Secondary")
    }
    
    //constant for poses, needs to be imported and given a reference here in this file as it is coming from another file
    let poses = Poses()
    var body: some View {
        NavigationView {
            List(poses.poseData) { pose in
                NavigationLink(destination: DetailView(pose: pose)) {
                    Image(pose.icon)
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text(pose.name)
                        .fontWeight(.medium)
                        .font(.title3)
                        .padding(.leading, 20.0)
                    
                }
                .padding(5.0)
                .listRowBackground(Color("Secondary"))
            }
            .listStyle(.grouped)
            .navigationTitle("Stretch + Paws")
        }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
