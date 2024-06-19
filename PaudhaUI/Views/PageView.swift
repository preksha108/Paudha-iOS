//
//  PageView.swift
//  PaudhaUI
//
//  Created by user1 on 05/03/24.
//

import SwiftUI

struct PageView: View {
    var page: Page
    
    var body: some View {
        VStack(spacing: 10) {
            Image("\(page.imageUrl)")
                .resizable()
                .frame(width: 230,height: 200)
                .padding()
                .padding()
            
            Text(page.name)
                .font(.title)
            Text(page.description)
                .font(.subheadline)
                .frame(width: 300).multilineTextAlignment(.center)
        }
    }
}

