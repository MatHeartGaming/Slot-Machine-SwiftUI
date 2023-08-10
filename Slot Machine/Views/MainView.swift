//
//  MainView.swift
//  Slot Machine
//
//  Created by Matteo Buompastore on 10/08/23.
//

import SwiftUI

struct MainView: View {
    
    //MARK: - PROPERTIES
    let haptics = UINotificationFeedbackGenerator()
    @State private var showInfoView = false
    
    // - SAVE HIGHSCORE INTO USER DEFAULTS
    @AppStorage("highscore") private var highscore : Int = 0
    //Enable Animations
    @AppStorage("runAnimations") private var runAnimations = true
    
    @State private var reels = [0, 1, 2]
    @State private var coins : Int = 100
    @State private var betAmount : Int = 10
    @State private var showModal = false
    @State private var animateSymbol = false
    @State private var animatingModal = false
    private let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
    
    //MARK: - FUNCTIONS
    
    // 1. SPIN THE REELS
    private func spinReels() {
//        reels[0] = Int.random(in: 0...symbols.count - 1)
//        reels[1] = Int.random(in: 0...symbols.count - 1)
//        reels[2] = Int.random(in: 0...symbols.count - 1)
        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count - 1)
        })
        playSound(sound: "spin", type: "mp3")
        /*for i in 0 ..< reels.count {
            reels[i] = Int.random(in: 0...symbols.count - 1)
        }*/
    }
    
    // 2. CHECK WHO WINS
    private func checkWinning() {
        if reels[0] == reels[1] && reels[1] == reels[2] {
            //PLAYER WINS
            playerWins()
            //NEW HIGHSCORE
            newHighScore()
        } else {
            //PLAYER LOSES
            playerLoses()
        }
    }
    
    // 3. NEW HIGHSCORE UPDATE
    private func newHighScore() {
        if coins > highscore {
            highscore = coins
            playSound(sound: "high-score", type: "mp3")
            haptics.notificationOccurred(.success)
        } else {
            playSound(sound: "win", type: "mp3")
            haptics.notificationOccurred(.success)
        }
    }
    
    // 4. GAME IS OVER
    func isGameOveR() {
        if coins <= 0 {
            //Show modal
            showModal = true
            playSound(sound: "game-over", type: "mp3")
            haptics.notificationOccurred(.error)
        }
    }
    
    
    private func playerWins() {
        coins += betAmount * 10
    }
    
    private func playerLoses() {
        coins -= betAmount
    }
    
    func betAmount10() {
        if coins >= 10 {
            betAmount = 10
            playSound(sound: "casino-chips", type: "mp3")
            haptics.notificationOccurred(.success)
        }
    }
    
    func betAmount20() {
        if coins >= 20 {
            betAmount = 20
            playSound(sound: "casino-chips", type: "mp3")
            haptics.notificationOccurred(.success)
        }
    }
    
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
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    } //: HSTACK
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack {
                        Text("\(highscore)")
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
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                            .opacity(animateSymbol ? 1 : 0)
                            .offset(y: animateSymbol ? 0 : -50)
                            .animation(.easeOut.delay(Double.random(in: 0.1...0.8)), value: animateSymbol)
                    } //: ZSTACK
                    
                    //MARK: - REEL 2
                    HStack(alignment: .center, spacing: 0) {
                        ZStack {
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animateSymbol ? 1 : 0)
                                .offset(y: animateSymbol ? 0 : -50)
                                .animation(.easeOut.delay(Double.random(in: 0.1...0.8)), value: animateSymbol)
                        } //: ZSTACK
                        
                        Spacer()
                        
                        //MARK: - REEL 3
                        ZStack {
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animateSymbol ? 1 : 0)
                                .offset(y: animateSymbol ? 0 : -50)
                                .animation(.easeOut.delay(Double.random(in: 0.1...0.8)), value: animateSymbol)
                        } //: ZSTACK
                        
                    } //: HSTACK
                    .frame(maxWidth: 500)
                    
                    //MARK: - SPIN BUTTON
                    Button {
                        // 1. Disable animation
                        withAnimation {
                            animateSymbol = false
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            spinReels()
                            
                            // 2. Trigger Animation
                            withAnimation {
                                //SPIN
                                animateSymbol = true
                            }
                            
                            
                            //WINNING
                            checkWinning()
                            
                            //GAME OVER
                            isGameOveR()
                        }
                    } label: {
                        Image("gfx-spin")
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                    
                    
                } //: Slot Machine VSTACK
                .layoutPriority(2)
                .onAppear {
                    animateSymbol = true
                    playSound(sound: "riseup", type: "mp3")
                }
                
                Spacer()
                
                //MARK: - FOOTER
                HStack(alignment: .center, spacing: 10) {
                    
                    //MARK: - BET 20
                    HStack {
                        Button {
                            print("Bet 20 coins")
                            betAmount20()
                        } label: {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(betAmount == 20 ? .yellow : .white)
                                .modifier(BetNumberModifier())
                                .opacity(coins >= 20 ? 1 : 0.3)
                        } //: BUTTON
                        .modifier(BetCapsuleModifier())
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .modifier(CasinoChipsModifier())
                            //.opacity(betAmount == 20 ? 1 : 0)
                            .offset(x: betAmount == 20 ? 0 : screenWidth / (isiPhone() ? 4 : 2))
                            .animation(.spring(response: 0.5, dampingFraction: 0.4), value: betAmount == 20)
                        
                    } //: HSTACK
                    
                    Spacer()
                    
                    //MARK: - BET 10
                    HStack {
                        /*Image("gfx-casino-chips")
                            .resizable()
                            .modifier(CasinoChipsModifier())
                            .opacity(betAmount == 10 ? 1 : 0)
                            .animation(.spring(response: 0.5, dampingFraction: 0.6), value: betAmount == 10)*/
                        
                        Spacer()
                        
                        Button {
                            print("Bet 10 coins")
                            betAmount10()
                        } label: {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(betAmount == 10 ? .yellow : .white)
                                .modifier(BetNumberModifier())
                                .opacity(coins >= 10 ? 1 : 0.3)
                        } //: BUTTON
                        .modifier(BetCapsuleModifier())
                        
                    } //: HSTACK
                    
                } //: HSTACK
                
            } //: VSTACK
            .overlay(
                //RESET
                Button(action: {
                    print("Reset game")
                    highscore = 0
                    playSound(sound: "chimeup", type: "mp3")
                }, label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                })
                .modifier(ButtonModifier()), alignment: .topLeading)
            .overlay(
                //RESET
                Button(action: {
                    print("Info View")
                    showInfoView = true
                }, label: {
                    Image(systemName: "info.circle")
                })
                .modifier(ButtonModifier()), alignment: .topTrailing)
            .padding()
            .padding(.top, 32)
            .frame(maxWidth: 720)
            .blur(radius: showModal ? 5 : 0, opaque: false)
            
            //MARK: - POPUP
            if showModal {
                ZStack {
                    Color("ColorTransparentBlack")
                    
                    //MODAL
                    VStack(spacing: 0) {
                        Text("Game Over")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        //MESSAGE
                        VStack(alignment: .center, spacing: 16) {
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            
                            Text("Bad Luck! You lost all the coins. \nLet's play again!")
                                .font(.system(.body, design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .layoutPriority(1)
                            
                            Button {
                                withAnimation(.spring()) {
                                    showModal = false
                                    coins = 100
                                    animatingModal = false
                                }
                            } label: {
                                Text("New Game".uppercased())
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .tint(Color("ColorPink"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 128)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundColor(Color("ColorPink"))
                                    )
                            }

                            
                        } //: VSTACK
                        
                        Spacer()
                    }
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 6, x: 0, y: 8)
                    .opacity(animatingModal ? 1 : 0)
                    .offset(y: animatingModal ? 0 : -100)
                    .animation(.spring(response: 0.6, dampingFraction: 1, blendDuration: 1), value: animatingModal)
                    .onAppear {
                        animatingModal = true
                    }
                } //: ZSTACK
            }
            
        } //: ZSTACK
        .ignoresSafeArea()
        .sheet(isPresented: $showInfoView) {
            InfoView()
        }
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
