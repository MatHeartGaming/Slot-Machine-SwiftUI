//
//  ShadowModifier.swift
//  Slot Machine
//
//  Created by Matteo Buompastore on 10/08/23.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    
    var shadowRadius : CGFloat = 4
    
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("ColorTransparentBlack"), radius: shadowRadius, x: 0, y: 6)
    }
    
}

struct ButtonModifier : ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .tint(.white)
    }
    
}

struct ScoreNumberModifier : ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .modifier(ShadowModifier())
            .layoutPriority(1)
    }
    
}

struct ScoreContainerModifier : ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 4)
            .padding(.horizontal, 16)
            .frame(minWidth: 128)
            .background(
                Capsule()
                    .foregroundColor(Color("ColorTransparentBlack"))
            )
    }
    
}

struct ImageModifier : ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 140, idealWidth: 200, maxWidth: 220, minHeight: 130, idealHeight: 200, maxHeight: 220)
            .modifier(ShadowModifier())
    }
    
}
