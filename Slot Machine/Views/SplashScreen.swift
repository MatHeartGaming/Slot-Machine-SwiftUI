//
//  SplashScreen.swift
//  Slot Machine
//
//  Created by Matteo Buompastore on 10/08/23.
//

import SwiftUI

struct SplashScreen: View {
    
    //MARK: - PROPERTIES
    @State private var isPulsating = false
    
    //MARK: - BODY
    var body: some View {
        ZStack(alignment: .center) {
            Image("gfx-background")
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth, height: screenHeight)
            
            Image("gfx-slot-machine")
                .resizable()
                .scaledToFit()
                .padding(48)
                .scaleEffect(isPulsating ? 1.1 : 0.9)
                .animation(.spring(response: 1, dampingFraction: 1, blendDuration: 0.5).repeatForever(autoreverses: true), value: isPulsating)
            
        }
        .ignoresSafeArea()
        .onAppear {
            isPulsating = true
        }
    }
}


//MARK: - PREVIEW
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
