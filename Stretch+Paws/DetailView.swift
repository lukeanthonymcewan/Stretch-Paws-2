//
//  DetailView.swift
//  Stretch+Paws
//
//  Created by Luke McEwan on 11/19/21.
//

import SwiftUI

struct DetailView: View {
    let pose : Pose
    @State private var timerOpen = false
    var body: some View {
            ZStack {
                Color("Secondary").ignoresSafeArea()
                ScrollView(showsIndicators: false){
                VStack(spacing: 20.0) {
                    Image(pose.icon)
                        .resizable()
                        .frame(width: 120, height: 120)
                    Text(pose.name)
                        .font(.system(size:36))
                        .fontWeight(.bold)
                        .foregroundColor(Color("Highlight"))
                        .multilineTextAlignment(.center)
                    Text(pose.asana)
                        .font(.system(size: 22))
                        .italic()
                        .fontWeight(.medium)

                    VStack(alignment: .leading, spacing: 20.0) {
                        Text(pose.description)
                        Text("How to:")
                            .fontWeight(.medium)
                            .foregroundColor(Color("Highlight"))
                        ForEach(pose.steps, id:\.self) {
                            step in
                            Text(step)
                        }
                        Text("Top tip:")
                            .fontWeight(.medium)
                            .foregroundColor(Color("Highlight"))
                        Text(pose.topTip)
                            .padding(.bottom, 80.0)
                    }
                    .padding(0.0)
                }
                .padding(.horizontal, 20.0)
            }
                .onTapGesture {
                    timerOpen ? (timerOpen.toggle()) : ()
                }
                TimerPanelView(timerOpen: $timerOpen)
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(pose : Pose(
            name: "Downward-Facing Dog",
            asana: "Adho Mukha Shvanasana",
            icon: "Cat-1",
            description:
            "Did someone say dog? Can't we call this a downward-facing cat instead? It's OK – this is a friendly dog, it's not interested in chasing cats. In fact, Downward-Facing Dog is the lynchpin of a yoga asana practice: if you're going to befriend with any of these poses, make sure it's this canine classic.",
            steps: ["From a kneeling position, place your hands shoulder-distance apart and spread your fingers.", "Tuck your toes and lift your hips up towards the ceiling so you create an inverted V shape.", "Balance the weight between hands and feet and think about tilting your tailbone up towards the ceiling.","Send your gaze towards your feet and breath!"],
            topTip: "Bend your knees in order to create more length through the spine." ))
    }
}

//Testing a background overlay when opening the timer area
//struct overlayBG: View {
//    var body: some View {
//        VStack {
//            Spacer()
//        }
//        .frame(width: 300, height: 500)
//        Color("Primary").ignoresSafeArea()
//            .opacity(0.3)
//
//    }
//}


struct TimerPanelView: View {
    @Binding var timerOpen: Bool
    var body: some View {
        VStack {
            Spacer()
            VStack {
                timerOpen ? AnyView(timerOpenView()) : AnyView(timerClosedView())
            }
            .frame(maxWidth: .infinity, maxHeight: timerOpen ? 400 : 80)
            .background(Color("Highlight"))
            .cornerRadius(32)
            .foregroundColor(Color("Secondary"))
        }
        .ignoresSafeArea()
        .onTapGesture {
            withAnimation(.spring()) {
                timerOpen.toggle()
            }
        }
        
    }
}

struct timerClosedView: View {
    var body: some View {
        Text("Try it out")
            .padding(40)
    }
}


struct timerOpenView: View {
    var body: some View {
        VStack {
            Text("Hold that pose!")
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            Spacer()
            Text("Try staying in this pose for 30 seconds. If you need to come out sooner, that's okay.")
            Spacer()
            Text("00:30")
                .font(.system(size: 96))
            Spacer()
            Button {
                //do something
            } label: {
                Text("Start timer")
                    .frame(width:300, height:64)
                    .background(Color("Secondary"))
                    .foregroundColor(Color("Primary"))
                    .cornerRadius(30)

            }
        }
        .padding(.all, 30)
        
    }
}
