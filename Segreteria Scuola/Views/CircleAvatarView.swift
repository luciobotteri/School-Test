//
//  CircleAvatarView.swift
//  Segreteria Scuola
//
//  Created by Lucio Botteri on 21/12/23.
//

import SwiftUI

struct CircleAvatarView: View {
    
    let urlString: String?
    
    var url: URL? {
        if let urlString {
            URL(string: urlString)
        } else {
            nil
        }
    }
    
    var body: some View {
        avatar
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
    }
    
    @ViewBuilder private var avatar: some View {
        if let url {
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
        } else {
            Image(systemName: "person.circle")
                .resizable()
        }
    }
}

#Preview {
    CircleAvatarView(urlString: "")
        .frame(width: 150, height: 150)
}
