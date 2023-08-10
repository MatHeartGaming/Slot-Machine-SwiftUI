//
//  MainView.swift
//  Slot Machine
//
//  Created by Matteo Buompastore on 10/08/23.
//

import SwiftUI

struct MainView: View {
    
    //MARK: - PROPERTIES
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            
            //MARK: - BACKGROUND
            LinearGradient(colors: [Color("ColorPink"), Color("ColorPurple")], startPoint: .top, endPoint: .bottom)
            
            //MARK: - INTERFACE
            VStack(alignment: .center, spacing: 5) {
                Text("")
                
                //MARK: - HEADER
                LogoComponent()
                Spacer()
                
                //MARK: - SCORE
                HStack {
                    HStack {
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        Text("100")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    } //: HSTACK
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack {
                        Text("200")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                    } //: HSTACK
                    .modifier(ScoreContainerModifier())
                } //: HSTACK
                
                
                Spacer()
                
                //MARK: - SLOT MACHINE
                VStack(alignment: .center, spacing: 0) {
                    //MARK: - REEL 1
                    ZStack {
                        ReelView()
                        Image("gfx-bell")
                            .resizable()
                            .modifier(ImageModifier())
                    } //: ZSTACK
                    
                    //MARK: - REEL 2
                    HStack(alignment: .center, spacing: 0) {
                        ZStack {
                            ReelView()
                            Image("gfx-seven")
                                .resizable()
                                .modifier(ImageModifier())
                        } //: ZSTACK
                        
                        Spacer()
                        
                        //MARK: - REEL 3
                        ZStack {
                            ReelView()
                            Image("gfx-cherry")
                                .resizable()
                                .modifier(ImageModifier())
                        } //: ZSTACK
                        
                    } //: HSTACK
                    .frame(maxWidth: 500)
                    
                    //MARK: - SPIN BUTTON
                    Button {
                        print("Spin the reels")
                    } label: {
                        Image("gfx-spin")
                            .resizable()
                            .modifier(ImageModifier())
                    }

                    
                    
                } //: Slot Machine VSTACK
                .layoutPriority(2)
                
                //MARK: - FOOTER
                
            } //: VSTACK
            .overlay(
                //RESET
                Button(action: {
                    print("Reset game")
                }, label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                })
                .modifier(ButtonModifier()), alignment: .topLeading)
            .overlay(
                //RESET
                Button(action: {
                    print("Info View")
                }, label: {
                    Image(systemName: "info.circle")
                })
                .modifier(ButtonModifier()), alignment: .topTrailing)
            .padding()
            .padding(.top, 32)
            .frame(maxWidth: 720)
            
            //MARK: - POPUP
            
        } //: ZSTACK
        .ignoresSafeArea()
    }
}


//MARK: - PREVIEW
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewLayout(.sizeThatFits)
            //.padding()
    }
}
