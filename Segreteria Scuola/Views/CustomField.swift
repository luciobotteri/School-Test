//
//  CustomField.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 22/12/23.
//

import SwiftUI

struct CustomField: View {
    
    @Binding var field: String
    let title: String
    
    var isValid = true
    
    var body: some View {
        VStack(alignment: .leading) {
            if !field.isEmpty {
                titleView
                    .font(.footnote)
            }
            TextField(title, text: $field)
            if isValid {
                separator
            } else {
                separator
                    .foregroundStyle(.red)
            }
        }
    }
    
    @ViewBuilder private var titleView: some View {
        if isValid {
            Text(title)
                .foregroundStyle(.secondary)
        } else {
            Text(title + " is not valid")
                .foregroundStyle(.red)
        }
    }
    
    private var separator: some View {
        Rectangle()
            .fill(.secondary)
            .frame(height: isValid ? 1 : 2)
            .padding(.bottom, 40)
    }
}
