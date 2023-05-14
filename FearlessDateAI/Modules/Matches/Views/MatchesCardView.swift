//
//  MatchesCardView.swift
//  FearlessDateAI
//
//  Created by Шарап Бамматов on 14.05.2023.
//

import SwiftUI

struct MatchesCardView: View {
    let user: User
    
    var body: some View {
        ZStack {
            Image(user.profilePicture ?? "")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 240)
                .cornerRadius(15)
                .overlay(alignment: .bottom) {
                    VStack(spacing: 4) {
                        HStack {
                            Text("\(user.firstName ?? "")," )
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .bold()
                            
                            Text(user.birthday ?? "")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .bold()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        
                        HStack(spacing: 35) {
                            Button {
                                
                            } label: {
                                Image(systemName: "xmark")
                            }
                            
                            RoundedRectangle(cornerRadius: 1)
                                .frame(maxWidth: 1, maxHeight: .infinity)
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "heart.fill")
                            }   
                        }
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .background(
                            BlurView(style: .systemChromeMaterialDark).opacity(0.9).cornerRadius(15)
                        )
                    }
                }
        }
    }
}

struct MatchesCardView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(Store())
    }
}
