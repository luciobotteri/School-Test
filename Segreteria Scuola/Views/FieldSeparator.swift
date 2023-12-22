//
//  CustomField.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 22/12/23.
//

import SwiftUI

struct CustomField: View {
    var body: some View {
        separator
    }
    
    private var separator: some View {
        Rectangle()
            .fill(.secondary)
            .frame(height: 1)
            .padding(.bottom, 40)
    }
}

#Preview {
    CustomField()
}
