//
//  Constants.swift
//  Slot Machine
//
//  Created by Matteo Buompastore on 10/08/23.
//

import SwiftUI

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height


//MARK: - CHECK DEVICE
enum UIUserInterfaceIdiom : Int {
    case unspecified
    
    case phone // iPhone and iPod touch style UI
    case pad   // iPad style UI (also includes macOS Catalyst)
}

func isiPhone() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
}

func isiPad() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}


