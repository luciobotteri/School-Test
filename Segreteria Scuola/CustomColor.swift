//
//  CustomColor.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 21/12/23.
//

import SwiftUI

enum CustomColor {
    static let header = Color("Header")
    static func cell(_ i: Int) -> Color {
        Color("Color \(i%numberOfCellColors)")
    }
    static let background = Color("Background")
    
    static let numberOfCellColors = 6
}
