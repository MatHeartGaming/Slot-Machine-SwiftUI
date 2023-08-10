//
//  InfoView.swift
//  Slot Machine
//
//  Created by Matteo Buompastore on 10/08/23.
//

import SwiftUI

struct InfoView: View {
    
    
    //MARK: - PROPERTIES
    @AppStorage("runAnimations") private var runAnimations = true
    @State private var animate = false
    @Environment(\.presentationMode) var presentation
    
    //MARK: - BODY
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            LogoComponent()
                .scaleEffect(animate ? 1 : 0.9)
                .rotation3DEffect(.degrees(animate ? 180 : 0), axis: (x: 1, y: 0, z: 0))
                .animation(.spring(response: 0.8, dampingFraction: 0.1).repeatForever(autoreverses: true), value: animate)
            
            Spacer()
            
            Form {
                
                Section {
                    Toggle(isOn: $runAnimations) {
                        Text("Animations")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("ColorPurple"))
                            .scaleEffect(animate ? 1.1 : 1)
                            .opacity(animate ? 1 : 0.8)
                            .animation(.spring(response: 1, dampingFraction: 0.2).repeatForever(autoreverses: true), value: animate)
                    } //: PERFORMANCE SECTION
                    .onChange(of: runAnimations, perform: { newValue in
                        withAnimation {
                            runAnimations = newValue
                            animate = newValue
                        }
                    })
                    .onAppear {
                        if runAnimations {
                            animate = true
                        }
                    }
                } header: {
                    Text("Performance")
                } //: SECTION
                .font(.system(.body, design: .rounded))
                
                Section {
                    FormRowView(firstItem: "Application", secondItem: "Slot Machine")
                    FormRowView(firstItem: "Platform", secondItem: "iOS, iPadOS, MacOS")
                    FormRowView(firstItem: "Developer", secondItem: "Mat Buompy")
                    FormRowView(firstItem: "Designer", secondItem: "Mat Buompy")
                    FormRowView(firstItem: "Music", secondItem: "Dan Lebowitz")
                    FormRowView(firstItem: "Website", secondItem: "https://github.com/MatHeartGaming/Slot-Machine-SwiftUI")
                    FormRowView(firstItem: "Copyright", secondItem: "2023 All rights reserved")
                    FormRowView(firstItem: "Version", secondItem: "1.0.0")
                } header: {
                    Text("About the application")
                } //: SECTION
                .font(.system(.body, design: .rounded))
            } //: FORM
            .padding(.top, 40)
        } //: VSTACK
        .edgesIgnoringSafeArea([.horizontal, .bottom])
        .overlay(
            Button {
                //Close
                presentation.wrappedValue.dismiss()
                audioPlayer?.stop()
            } label: {
                Image(systemName: "xmark.circle")
                    .font(.title)
                    .padding(.trailing, 8)
                    .tint(.secondary)
            }, alignment: .topTrailing)
        .onAppear {
            playSound(sound: "background-music", type: "mp3")
        }
    }
}


//MARK: - ROW VIEW
struct FormRowView: View {
    
    var firstItem : String
    var secondItem : String
    
    var body: some View {
        HStack {
            Text(firstItem)
                .foregroundColor(.gray)
            Spacer()
            
            if !secondItem.starts(with: "https://") {
                Text(secondItem)
            } else {
                if let url = URL(string: secondItem) {
                    let urlLabelIndex = secondItem.index(secondItem.startIndex, offsetBy: 33)
                    Link(secondItem[..<urlLabelIndex], destination: url)
                } else {
                    Text("404 URL not found")
                        .foregroundColor(.red)
                        .fontWeight(.semibold)
                }
                
            }
        }
    }
}


//MARK: - PREVIEW
struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
            .previewLayout(.sizeThatFits)
            //.padding()
    }
}
