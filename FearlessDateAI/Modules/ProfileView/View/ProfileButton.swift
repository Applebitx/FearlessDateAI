//
//  ProfileButton.swift
//  FearlessDateAI
//
//  Created by Шарап Бамматов on 16.05.2023.
//

import SwiftUI

struct ProfileButton: View {
    let imageName: String
    let title: String
    let width: CGFloat
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Circle()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
                    .overlay {
                        Image(systemName: imageName)
                            .resizable()
                            .frame(width: width, height: 45)
                            .foregroundColor(.redColor)
                    }
                    .shadow(color: .black.opacity(0.2), radius: 3, x: 2, y: 0)
                
                Text(title)
                    .font(.title2)
                    .bold()
            }
        }
        .buttonStyle(.plain)
    }
}

struct ProfileButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileButton(imageName: "", title: "", width: 0, action: {})
    }
}
