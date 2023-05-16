//
//  ProfileView.swift
//  FearlessDateAI
//
//  Created by Шарап Бамматов on 16.05.2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color.redColor
            
            VStack {
                VStack(spacing: 24) {
                    Spacer()
                        .frame(height: 0)
                    
                    avatar
                    
                    nameAndAgo
                    
                    HStack(spacing: 32) {
                        ProfileButton(imageName: "gearshape", title: "Settings", width: 45, action: {})
                        
                        editButton
                        
                        ProfileButton(imageName: "shield.fill", title: "Safery", width: 35, action: {})
                    }
                    .frame(maxWidth: .infinity)
                    
                    Spacer()
                        .frame(height: 50)
                }
                .background(Color.white.ignoresSafeArea())
                .clipShape(RoundedShape(corners: [.bottomRight, .bottomLeft]))
                
                Spacer()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
        
        MainTabView()
            .environmentObject(Store())
    }
}

extension ProfileView {
    private var avatar: some View {
        Image("girl1")
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
            .clipShape(Circle())
            .background(
                Circle()
                    .fill(Color.redColor)
                    .frame(width: 215, height: 215)
                    .shadow(color: Color.redColor.opacity(0.5), radius: 20, x: 0, y: 0)
            )
    }
    private var nameAndAgo: some View {
        HStack {
            Text("Pablo Escobar, ") +
            Text("33")
        }
        .font(.title)
        .bold()
    }
    private var editButton: some View {
        VStack {
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(.redColor)
                .overlay {
                    Image(systemName: "highlighter")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                }
                .shadow(color: .redColor.opacity(1), radius: 10, x: 0, y: 0)
            
            Text("Edit profile")
                .font(.title2)
                .bold()
        }
        .offset(y: 30)
    }
}

